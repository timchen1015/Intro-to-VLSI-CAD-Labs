module ALU(
    input [7:0] src1 ,
    input [7:0] src2 ,
    input sel ,
    output reg [15:0] result
);

// put your design here

always @(*) begin
	if(sel) result = src1 + src2;
	else result = src1 * src2;
end

endmodule
