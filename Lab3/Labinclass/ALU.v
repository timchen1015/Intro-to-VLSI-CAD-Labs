`define DATA_SIZE  32
`define OP_SIZE  5

module ALU (
	input      [`OP_SIZE-1:0]   alu_op,
	input      [`DATA_SIZE-1:0] src1,
	input      [`DATA_SIZE-1:0] src2,
	output reg [`DATA_SIZE-1:0] alu_out,
	output reg                  alu_overflow
);
	// put your design here

parameter [4:0] SIGN_ADD = 5'b00000, 
	        SIGN_SUB = 5'b00001, 
		ACTION_OR = 5'b00010, 
	        ACTION_AND = 5'b00011, 
	        ACTION_XOR = 5'b00100, 
	        ACTION_NOT = 5'b00101, 
	        ACTION_NAND = 5'b00110,
		ACTION_NOR = 5'b00111, 
		SLT = 5'b01000, 
	        SLTU = 5'b01001,
		ABS = 5'b01010,
	        BITREV = 5'b01011;

always @(*)
begin
	alu_overflow = 1'b0;	
	case(alu_op)
		SIGN_ADD: begin
			alu_out = src1 + src2;
			alu_overflow = 
			(src1[`DATA_SIZE-1] == src2[`DATA_SIZE-1]) && (alu_out[`DATA_SIZE-1] != src1[`DATA_SIZE-1]); 		
		end
		SIGN_SUB: begin
			alu_out = src1 - src2;
			alu_overflow = 	(~src1[`DATA_SIZE-1]&& src2[`DATA_SIZE-1] && alu_out[`DATA_SIZE-1]) ||
					(src1[`DATA_SIZE-1]&& (~src2[`DATA_SIZE-1]) &&~alu_out[`DATA_SIZE-1]);
		end
		ACTION_OR: alu_out = src1 | src2;
		ACTION_AND: alu_out = src1 & src2;
		ACTION_XOR: alu_out = src1 ^ src2;
		ACTION_NOT: alu_out = ~src1;
		ACTION_NAND: alu_out = ~(src1 & src2);
		ACTION_NOR: alu_out = ~(src1 | src2);
		SLT: alu_out = ($signed(src1) < $signed(src2)) ? 32'd1 : 32'd0;
		SLTU: alu_out = (src1 < src2) ? 32'd1 : 32'd0;
		ABS: alu_out = src1[`DATA_SIZE - 1] ? -src1 : src1;
		BITREV:	alu_out = {src1[0], src1[1], src1[2], src1[3], src1[4], src1[5], src1[6], src1[7], src1[8], src1[9], src1[10], src1[11], src1[12], src1[13], src1[14], src1[15], src1[16], src1[17], src1[18], src1[19], src1[20], src1[21], src1[22], src1[23], src1[24], src1[25], src1[26], src1[27], src1[28], src1[29], src1[30], src1[31]};
		default: alu_out = 0;
	endcase
end

endmodule
