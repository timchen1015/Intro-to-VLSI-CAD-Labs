`timescale 1ns/10ps

// ---------------------- define ---------------------- //
`define AddrSize  5
`define DataSize  32
`define RegSize   32

// ---------------------------------------------------- //
module regfile (src1, src2, clk, rst, reg_enable, reg_write, src1_addr, src2_addr, write_addr, write_data);
	input clk; 
	input rst;
	input reg_enable;
	input reg_write;
	input [`AddrSize-1:0]src1_addr;
	input [`AddrSize-1:0]src2_addr;
	input [`AddrSize-1:0]write_addr;
	input [`DataSize-1:0]write_data;
	output reg[`DataSize-1:0]src1;
	output reg[`DataSize-1:0]src2;


reg [`DataSize-1:0] R [`RegSize-1:0];
reg [`AddrSize:0]i;

// put your design here
always @(posedge clk) begin
	if(rst) begin
		for (i = 0; i < `RegSize; i = i + 1) begin
			R[i] <= 0;
		end
	end
	else begin
		if(reg_enable && reg_write) begin
			R[write_addr] <= write_data;
		end
	end
	R[0] <= 0;
end

always @(*) begin
	if(reg_enable && !reg_write) begin
		src1 = R[src1_addr];
		src2 = R[src2_addr];
	end
	else begin
		src1 = 0;
		src2 = 0;
	end
end

endmodule	
