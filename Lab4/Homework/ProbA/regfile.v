
// ---------------------- define ---------------------- //
`define AddrSize  4
`define DataSize  24
`define RegSize   16

// ---------------------------------------------------- //
module regfile (src1, clk, rst, reg_enable, reg_write, src1_addr, write_addr, write_data, neigbor_src1, neigbor_src2, neigbor_src3, neigbor_src4);
	input clk; 
	input rst;
	input reg_enable;
	input reg_write;
	input [`AddrSize-1:0]src1_addr;
	input [`AddrSize-1:0]write_addr;
	input [`DataSize-1:0]write_data;
	output reg [`DataSize-1:0]src1;
    output reg [`DataSize-1:0]neigbor_src1;
    output reg [`DataSize-1:0]neigbor_src2;
    output reg [`DataSize-1:0]neigbor_src3;
    output reg [`DataSize-1:0]neigbor_src4;


reg [`DataSize-1:0] R [`RegSize-1:0];
reg [`AddrSize:0]i;

// put your design here
always @(posedge clk) begin
	if(rst) begin
		for (i = 0; i < `RegSize; i = i + 1) begin
			R[i] <= 16'd0;
		end
	end
	else begin
		if(reg_enable && reg_write) begin
			R[write_addr] <= write_data;
		end
	end
end

always @(*) begin
	if(reg_enable && !reg_write) begin
		src1 = R[src1_addr];
        neigbor_src1 = R[src1_addr + 4'd1];    //right
        neigbor_src2 = R[src1_addr - 4'd1];    //left
        neigbor_src3 = R[src1_addr + 4'd4];    //up
        neigbor_src4 = R[src1_addr - 4'd4];    //down
	end
	else begin
		src1 = 24'd0;
	end
end

endmodule
