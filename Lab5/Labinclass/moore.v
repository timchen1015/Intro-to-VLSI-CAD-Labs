module moore (qout,clk,rst,din);
	output reg qout;
	input clk, rst, din;
	// put your design here

	parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
	reg [1:0] state, next_state;

	//FSM
	always @(posedge clk) begin
		if (rst) begin
			state <= S0;
		end
		else begin
			state <= next_state;
		end
	end

	//Next state logic
	always @(*) begin
		case (state)
			S0: begin
				if (din == 1'b0) begin
					next_state = S2;
				end
				else begin
					next_state = S1;
				end
			end 
			S1: begin
				if (din == 1'b0) begin
					next_state = S0;
				end
				else begin
					next_state = S1;
				end
			end
			S2: begin
				if (din == 1'b0) begin
					next_state = S1;
				end
				else begin
					next_state = S3;
				end
			end
			S3: begin
				if (din == 1'b0) begin
					next_state = S3;
				end
				else begin
					next_state = S2;
				end
			end
		endcase
	end

	//Output logic
	always @(*) begin
		case (state)
			S0: qout = 1'b1;
			S1: qout = 1'b0;
			S2: qout = 1'b0;
			S3: qout = 1'b1;
		endcase
	end


endmodule

