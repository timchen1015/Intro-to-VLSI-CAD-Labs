module abs(
    input [7:0] a1,     
    input [7:0] b1,
    input [7:0] a2,
    input [7:0] b2,
    input [7:0] a3,
    input [7:0] b3,    
    output [9:0] result // Absolute difference |a1 - b1| + ||a2 - b2| + |a3 - b3|
);

wire [7:0] r1, r2, r3;
assign r1 = (a1 > b1) ? a1 - b1 : b1 - a1;
assign r2 = (a2 > b2) ? a2 - b2 : b2 - a2;
assign r3 = (a3 > b3) ? a3 - b3 : b3 - a3;
assign result = r1 + r2 + r3;

endmodule