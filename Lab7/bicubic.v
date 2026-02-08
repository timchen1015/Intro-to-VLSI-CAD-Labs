module bicubic (
    output reg Img_CEN,
    output reg [13:0] Img_A,
    output reg Result_CEN,
    output reg Result_WEN,
    output reg [7:0]Result_D,
    output reg [15:0] Result_A,
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
	input [31:0] Img_Q,
	input [7:0] Result_Q
);

integer i;
parameter [3:0] START = 4'd0, IDLE = 4'd1, CHECK_VH = 4'd2, VH_DONE = 4'd3, H_CAL = 4'd4, V_CAL = 4'd5, LOAD = 4'd6, STORE_BI = 4'd7, LOAD_BI = 4'd8, X_IN = 4'd9, Y_IN = 4'd10, VH_DONE_GETDATA = 4'd11, WRITE_DATA = 4'd12, DONE = 4'd13;

reg [3:0] state, nextstate;                //state register     
reg [2:0]get_data_ctn;
reg [2:0] X_in_ctn;                        //X_in counter
reg data_ready;                            //signal for VH_DONE state
reg [7:0]pixel_Gray;                       //gray pixel data
reg [7:0]fill_data;                        //fill data for image RAM
reg [7:0] biq_arr[3:0];                    //bi cubic array
reg [1:0] bicubic_index;                   //bi cubic index for 4 pixels
reg bicubic_flag;                          //bicubic flag for bicubic interpolation

wire [7:0]R, G, B;                         //RGB data from image
assign R = Img_Q[23:16];
assign G = Img_Q[15:8];
assign B = Img_Q[7:0];

reg [7:0] addr_x,addr_y;
wire [35:0] h_on_expand = ({addr_x,20'd0} * (original_w - 1)) / (scaled_w - 1);         //[27:20] integer, [19:0] float
wire [35:0] v_on_expand = ({addr_y,20'd0} * (original_h - 1)) / (scaled_h - 1);         //[27:20] integer, [19:0] float   
wire [7:0] h_addr = (h_on_expand[27:20] + x0);
wire [7:0] v_addr = (v_on_expand[27:20] + y0);
wire [13:0] final_addr = h_addr + (v_addr << 7);                             //x+128y

//calculate 
wire signed [21:0]sign_h_float = {1'b0, 1'b0, h_on_expand[19:0]};           //sigend bit [21], [20]    integer, [19:0] decimal
wire signed [21:0]sign_v_float = {1'b0, 1'b0, v_on_expand[19:0]};           //sigend bit [21], [20]    integer, [19:0] decimal
reg signed  [21:0]x_square;                                                 //sigend bit [21], [20]    integer, [19:0] decimal
reg signed  [43:0]temp_x_square;                                            //signed bit [43], [42:40] integer, [39:0] decimal
reg signed  [33:0]temp_fill_data;                                           //signed bit [33], [32:21] integer, [20:0] decimal

reg signed [9:0] p_neg1, p0, p1, p2;                                        //signed bit  [9], [8:1]  integer, [0] decimal
wire signed [11:0] a, b, c, d;                                              //signed bit [11], [10:1] integer, [0] decimal
assign a = -(p_neg1 >> 1) + p0 + (p0 >> 1) - p1 - (p1 >> 1) + (p2 >> 1);    //a = -1/2p(-1) + 3/2p(0) - 3/2p(1) + 1/2p(2) 
assign b = p_neg1 - (p0 << 1) - (p0 >> 1) + (p1 << 1) - (p2 >> 1);          //b = p(-1) - 5/2p(0) +2p(1) - 1/2p(2)
assign c = - (p_neg1 >> 1) + (p1 >> 1);                                     //c = -1/2p(-1) + 1/2p(1)
assign d = p0;                                                              //d = p(0)
wire signed [31:0] shift_d;                                                 //signed bit [31], [30:21] integer, [20:0] decimal
assign shift_d = d << 20;                                                   //shift d to decimal

//padding flag
reg uppad, downpad, leftpad, rightpad;                   


// state transition
always @(posedge clk) begin
    if(rst) begin
        state <= START;
    end else begin
        state <= nextstate;
    end
end

//FSM
always @(*) begin
    case(state)
        START: begin
            if(enable) begin
                nextstate = IDLE;
            end else begin
                nextstate = START;
            end
        end
        IDLE: begin
            if(addr_y == scaled_h) nextstate = DONE;
            else nextstate = CHECK_VH;
        end
        CHECK_VH: begin
            if(h_on_expand[19:0] == 20'd0 && v_on_expand[19:0] == 20'd0) nextstate = VH_DONE;             //both done
            else if(h_on_expand[19:0] == 20'd0) nextstate = V_CAL;                                 //horizontol done
            else if(v_on_expand[19:0] == 20'd0) nextstate = H_CAL;                                 //vertical done
            else nextstate = LOAD;                                                          //both not done
        end
        VH_DONE: nextstate = VH_DONE_GETDATA;
        VH_DONE_GETDATA: begin
            if(data_ready) nextstate = WRITE_DATA;
            else nextstate = VH_DONE_GETDATA;
        end
        H_CAL: begin
            if(get_data_ctn == 3'd5) nextstate = X_IN;
            else nextstate = H_CAL;
        end
        V_CAL: begin
            if(get_data_ctn == 3'd5) nextstate = Y_IN;
            else nextstate = V_CAL;
        end
        LOAD: begin
            nextstate = H_CAL;            
        end
        X_IN: begin
            if(X_in_ctn == 3'd5) begin
                if(bicubic_flag == 1'b1) nextstate = STORE_BI;
                else nextstate = WRITE_DATA;
            end
            else nextstate = X_IN;
        end
        Y_IN: begin
            if(X_in_ctn == 3'd5) nextstate = WRITE_DATA;
            else nextstate = Y_IN;
        end
        STORE_BI: begin
            if(bicubic_index == 2'd3) begin
                nextstate = LOAD_BI;
            end else begin
                nextstate = LOAD;
            end
        end
        LOAD_BI: nextstate = Y_IN;
        WRITE_DATA: nextstate = IDLE;
        DONE: nextstate = DONE; 
        default: nextstate = IDLE;
    endcase
end

always @(posedge clk) begin
    if(rst) begin
        addr_x <= -1;
        addr_y <= 8'd0;
        Result_A <= -1;
        get_data_ctn <= 3'd0;
        X_in_ctn <= 3'd0;
        data_ready <= 1'b0;
        fill_data <= 8'd0;
        Img_CEN <= 1'b1;                    //0 RAM read enable
        bicubic_index <= -1;
        Result_D <= 8'd0;
        Result_WEN <= 1'b1;
        Result_CEN <= 1'b1; 
        done <= 1'b0;
        bicubic_flag <= 1'b0;

        p_neg1 <= 10'd0;
        p0 <= 10'd0;
        p1 <= 10'd0;
        p2 <= 10'd0;
        x_square <= 22'd0;
        temp_x_square <= 44'd0;
        temp_fill_data <= 34'd0;

        uppad <= 1'b0;
        downpad <= 1'b0;
        leftpad <= 1'b0;
        rightpad <= 1'b0;

        for(i = 0; i < 2'd3; i = i + 1) begin
            biq_arr[i] <= 8'd0;
        end
    end
    else begin
        case(state)
            IDLE: begin
                //signals for memory
                Result_WEN <= 1'b1;                 //result read
                Img_CEN <= 1'b1;                    //0 RAM read enable
                bicubic_flag <= 1'b0;
                uppad <= 1'b0;
                downpad <= 1'b0;
                leftpad <= 1'b0;
                rightpad <= 1'b0;

                if(addr_x == scaled_w - 8'd1) begin
                    addr_x <= 8'd0;
                    addr_y <= addr_y + 8'd1;
                end
                else begin
                    addr_x <= addr_x + 8'd1;
                end
                Result_A <= Result_A + 16'd1;
            end
            VH_DONE:begin
                Img_CEN <= 1'b0;                //0 RAM read enable 
                Img_A <= final_addr;   
            end 
            VH_DONE_GETDATA: begin
                if(!data_ready) begin
                    data_ready <= 1'b1;
                    //Img_CEN <= 1'b1;                //0 RAM read disable  
                end else begin
                    fill_data <= pixel_Gray;
                    data_ready <= 1'b0;
                end
            end
            WRITE_DATA: begin
                Result_D <= fill_data;
                Result_WEN <= 1'b0;             //0 write/ 1 read
                Result_CEN <= 1'b0;             //result active low
                // Result_A <= Result_A + 16'd1;
            end
            H_CAL: begin
                case(get_data_ctn)
                    3'd0:begin                                      //check cycles
                        Img_CEN <= 1'b0;                //0 RAM read enable
                        if(bicubic_flag == 1'b1) begin                          
                            if(h_addr == 8'd0)  leftpad <= 1'b1;
                            else if(h_addr == 8'd126) rightpad <= 1'b1;
                            if(v_addr == 8'd0) uppad <= 1'b1;
                            else if(v_addr == 8'd126) downpad <= 1'b1;
                            Img_A <= final_addr - 14'd128 - 14'd1 + (bicubic_index << 7);                //p_neg1 addr
                        end
                        else begin                                              //on point
                            if(h_addr == 8'd0) leftpad <= 1'b1;
                            else if(h_addr == 8'd126) rightpad <= 1'b1; 
                            Img_A <= final_addr - 14'd1;
                        end
                    end
                    3'd1: Img_A <= Img_A + 14'd1;       //p0 addr
                    3'd2: begin
                        p_neg1 <= {1'b0, pixel_Gray, 1'b0};   //p_neg1
                        Img_A <= Img_A + 14'd1;         //p1 addr
                    end
                    3'd3: begin
                        p0 <= {1'b0, pixel_Gray, 1'b0};      //p0
                        Img_A <= Img_A + 14'd1;        //p2 addr
                    end
                    3'd4: begin
                        p1 <= {1'b0, pixel_Gray, 1'b0};      //p1
                    end
                    3'd5: begin
                        if(leftpad == 1'b1) p_neg1 <= p0;
                        if(rightpad == 1'b1) p2 <= p1;
                        else p2 <= {1'b0, pixel_Gray, 1'b0};      //p2
                    end
		    default: begin				//will not enter this case
		    	leftpad <= 1'b0;
			rightpad <= 1'b0;
	      	    end
                endcase
                if(get_data_ctn == 3'd5) get_data_ctn <= 3'd0;
                else get_data_ctn <= get_data_ctn + 3'd1;
            end
            V_CAL: begin
                case(get_data_ctn)
                    3'd0:begin                                               //check cycles
                        Img_CEN <= 1'b0;                                     //0 RAM read enable
                        if(v_addr == 8'd0) begin
                            uppad <= 1'b1;                                  //up padding
                        end
                        else if(v_addr == 8'd126) begin
                            downpad <= 1'b1;                                //down padding
                        end
                        Img_A <= final_addr - 128;                          //p_neg1 addr
                    end
                    3'd1: Img_A <= Img_A + 128;                       //p0 addr
                    3'd2: begin
                        Img_A <= Img_A + 128;                         //p1 addr
                        p_neg1 <= {1'b0, pixel_Gray, 1'b0};                        //p_neg1
                    end
                    3'd3: begin
                        Img_A <= Img_A + 128;                        //p2 addr
                        p0 <= {1'b0, pixel_Gray, 1'b0};                           //p0
                    end
                    3'd4: begin
                        p1 <= {1'b0, pixel_Gray, 1'b0};                           //p1
                    end
                    3'd5: begin
                        if(uppad == 1'b1) p_neg1 <= p0;
                        if(downpad == 1'b1) p2 <= p1;
                        else p2 <= {1'b0, pixel_Gray, 1'b0};                           //p2
                    end
		    default: begin				//will not enter this case
		    	leftpad <= 1'b0;
			rightpad <= 1'b0;
	      	    end
                endcase
                if(get_data_ctn == 3'd5) get_data_ctn <= 3'd0;
                else get_data_ctn <= get_data_ctn + 3'd1;
            end
            X_IN: begin
                //fill ax^3 + bx^2 + cx + d
                case(X_in_ctn)
                    3'd0: begin
                        temp_x_square <= sign_h_float * sign_h_float;         //x^2
                        temp_fill_data <= 34'd0;            
                    end
                    3'd1: begin
                        x_square <= {temp_x_square[43], temp_x_square[40], temp_x_square[39:20]};
                        temp_fill_data <= temp_fill_data + shift_d;             //d
                    end
                    3'd2: begin
                        temp_x_square <= x_square * sign_h_float;               //x^3
                        temp_fill_data <= temp_fill_data + (c * sign_h_float);  //cx
                    end
                    3'd3:begin
                        temp_fill_data <= temp_fill_data + (b * x_square);       //bx^2
                        x_square <= {temp_x_square[43], temp_x_square[40], temp_x_square[39:20]};               
                    end
                    3'd4: begin
                        temp_fill_data <= temp_fill_data + (a * x_square);      //ax^3
                    end
                    3'd5: begin
                        if(temp_fill_data[33] == 1'd1) fill_data <= 8'd0;                                      //negative
                        else if(temp_fill_data[32:21] >= 12'd255) fill_data <= 8'd255;                         //overflow
                        else if(temp_fill_data[20] == 1'd1) fill_data <= temp_fill_data[28:21] + 8'd1;         //round up
                        else fill_data <= temp_fill_data[28:21];
                    end
		            default: begin			                                    //will not enter this
			            temp_fill_data <= 34'd0; 	
			        end
                endcase

                if(X_in_ctn == 3'd5) X_in_ctn <= 3'd0;
                else X_in_ctn <= X_in_ctn + 3'd1;
            end
            Y_IN: begin
                //fill ax^3 + bx^2 + cx + d
                case(X_in_ctn)
                    3'd0: begin
                        temp_x_square <= sign_v_float * sign_v_float;         //x^2
                        temp_fill_data <= 34'd0;            
                    end
                    3'd1: begin
                        x_square <= {temp_x_square[43], temp_x_square[40], temp_x_square[39:20]};
                        temp_fill_data <= temp_fill_data + shift_d;             //d
                    end
                    3'd2: begin
                        temp_x_square <= x_square * sign_v_float;               //x^3
                        temp_fill_data <= temp_fill_data + (c * sign_v_float);  //cx
                    end
                    3'd3:begin
                        temp_fill_data <= temp_fill_data + (b * x_square);       //bx^2
                        x_square <= {temp_x_square[43], temp_x_square[40], temp_x_square[39:20]};               
                    end
                    3'd4: begin
                        temp_fill_data <= temp_fill_data + (a * x_square);      //ax^3
                    end
                    3'd5: begin
                        if(temp_fill_data[33] == 1'd1) fill_data <= 8'd0;                                      //negative
                        else if(temp_fill_data[32:21] >= 12'd255) fill_data <= 8'd255;                         //overflow
                        else if(temp_fill_data[20] == 1'd1) fill_data <= temp_fill_data[28:21] + 8'd1;         //round up
                        else fill_data <= temp_fill_data[28:21];
                    end
		            default: begin			                                    //will not enter this
			            temp_fill_data <= 34'd0; 	
			        end
                endcase

                if(X_in_ctn == 3'd5) X_in_ctn <= 3'd0;
                else X_in_ctn <= X_in_ctn + 3'd1;
            end
            LOAD: begin
                bicubic_flag <= 1'b1;
                bicubic_index <= bicubic_index + 2'd1;
                leftpad <= 1'b0;
                rightpad <= 1'b0;             
            end
            STORE_BI: begin
                biq_arr[bicubic_index] <= fill_data;
                if(bicubic_index == 2'd3) begin
                    if(uppad == 1'b1) biq_arr[0] <= biq_arr[1];
                    if(downpad == 1'b1) biq_arr[3] <= biq_arr[2];
                    else biq_arr[bicubic_index] <= fill_data;

                    uppad <= 1'b0;
                    downpad <= 1'b0;
                end
                else biq_arr[bicubic_index] <= fill_data;
            end
            LOAD_BI: begin
                bicubic_index <= -1;
                p_neg1 <= {1'b0, biq_arr[0], 1'b0};
                p0 <= {1'b0, biq_arr[1], 1'b0};
                p1 <= {1'b0, biq_arr[2], 1'b0};
                p2 <= {1'b0, biq_arr[3], 1'b0};
            end
            DONE: done <= 1'b1;
        endcase
    end
end

//RGB to Gray conversion
reg [13:0]productR, productG, productB;
reg [14:0]RGB_to_Gray, rounded_RGB_to_Gray;

always @(*) begin
    if(Img_CEN == 1'b0) begin
        productR = R * 6'b001001;
        productG = G * 6'b010011;
        productB = B * 6'b000011;
        RGB_to_Gray = productR + productG + productB;
        if(RGB_to_Gray[4] == 1'b1) begin
            if(RGB_to_Gray[3:0] == 4'b0) begin                                                                  //ties to even
                if(RGB_to_Gray[5] == 1'b0)  rounded_RGB_to_Gray = RGB_to_Gray;                                  //even    
                else rounded_RGB_to_Gray = RGB_to_Gray + 15'b000000000100000;                                   //odd
            end
            else rounded_RGB_to_Gray = RGB_to_Gray + 15'b000000000100000;
        end
        else rounded_RGB_to_Gray = RGB_to_Gray;
	    pixel_Gray = rounded_RGB_to_Gray[12:5];
    end
    else begin
        pixel_Gray = 8'd0;
        productR = 14'd0;
        productG = 14'd0;
        productB = 14'd0;
        RGB_to_Gray = 15'd0;
        rounded_RGB_to_Gray = 15'd0;
    end
end
endmodule
