`include "Comp2.v"
module Comp4(
    input [3:0]a,
    input [3:0]b,
    output a_small,
    output a_equal,
    output a_large
);
//put your design here

wire a3a2_large, a3a2_small, a3a2_equal, a1a0_large, a1a0_small, a1a0_equal, and1, and2;
Comp2 comp2_0(.a(a[3:2]), .b(b[3:2]), .a_small(a3a2_small), .a_equal(a3a2_equal), .a_large(a3a2_large));
Comp2 comp2_1(.a(a[1:0]), .b(b[1:0]), .a_small(a1a0_small), .a_equal(a1a0_equal), .a_large(a1a0_large));

and(and1, a3a2_equal, a1a0_small);
and(and2, a3a2_equal, a1a0_large);

or(a_small, a3a2_small, and1);
and(a_equal, a3a2_equal, a1a0_equal);
or(a_large, a3a2_large, and2);

endmodule
