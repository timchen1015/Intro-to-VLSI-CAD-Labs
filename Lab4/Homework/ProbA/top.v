`timescale 1ns/10ps

//include your design here 
//Ex: `include "Example.v"
`include "regfile.v"
`include "abs.v"

module top (pixel_Gray, clk, rst, ref_en, ref_in, pixel_en, pixel_X, pixel_Y, pixel_broken);
input 					clk;
input 					rst;
input 					ref_en;
input 		[27:0]		ref_in;
input 					pixel_en;
input 		[1:0 ]		pixel_X;
input 		[1:0 ]		pixel_Y;
input 					pixel_broken;
output  	reg [7:0 ]		pixel_Gray;

// put your design here
wire [23:0] pixel_RGB;
wire [3:0] in_addr, out_addr;
wire [23:0] neigbor_src[0:3];
assign in_addr =  ref_in[27:26] + (ref_in[25:24] << 2);
assign out_addr = pixel_X  + (pixel_Y << 2);
regfile regfile1 (.src1(pixel_RGB), .clk(clk), .rst(rst), .reg_enable(1'b1), .reg_write(ref_en), .src1_addr(out_addr), .write_addr(in_addr), .write_data(ref_in[23:0]), .neigbor_src1(neigbor_src[0]), .neigbor_src2(neigbor_src[1]), .neigbor_src3(neigbor_src[2]), .neigbor_src4(neigbor_src[3]));    	

reg [7:0] R_distance, G_distance, B_distance;
wire [9:0] result_distance[0:3];
abs abs1 (.a1(pixel_RGB[23:16]), .b1(neigbor_src[0][23:16]), .a2(pixel_RGB[15:8]), .b2(neigbor_src[0][15:8]), .a3(pixel_RGB[7:0]), .b3(neigbor_src[0][7:0]), .result(result_distance[0]));
abs abs2 (.a1(pixel_RGB[23:16]), .b1(neigbor_src[1][23:16]), .a2(pixel_RGB[15:8]), .b2(neigbor_src[1][15:8]), .a3(pixel_RGB[7:0]), .b3(neigbor_src[1][7:0]), .result(result_distance[1]));
abs abs3 (.a1(pixel_RGB[23:16]), .b1(neigbor_src[2][23:16]), .a2(pixel_RGB[15:8]), .b2(neigbor_src[2][15:8]), .a3(pixel_RGB[7:0]), .b3(neigbor_src[2][7:0]), .result(result_distance[2]));
abs abs4 (.a1(pixel_RGB[23:16]), .b1(neigbor_src[3][23:16]), .a2(pixel_RGB[15:8]), .b2(neigbor_src[3][15:8]), .a3(pixel_RGB[7:0]), .b3(neigbor_src[3][7:0]), .result(result_distance[3]));

reg [2:0]i;
reg [23:0] best_pixel;
reg [9:0] min_distance;                              //(255+255+255);
always @(*) begin
    min_distance = 10'd765;                  //initialize to avoid latch
    best_pixel = pixel_RGB;                     //initialize to avoid latch
    if(pixel_en) begin
        if(pixel_broken) begin
            for(i = 0; i < 4; i = i + 1) begin
                if(result_distance[i] < min_distance) begin
                    min_distance = result_distance[i];
                    best_pixel = neigbor_src[i];
                end
            end
        end
    end
end

reg [13:0]productR, productG, productB;
reg [14:0]RGB_to_Gray, rounded_RGB_to_Gray;
always @(best_pixel) begin
    if(pixel_en) begin
        //R
        productR = best_pixel[23:16] * 6'b001001;
        productG = best_pixel[15:8] * 6'b010011;
        productB = best_pixel[7:0] * 6'b000011;
        RGB_to_Gray = productR + productG + productB;
        case(RGB_to_Gray[4:3])
		    2'b00: rounded_RGB_to_Gray = RGB_to_Gray;
		    2'b01: rounded_RGB_to_Gray = RGB_to_Gray;
		    2'b10: begin
			    if(RGB_to_Gray[6:5] == 2'b01 || RGB_to_Gray[6:5] == 2'b11)
				    rounded_RGB_to_Gray = RGB_to_Gray + 15'b000000000100000;
			    else rounded_RGB_to_Gray = RGB_to_Gray;
			    end	
		    2'b11: 	rounded_RGB_to_Gray = RGB_to_Gray + 15'b000000000100000;
	    endcase
	    pixel_Gray = rounded_RGB_to_Gray[12:5];
    end
    else begin
        pixel_Gray = 8'd0;
        productR = 14'd0;
        productG = 14'd0;
        productB = 14'd0;
        RGB_to_Gray = 15'd0;
        rounded_RGB_to_Gray = 15'd0;
    end
end

endmodule
