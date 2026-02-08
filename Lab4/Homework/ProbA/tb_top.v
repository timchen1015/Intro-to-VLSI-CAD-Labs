`timescale 1ns/10ps

`include "top.v"
`define clkPeriod 10

module tb_top();
// ---------------------------------------------------- //
reg						     	clk;
reg						     	rst;
reg						     	ref_en;
reg [27:0]					    ref_in;
reg								pixel_en;
reg	[1:0]						pixel_X;
reg	[1:0]						pixel_Y;
reg								pixel_broken;

wire [7:0]						pixel_Gray;

integer i, error;

top top(
	.clk(clk), 
	.rst(rst),
	.ref_en(ref_en),
	.ref_in(ref_in), 
	.pixel_en(pixel_en),
	.pixel_X(pixel_X),
	.pixel_Y(pixel_Y),
	.pixel_broken(pixel_broken),
	.pixel_Gray(pixel_Gray)
	);

//monitor

initial begin
	error=0;
	#190
	$display("\n\n-----------------------First Picture---------------------------\n");

			if(pixel_Gray==8'h6f) 
				$display("(0,0) output is correct\n");
			else begin 
				$display("(0,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 6f \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb4) 
				$display("(1,0) output is correct\n");
			else begin 
				$display("(1,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b4 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h69) 
				$display("(2,0) output is correct\n");
			else begin 
				$display("(2,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 69 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb3) 
				$display("(3,0) output is correct\n");
			else begin 
				$display("(3,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b3 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h79) 
				$display("(0,1) output is correct\n");
			else begin 
				$display("(0,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 79 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb6) 
				$display("(1,1) output is correct\n");
			else begin 
				$display("(1,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b6 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h96) 
				$display("(2,1) output is correct\n");
			else begin 
				$display("(2,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 96 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hac) 
				$display("(3,1) output is correct\n");
			else begin 
				$display("(3,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is ac \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h88) 
				$display("(0,2) output is correct\n");
			else begin 
				$display("(0,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 88 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hbc) 
				$display("(1,2) output is correct\n");
			else begin 
				$display("(1,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is bc \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h96) 
				$display("(2,2) output is correct\n");
			else begin 
				$display("(2,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 96 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'ha5) 
				$display("(3,2) output is correct\n");
			else begin 
				$display("(3,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is a5 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h74) 
				$display("(0,3) output is correct\n");
			else begin 
				$display("(0,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 74 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h98) 
				$display("(1,3) output is correct\n");
			else begin 
				$display("(1,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 98 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h76) 
				$display("(2,3) output is correct\n");
			else begin 
				$display("(2,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 76 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hda) 
				$display("(3,3) output is correct\n");
			else begin 
				$display("(3,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is da \n",pixel_Gray);	
				error = error +1; 
			end
	


	#185
	$display("\n-----------------------Second Picture---------------------------\n");
			if(pixel_Gray==8'h6f) 
				$display("(0,0) output is correct\n");
			else begin 
				$display("(0,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 6f \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb4) 
				$display("(1,0) output is correct\n");
			else begin 
				$display("(1,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b4 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h69) 
				$display("(2,0) output is correct\n");
			else begin 
				$display("(2,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 69 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb3) 
				$display("(3,0) output is correct\n");
			else begin 
				$display("(3,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b3 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h79) 
				$display("(0,1) output is correct\n");
			else begin 
				$display("(0,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 79 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hbc) 
				$display("(1,1) output is correct\n");
			else begin 
				$display("(1,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is bc \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h88) 
				$display("(2,1) output is correct\n");
			else begin 
				$display("(2,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 88 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hac) 
				$display("(3,1) output is correct\n");
			else begin 
				$display("(3,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is ac \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h88) 
				$display("(0,2) output is correct\n");
			else begin 
				$display("(0,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 88 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hbc) 
				$display("(1,2) output is correct\n");
			else begin 
				$display("(1,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is bc \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h96) 
				$display("(2,2) output is correct\n");
			else begin 
				$display("(2,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 96 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'ha5) 
				$display("(3,2) output is correct\n");
			else begin 
				$display("(3,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is a5 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h74) 
				$display("(0,3) output is correct\n");
			else begin 
				$display("(0,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 74 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h98) 
				$display("(1,3) output is correct\n");
			else begin 
				$display("(1,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 98 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h76) 
				$display("(2,3) output is correct\n");
			else begin 
				$display("(2,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 76 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hda) 
				$display("(3,3) output is correct\n");
			else begin 
				$display("(3,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is da \n",pixel_Gray);	
				error = error +1; 
			end


	#180
	$display("\n-----------------------Third Picture---------------------------\n");
			if(pixel_Gray==8'h6f) 
				$display("(0,0) output is correct\n");
			else begin 
				$display("(0,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 6f \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb4) 
				$display("(1,0) output is correct\n");
			else begin 
				$display("(1,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b4 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h69) 
				$display("(2,0) output is correct\n");
			else begin 
				$display("(2,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 69 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb3) 
				$display("(3,0) output is correct\n");
			else begin 
				$display("(3,0) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b3 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h79) 
				$display("(0,1) output is correct\n");
			else begin 
				$display("(0,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 79 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb6) 
				$display("(1,1) output is correct\n");
			else begin 
				$display("(1,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b6 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h88) 
				$display("(2,1) output is correct\n");
			else begin 
				$display("(2,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 88 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hac) 
				$display("(3,1) output is correct\n");
			else begin 
				$display("(3,1) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is ac \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h88) 
				$display("(0,2) output is correct\n");
			else begin 
				$display("(0,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 88 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hb6) 
				$display("(1,2) output is correct\n");
			else begin 
				$display("(1,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is b6 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h96) 
				$display("(2,2) output is correct\n");
			else begin 
				$display("(2,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 96 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'ha5) 
				$display("(3,2) output is correct\n");
			else begin 
				$display("(3,2) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is a5 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h74) 
				$display("(0,3) output is correct\n");
			else begin 
				$display("(0,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 74 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h98) 
				$display("(1,3) output is correct\n");
			else begin 
				$display("(1,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 98 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'h76) 
				$display("(2,3) output is correct\n");
			else begin 
				$display("(2,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is 76 \n",pixel_Gray);	
				error = error +1; 
			end
	#10
			if(pixel_Gray==8'hda) 
				$display("(3,3) output is correct\n");
			else begin 
				$display("(3,3) is Wrong .Your pixel_Gray is %h , but Correct pixel_Gray is da \n",pixel_Gray);	
				error = error +1; 
			end


 
	
	if(error === 0)begin
        $display("\n");
        $display("\n");
        $display("        ****************************               ");
        $display("        **                        **       |\\__||  ");
        $display("        **  Congratulations !!    **      / O.O  | ");
        $display("        **                        **    /_____   | ");
        $display("        **  Simulation PASS!!     **   /^ ^ ^ \\  |");
        $display("        **                        **  |^ ^ ^ ^ |w| ");
        $display("        ****************************   \\m___m__|_|");
        $display("\n");
	end
	else begin
        $display("\n");
        $display("\n");
        $display("        ****************************               ");
        $display("        **                        **       |\__||  ");
        $display("        **  OOPS!!                **      / X,X  | ");
        $display("        **                        **    /_____   | ");
        $display("        **  Simulation Failed!!   **   /^ ^ ^ \\  |");
        $display("        **                        **  |^ ^ ^ ^ |w| ");
        $display("        ****************************   \\m___m__|_|");
        $display("         There are %d errors                     ", error); 
        $display("\n");
    end
end   

//clock generator
always #(`clkPeriod/2) clk = ~clk;


initial begin
	clk = 0; rst = 1;  pixel_en = 0; ref_en = 0; ref_in = 28'd0;          
#10			 rst = 0;                                                                        

#6                    pixel_en = 0; ref_en = 1; ref_in = 28'b00_00_01111000_10000010_00000101; //(0,0) 120 130 5
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_00_01100100_11111111_00000011; //(1,0) 100 255 3
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_00_00000100_10011101_01110010; //(2,0) 4   157 114
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_00_11101011_10011101_11010101; //(3,0) 235 157 213

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_01_01111100_10001001_00110100; //(0,1) 124 137 52
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_01_10001000_11011101_10000101; //(1,1) 136 221 133
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_01_01110010_10011101_01110010; //(2,1) 114 157 114
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_01_11101011_10011101_10000101; //(3,1) 235 157 133

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_10_01111100_10001001_11010111; //(0,2) 124 137 215
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_10_10001000_11100111_10000101; //(1,2) 136 231 133
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_10_10001111_10011101_10110010; //(2,2) 143 157 178
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_10_11010011_10011101_10000101; //(3,2) 211 157 133

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_11_01111000_10001001_00000101; //(0,3) 120 137 5
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_11_00000000_11111111_00000011; //(1,3) 0   255 3
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_11_00000100_10011101_11111111; //(2,3) 4   157 255
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_11_11101011_11111111_00000000; //(3,3) 235 255 0
#10					  pixel_en = 0; ref_en = 0;

//------------------------------------  Test 1-----------------------------------//

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd111
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd180
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd105
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd179

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd121
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd182
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b01; pixel_broken = 1;   // 8'd150
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd172

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd136
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd188
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd150
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd165

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd116
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd152
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd118
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd218

//-----------------------------------------------------------------------------//

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_00_01111000_10000010_00000101; //(0,0) 120 130 5
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_00_01100100_11111111_00000011; //(1,0) 100 255 3
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_00_00000100_10011101_01110010; //(2,0) 4   157 114
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_00_11101011_10011101_11010101; //(3,0) 235 157 213

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_01_01111100_10001001_00110100; //(0,1) 124 137 52
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_01_10001000_11011101_10000101; //(1,1) 136 221 133
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_01_01110010_10011101_01110010; //(2,1) 114 157 114
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_01_11101011_10011101_10000101; //(3,1) 235 157 133

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_10_01111100_10001001_11010111; //(0,2) 124 137 215
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_10_10001000_11100111_10000101; //(1,2) 136 231 133
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_10_10001111_10011101_10110010; //(2,2) 143 157 178
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_10_11010011_10011101_10000101; //(3,2) 211 157 133

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_11_01111000_10001001_00000101; //(0,3) 120 137 5
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_11_00000000_11111111_00000011; //(1,3) 0   255 3
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_11_00000100_10011101_11111111; //(2,3) 4   157 255
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_11_11101011_11111111_00000000; //(3,3) 235 255 0
#10					  pixel_en = 0; ref_en = 0;

//------------------------------------  Test 2-----------------------------------//

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd111
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd180
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd105
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd179

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd121
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b01; pixel_broken = 1;   // 8'd188
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd136
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd172

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd136
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd188
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd150
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd165

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd116
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd152
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd118
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd218

//-----------------------------------------------------------------------------//

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_00_01111000_10000010_00000101; //(0,0) 120 130 5
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_00_01100100_11111111_00000011; //(1,0) 100 255 3
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_00_00000100_10011101_01110010; //(2,0) 4   157 114
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_00_11101011_10011101_11010101; //(3,0) 235 157 213

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_01_01111100_10001001_00110100; //(0,1) 124 137 52
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_01_10001000_11011101_10000101; //(1,1) 136 221 133
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_01_01110010_10011101_01110010; //(2,1) 114 157 114
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_01_11101011_10011101_10000101; //(3,1) 235 157 133

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_10_01111100_10001001_11010111; //(0,2) 124 137 215
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_10_10001000_11100111_10000101; //(1,2) 136 231 133
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_10_10001111_10011101_10110010; //(2,2) 143 157 178
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_10_11010011_10011101_10000101; //(3,2) 211 157 133

#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b00_11_01111000_10001001_00000101; //(0,3) 120 137 5
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b01_11_00000000_11111111_00000011; //(1,3) 0   255 3
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b10_11_00000100_10011101_11111111; //(2,3) 4   157 255
#10                   pixel_en = 0; ref_en = 1; ref_in = 28'b11_11_11101011_11111111_00000000; //(3,3) 235 255 0
#10					  pixel_en = 0; ref_en = 0;

//------------------------------------  Test 3-----------------------------------//

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd111
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd180
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd105
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b00; pixel_broken = 0;   // 8'd179

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd121
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd182
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd136
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b01; pixel_broken = 0;   // 8'd172

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd136
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b10; pixel_broken = 1;   // 8'd182
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd150
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b10; pixel_broken = 0;   // 8'd165

#10                   pixel_en =1; pixel_X = 2'b00; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd116
#10					  pixel_en =1; pixel_X = 2'b01; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd152
#10					  pixel_en =1; pixel_X = 2'b10; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd118
#10					  pixel_en =1; pixel_X = 2'b11; pixel_Y = 2'b11; pixel_broken = 0;   // 8'd218




#200 $finish;                                                                                                     
end

initial begin
	`ifdef FSDB
    $fsdbDumpfile("top.fsdb");
	$fsdbDumpvars;
    $fsdbDumpvars("+struct", "+mda", top); 
    `endif
end
endmodule

