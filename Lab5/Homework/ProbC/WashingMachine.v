module WashingMachine(refund,busy,finish,clk,rst,slot,start,cancel,set_time);
    output  reg [5:0]   refund ;
    output          busy , finish ;
    input           clk , rst , start , cancel ;
    input   [5:0]   slot ;
    input   [4:0]   set_time ;
    
    // put your design here
    parameter [2:0] IDLE = 3'd0, PAY = 3'd1, DONE_PAY = 3'd2, WASHING = 3'd3, CANCEL_WASHING = 3'd4, DONE_WASHING = 3'd5;
    reg [2:0] state, next_state;
    reg [4:0] remain_time;
    reg [5:0] total_payment;
    reg [5:0] money_back;

    //cancel 
    always @(posedge clk) begin
        if(rst) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    //next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if(slot >= 6'd50) next_state = DONE_PAY;   
                else if(slot > 6'd0) next_state = PAY;
                else next_state = IDLE;
            end
            PAY: begin
                if(cancel) next_state = CANCEL_WASHING;
                else if(total_payment >= 6'd50 && start) next_state = WASHING;
                else if(total_payment >= 6'd50) next_state = DONE_PAY;
                else next_state = PAY;
            end
            DONE_PAY: begin
                if(start) next_state = WASHING;
                else if(cancel) next_state = CANCEL_WASHING;
                else next_state = DONE_PAY;
            end
            WASHING: begin
                if(cancel) next_state = CANCEL_WASHING;
                else if(remain_time == 5'd1) next_state = DONE_WASHING;
                else next_state = WASHING;
            end
            CANCEL_WASHING: next_state = IDLE;
            DONE_WASHING: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    
    // remain_time
    always @(posedge clk) begin
        if(rst) begin
            remain_time <= 5'd5;
        end
        else begin
            case(state)
                IDLE: remain_time <= (set_time > 5'd0) ? set_time : 5'd5;
                PAY: remain_time <= (set_time > 5'd0) ? set_time : 5'd5;
                DONE_PAY: remain_time <= (set_time > 5'd0) ? set_time : 5'd5;
                WASHING: remain_time <= remain_time - 5'd1;
                default: remain_time <= 5'd5;
            endcase
        end
    end

    //refund
    always @(posedge clk) begin
        if(rst) begin
            total_payment <= 6'd0;
        end
        else begin
            case(state)
                IDLE: begin
                    total_payment <= total_payment + slot;
                end
                PAY: begin
                    total_payment <= total_payment + slot;
                end
                DONE_PAY: begin
                    if(start) begin
                        total_payment <= total_payment - 6'd50;
                    end
                    else begin
                        total_payment <= total_payment;
                    end
                end
                WASHING: begin
                    total_payment <= 6'd0;
                end
                CANCEL_WASHING: begin
                    total_payment <= 6'd0;
                end
                DONE_WASHING : begin
                    total_payment <= 6'd0;
                end
                default: begin
                    total_payment <= total_payment;
                end
            endcase
        end
    end

    always @(*) begin
        if (cancel) begin
            refund = total_payment;  // Full refund
        end
        else if (start && state == DONE_PAY) begin
            refund = total_payment - 6'd50;  
        end
        else begin
            refund = total_payment;
        end
    end

    assign busy = (state == WASHING) ? 1'b1 : 1'b0;
    assign finish = (state == DONE_WASHING) ? 1'b1 : 1'b0;


endmodule
