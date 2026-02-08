`timescale 1ns/10ps

module Shooting (score, X, Y);
	input 		[ 3:0]		X;
	input 		[ 3:0]		Y;
	output reg	[31:0]		score;

	
// put your design here
wire signed[4:0] x[5:0];
wire signed[4:0] y[5:0];

assign x[0] = 5'd3;
assign y[0] = 5'd13;
assign x[1] = 5'd3;
assign y[1] = 5'd8;
assign x[2] = 5'd5;
assign y[2] = 5'd3;
assign x[3] = 5'd9;
assign y[3] = 5'd13;
assign x[4] = 5'd11;
assign y[4] = 5'd9;
assign x[5] = 5'd10;
assign y[5] = 5'd4;

wire signed [4:0] sign_x;
wire signed [4:0] sign_y;
assign sign_x = {1'b0, X};
assign sign_y = {1'b0, Y};

reg signed [5:0] x_dist;
reg signed [5:0] y_dist;
reg signed [11:0] dist_square;
reg signed [11:0] checkin;

integer i;
always @(*) begin
	score = 0;
	for(i = 0; i < 6; i = i + 1) begin
		x_dist = sign_x - x[i];
		y_dist = sign_y - y[i];
		dist_square = (x_dist * x_dist) + (y_dist * y_dist);
		checkin = dist_square - 12'd4;					//x_dist^2 + y_dist^2 - r^2
		if(checkin[11]) begin							//1 mean negative => in circle
			score = score + (i + 1);
		end
	end
end

endmodule
