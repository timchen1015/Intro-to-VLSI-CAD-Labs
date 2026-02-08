`include "Comp4.v"
module CompUnit (
    input [3:0] a,
    input [3:0] b,
    output [3:0] Large,
    output [3:0] Small
);
//put your design here

wire a_small, a_equal, a_large;
Comp4 comp4(.a(a), .b(b), .a_small(a_small), .a_equal(a_equal), .a_large(a_large));

//Large
wire [3:0] LargeA, LargeB, LargeAB, SmallA, SmallB, SmallAB;
and(LargeA[0], a_large, a[0]);
and(LargeA[1], a_large, a[1]);
and(LargeA[2], a_large, a[2]);
and(LargeA[3], a_large, a[3]);

and(LargeB[0], a_small, b[0]);
and(LargeB[1], a_small, b[1]);
and(LargeB[2], a_small, b[2]);
and(LargeB[3], a_small, b[3]);

and(LargeAB[0], a_equal, a[0]);
and(LargeAB[1], a_equal, a[1]);
and(LargeAB[2], a_equal, a[2]);
and(LargeAB[3], a_equal, a[3]);

or(Large[0], LargeA[0], LargeB[0], LargeAB[0]);
or(Large[1], LargeA[1], LargeB[1], LargeAB[1]);
or(Large[2], LargeA[2], LargeB[2], LargeAB[2]);
or(Large[3], LargeA[3], LargeB[3], LargeAB[3]);

//Small
and(SmallA[0], a_small, a[0]);
and(SmallA[1], a_small, a[1]);
and(SmallA[2], a_small, a[2]);
and(SmallA[3], a_small, a[3]);

and(SmallB[0], a_large, b[0]);
and(SmallB[1], a_large, b[1]);
and(SmallB[2], a_large, b[2]);
and(SmallB[3], a_large, b[3]);

and(SmallAB[0], a_equal, b[0]);
and(SmallAB[1], a_equal, b[1]);
and(SmallAB[2], a_equal, b[2]);
and(SmallAB[3], a_equal, b[3]);

or(Small[0], SmallA[0], SmallB[0], SmallAB[0]);
or(Small[1], SmallA[1], SmallB[1], SmallAB[1]);
or(Small[2], SmallA[2], SmallB[2], SmallAB[2]);
or(Small[3], SmallA[3], SmallB[3], SmallAB[3]);

//assign Large = (a_large | a_equal) ? a:b;
//assign Small = (a_small | a_equal) ? a:b;

endmodule
