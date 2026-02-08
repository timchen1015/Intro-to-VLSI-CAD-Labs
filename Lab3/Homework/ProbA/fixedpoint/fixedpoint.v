module fixedpoint(
    input [7:0] in1, // unsigned integer[7:5], decimal[4:0]
    input [7:0] in2, // unsigned integer[7:5], decimal[4:0]
    output reg [7:0] out // unsigned integer[7:2], decimal[1:0]
);
    // put your design here

reg [15:0]product, rounded_product;

always @(*)
begin
	product = in1 * in2;
	case(product[7:6])
		2'b00: rounded_product = product;
		2'b01: rounded_product = product;
		2'b10: begin
			if(product[9:8] == 2'b01 || product[9:8] == 2'b11)
				rounded_product = product + 16'b0000000100000000;
			else rounded_product = product;
			end	
		2'b11: 	rounded_product = product + 16'b0000000100000000;
	endcase
	out = rounded_product[15:8];
end

endmodule
