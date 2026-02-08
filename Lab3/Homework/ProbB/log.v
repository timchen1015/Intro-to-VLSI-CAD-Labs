module log(
    input  [7:0] x,          //unsigned integer[7:5],decimal[4:0]
    output reg [7:0] y       //unsigned integer[7:2],decimal[1:0]
);

// put your design here
//more bit to keep fraction
reg [7:0]result, round_result;

always @(*)
begin
	result = ((x - 8'b01000000) >> 1)+ 8'b00100000;
	case(result[2:1])
		2'b00: round_result = result;
		2'b01: round_result = result;
		2'b10: begin
			if(result[4:3] == 2'b01 || result[4:3] == 2'b11)
				round_result = result + 8'b00001000;
			else round_result = result;
			end	
		2'b11: 	round_result = result + 8'b00001000;
	endcase
	y = {{3{0}}, round_result[7:3]};
end

endmodule
