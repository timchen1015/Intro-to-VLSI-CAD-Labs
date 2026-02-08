module det_seq (numLPHP,numiVCAD,finish_flag,clk,rst,data_in);
    output  reg [2:0]   numLPHP , numiVCAD ;
    output          finish_flag ;    
    input           clk , rst ;
    input   [7:0]   data_in ;

    // put your design here
    parameter [3:0] START = 4'd0,
                    LPHP_L = 4'd1,
                    LPHP_P1 = 4'd2,
                    LPHP_H = 4'd3,
                    LPHP_P2 = 4'd4,
                    iVCAD_i = 4'd5,
                    iVCAD_V = 4'd6,
                    iVCAD_C = 4'd7,
                    iVCAD_A = 4'd8,
                    iVCAD_D = 4'd9,
                    DONE = 4'd10;
    parameter [7:0] L = 8'd76, P = 8'd80, H = 8'd72, i = 8'd105, V = 8'd86, C = 8'd67, A = 8'd65, D = 8'd68, STOP_SIGN = 8'd46;

    reg [3:0] state, next_state;

    always @(posedge clk) begin
        if (rst) begin
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
                case(data_in) 
                    L : next_state = LPHP_L;
                    i : next_state = iVCAD_i;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            LPHP_L: begin
                case(data_in) 
                    P : next_state = LPHP_P1;
                    L : next_state = LPHP_L;
                    i : next_state = iVCAD_i;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            LPHP_P1: begin
                case(data_in) 
                    H : next_state = LPHP_H;
                    L : next_state = LPHP_L;
                    i : next_state = iVCAD_i;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            LPHP_H: begin
                case(data_in) 
                    P : next_state = LPHP_P2;
                    L : next_state = LPHP_L;
                    i : next_state = iVCAD_i;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            LPHP_P2: begin
                case(data_in) 
                    L : next_state = LPHP_L;
                    i : next_state = iVCAD_i;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            iVCAD_i: begin
                case(data_in) 
                    V : next_state = iVCAD_V;
                    i : next_state = iVCAD_i;
                    L : next_state = LPHP_L;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            iVCAD_V: begin
                case(data_in) 
                    C : next_state = iVCAD_C;
                    i : next_state = iVCAD_i;
                    L : next_state = LPHP_L;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            iVCAD_C: begin
                case(data_in) 
                    A : next_state = iVCAD_A;
                    i : next_state = iVCAD_i;
                    L : next_state = LPHP_L;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            iVCAD_A: begin
                case(data_in) 
                    D : next_state = iVCAD_D;
                    i : next_state = iVCAD_i;
                    L : next_state = LPHP_L;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            iVCAD_D: begin
                case(data_in) 
                    i : next_state = iVCAD_i;
                    L : next_state = LPHP_L;
                    STOP_SIGN : next_state = DONE;
                    default: next_state = START;
                endcase
            end
            DONE: next_state = DONE;
            default: next_state = START;
        endcase
    end

    //Output logic
    always @(posedge clk) begin
        if(rst) begin
            numLPHP <= 3'b0;
            numiVCAD <= 3'b0;
        end
        else begin
            case (state)
                LPHP_P2 : begin
                    numLPHP <= numLPHP + 3'd1;
                    numiVCAD <= numiVCAD;
                end
                iVCAD_D : begin
                    numLPHP <= numLPHP;
                    numiVCAD <= numiVCAD + 3'd1;
                end
                default: begin
                    numLPHP <= numLPHP;
                    numiVCAD <= numiVCAD;
                end
            endcase
        end
    end
    
    //state wait for clock
    assign finish_flag = (state == DONE) ? 1'b1 : 1'b0;



endmodule
