module cubic (
    output reg Img_CEN,
    output reg [13:0] Img_A,
    output reg Result_CEN,
    output reg Result_WEN,
    output reg [7:0]Result_D,
    output reg [13:0] Result_A,
	output reg done,
    input clk,
    input rst,
    input enable,
    input [7:0] x0,
    input [7:0] y0,
    input [7:0] original_w,
    input [7:0] original_h,
    input [7:0] scaled_w,
    input [7:0] scaled_h,
    input [7:0]Img_Q,
	input [7:0]Result_Q
);

parameter [2:0] START = 3'd0, IDLE = 3'd1, CHECK_CALC = 3'd2, GET_DATA = 3'd3, X_IN = 3'd4, WRITE_DATA = 3'd5, NO_CALC = 3'd6, DONE = 3'd7;
reg data_ready;
reg [2:0] state, nextstate;
reg [7:0]x, RAM_X_ctn, X_p0;
reg [7:0]y;
reg [2:0]interval_cnt;
reg [7:0]fill_data;
reg [2:0] X_in_ctn;
reg [2:0]get_data_ctn;

reg signed[29:0] temp_fill_data;                              //signed bit [29], [28:17] integer, [16:0] decimal
reg signed [17:0]X_in_val, x_square;                          //sigend bit [17], [16]    integer, [15:0] decimal
reg signed [35:0]temp_x_square;                               //signed bit [35], [34:32] integer,  [31:0] decimal

reg signed [9:0] p_1, p0, p1, p2;                             //signed bit  [9], [8:1]  integer, [0] decimal
wire signed [11:0] a, b, c, d;                                //signed bit [11], [10:1] integer, [0] decimal
wire signed [27:0] shift_d;

assign a = -(p_1 >> 1) + p0 + (p0 >> 1) - p1 - (p1 >> 1) + (p2 >> 1);        //a = -1/2p(-1) + 3/2p(0) - 3/2p(1) + 1/2p(2) 
assign b = p_1 - (p0 << 1) - (p0 >> 1) + (p1 << 1) - (p2 >> 1);              //b = p(-1) - 5/2p(0) +2p(1) - 1/2p(2)
assign c = - (p_1 >> 1) + (p1 >> 1);                                         //c = -1/2p(-1) + 1/2p(1)
assign d = p0;                                                               //d = p(0)

assign shift_d = d << 16;

//assign done = (state == DONE);

//FSM
always @(posedge clk) begin
    if(rst) begin
        state <= START;
    end else begin
        state <= nextstate;
    end
end

//state transition
always @(*) begin
    case(state) 
        START: begin
            if(enable) nextstate = IDLE;
            else nextstate = START;
        end
        IDLE: begin
            if(y == 8'd30) nextstate = DONE;
            else nextstate = CHECK_CALC;
        end
        CHECK_CALC: begin
            if(interval_cnt == 3'd0) nextstate = NO_CALC;
            else nextstate = GET_DATA;
        end
        GET_DATA: begin
            if(get_data_ctn == 3'd4) nextstate = X_IN;
            else nextstate = GET_DATA;
        end
        X_IN: begin
            if(X_in_ctn == 3'd5) nextstate = WRITE_DATA;
            else nextstate = X_IN;
        end
        NO_CALC : begin
            if(data_ready) nextstate = WRITE_DATA;
            else nextstate = NO_CALC;
        end
        WRITE_DATA: nextstate = IDLE;
        DONE: nextstate = DONE; 
        //default: nextstate = IDLE;
    endcase
end

always @(*) begin
    if(state == X_IN) begin
        case(interval_cnt)
            3'd1: X_in_val = 18'b000110011001100110;                  //0.4
            3'd2: X_in_val = 18'b001100110011001100;                  //0.8
            3'd3: X_in_val = 18'b000011001100110011;                  //0.2
            3'd4: X_in_val = 18'b001001100110011001;                  //0.6
            default: X_in_val = 18'd0;
        endcase
    end
    else X_in_val = 18'd0;
end

//state action
always @(posedge clk) begin
    if(rst) begin
        x <= 8'd0;
        y <= 8'd0;
        interval_cnt <= 3'd0;
        RAM_X_ctn <= 8'd2;
        X_p0 <= 8'd0;
        Img_CEN <= 1'b1;
        p_1 <= 10'd0;
        p0 <= 10'd0;
        p1 <= 10'd0;
        p2 <= 10'd0;
        Img_A <= 14'd0;
        X_in_ctn <= 3'd0;
        temp_x_square <= 36'd0;
        temp_fill_data <= 30'd0;
        fill_data <= 8'd0;
        get_data_ctn <= 3'd0;
        data_ready <= 1'b0;
        Result_D <= 8'd0;
        Result_WEN <= 1'b1;
        Result_CEN <= 1'b1; 
	done <= 1'b0;
    end
    begin
        case(state)
            IDLE: begin
                Result_WEN <= 1'b1;                 //result read
                Img_CEN <= 1'b1;                    //0 RAM read enable
            end
            CHECK_CALC: begin
                Img_CEN <= 1'b0;
                case(interval_cnt) 
                    3'd0: begin
                        if(RAM_X_ctn >= 8'd25) RAM_X_ctn <= 8'd2;
                        Img_A <=  (y << 4) + (y << 3) + (y << 2) + y + RAM_X_ctn;
                        X_p0 <= RAM_X_ctn;
                    end
                    3'd1: begin
                        Img_A <=  (y << 4) + (y << 3) + (y << 2) + y + RAM_X_ctn;
                        X_p0 <= RAM_X_ctn;
                    end
                    3'd2: begin
                        RAM_X_ctn <= RAM_X_ctn + 8'd1;
                        X_p0 <= RAM_X_ctn;
                        Img_A <=  (y << 4) + (y << 3) + (y << 2) + y + RAM_X_ctn;
                    end
                    3'd3: begin
                        X_p0 <= RAM_X_ctn;
                        Img_A <=  (y << 4) + (y << 3) + (y << 2) + y + RAM_X_ctn;
                    end
                    3'd4: begin
                        RAM_X_ctn <= RAM_X_ctn + 8'd1;
                        X_p0 <= RAM_X_ctn;
                        Img_A <=  (y  << 4) + (y << 3) + (y << 2) + y + RAM_X_ctn;
                    end
                endcase
            end
            GET_DATA: begin
                case(get_data_ctn)
                    3'd0: begin
                        Img_A <=  (y << 4) + (y << 3) + (y << 2) + y + (X_p0 - 1);
                    end
                    3'd1: begin
                        p0 <= {1'd0, Img_Q, 1'd0};
                        Img_A <=  (y << 4) + (y << 3) + (y << 2) + y + (X_p0 + 1);
                    end
                    3'd2: begin
                        p_1 <= {1'd0, Img_Q, 1'd0};
                        Img_A <=  (y << 4) + (y << 3) + (y << 2) + y + (X_p0 + 2);
                    end
                    3'd3: begin
                        p1 <= {1'd0, Img_Q, 1'd0};
                    end
                    3'd4: begin
                        p2 <= {1'd0, Img_Q, 1'd0};
                    end
                endcase
                if(get_data_ctn == 3'd4) get_data_ctn <= 3'd0;
                else get_data_ctn <= get_data_ctn + 3'd1; 
            end
            X_IN: begin
                //fill ax^3 + bx^2 + cx + d
                case(X_in_ctn)
                    3'd0: begin
                        temp_x_square <= X_in_val * X_in_val;
                        temp_fill_data <= 30'd0;            
                    end
                    3'd1: begin
                        x_square <= {temp_x_square[35], temp_x_square[32], temp_x_square[31:16]};
                        temp_fill_data <= temp_fill_data + shift_d;
                    end
                    3'd2: begin
                        //x^3
                        temp_x_square <= x_square * X_in_val;
                        temp_fill_data <= temp_fill_data + (c * X_in_val); 
                    end
                    3'd3:begin
                        temp_fill_data <= temp_fill_data + (b * x_square);
                        x_square <= {temp_x_square[35], temp_x_square[32], temp_x_square[31:16]};
                    end
                    3'd4: begin
                        temp_fill_data <= temp_fill_data + (a * x_square);
                    end
                    3'd5: begin
                        if(temp_fill_data[29] == 1'd1) fill_data <= 8'd0;                                      //negative
                        else if(temp_fill_data[28:17] >= 12'd255) fill_data <= 8'd255;                          //overflow
                        else if(temp_fill_data[16] == 1'd1) fill_data <= temp_fill_data[24:17] + 8'd1;         //round up
                        else fill_data <= temp_fill_data[24:17];
                        Result_A <= (y  << 5) + (y << 4) + (y << 3) + (y << 2) + y + x;                         //y * 61 + x
        
                        Result_WEN <= 1'b0;             //0 write/ 1 read
                        Result_CEN <= 1'b1;             //active result
                        end
		    default: begin			//will not enter this
			temp_fill_data <= 30'd0; 	
			end
                endcase

                if(X_in_ctn == 3'd5) X_in_ctn <= 3'd0;
                else X_in_ctn <= X_in_ctn + 3'd1;
            end
            NO_CALC: begin
                if(!data_ready) begin
                    data_ready <= 1'b1;
                    Result_A <= (y  << 5) + (y << 4) + (y << 3) + (y << 2) + y + x;             //y * 61 + x
                end
                else begin
                    data_ready <= 1'b0;
                    fill_data <= Img_Q;
                end
            end
            WRITE_DATA : begin
                Result_D <= fill_data;
                Result_WEN <= 1'b0;             //0 write/ 1 read
                Result_CEN <= 1'b0;             //result active low
                if(x == 8'd60)  begin
                    x <= 8'd0;
                    y <= y + 8'd1;
                end
                else  x <= x + 8'd1;

                if(interval_cnt == 3'd4 || x == 8'd60) interval_cnt <= 3'd0;
                else interval_cnt <= interval_cnt + 3'd1;
            end
	    DONE: begin
	    	done <= 1'b1;
	    end
        endcase
    end
end


endmodule

