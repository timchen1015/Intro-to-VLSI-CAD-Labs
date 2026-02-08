`timescale 1ns/10ps

`include "Shooting.v"
`include "FIFO.v"

module top (empty, finish, read_data,  clk, rst, X, Y, xy_valid, read_en);
	input 					clk;
	input 					rst;
	input 		[3:0]		X;
	input 		[3:0]		Y;
	input					xy_valid;
	input					read_en;
	output					empty;
	output  				finish;
	output		[31:0]		read_data;

	
// put your design here
wire [31:0] score;
FIFO fifo(.clk(clk), .rst(rst),.write_data(score),.write_en(xy_valid),.read_en(read_en), .full_flag(finish),.empty_flag(empty),.read_data(read_data));  // Don't modify the instance name !!!!!!!!!!!!
Shooting shooting(.score(score), .X(X), .Y(Y));  

endmodule
