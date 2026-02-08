module factorial (result,valid,clk,rst,enable,level);
    output reg [13:0] result ;
    output reg valid ;    
    input clk , rst , enable ;
    input [2:0] level ;
    
    // put your design here
    parameter [3:0] S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6, S7 = 4'd7, START = 4'd8;
    reg [3:0] state, next_state;

    reg enable_sync;
    always @(posedge clk) begin
        if (rst)
            enable_sync <= 1'd0;
        else
            enable_sync <= enable;  // Capture enable at clock edge
    end

    always @(posedge clk) begin
        if (rst) begin
            valid <= 1'b0;  // Reset valid when rst is active
        end else if (state == S0) begin
            valid <= 1'b1;  // Set valid to 1 only during state S0
        end else begin
            valid <= 1'b0;  // Reset valid in all other states
        end
    end
    
    always @(posedge clk) begin
        if(rst) begin
            state <= START;
        end
        else begin
            state <= next_state;
        end
    end

    //next state logic
    always @(*) begin
        case (state)
            START: begin
                if(enable_sync)begin
                    case(level)
                        3'd0: next_state = S0;
                        3'd1: next_state = S1;
                        3'd2: next_state = S2;
                        3'd3: next_state = S3;
                        3'd4: next_state = S4;
                        3'd5: next_state = S5;
                        3'd6: next_state = S6;
                        3'd7: next_state = S7;
                    endcase
                end
                else next_state = START;
            end 
            S0: next_state = START;
            S1: next_state = S0;
            S2: next_state = S1;
            S3: next_state = S2;
            S4: next_state = S3;
            S5: next_state = S4;
            S6: next_state = S5;
            S7: next_state = S6;
            default: next_state = START;
        endcase
    end

    //output logic
    always @(posedge clk) begin
        if(rst) begin
            result <= 14'd1;
        end
        else begin
            case(state) 
                START: result <= 14'd1;
                S0: result <= result;
                S1: result <= result;
                S2: result <= result * 14'd2; 
                S3: result <= result * 14'd3;
                S4: result <= result * 14'd4;
                S5: result <= result * 14'd5;
                S6: result <= result * 14'd6;
                S7: result <= result * 14'd7;
                default: result <= 14'd1;
            endcase
        end
    end

    //assign valid = (state == S0) ? 1'd1 : 1'd0;


endmodule
