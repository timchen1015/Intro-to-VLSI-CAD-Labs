`include "Comp1.v"
module Comp2(
    input [1:0]a,
    input [1:0]b,
    output a_small,
    output a_equal,
    output a_large
);
//put your design here
wire a0_small, a0_equal, a0_large, a1_small, a1_equal, a1_large, and1, and2;
Comp1 comp1_0(.a(a[0]), .b(b[0]), .a_small(a0_small), .a_equal(a0_equal), .a_large(a0_large));
Comp1 comp1_1(.a(a[1]), .b(b[1]), .a_small(a1_small), .a_equal(a1_equal), .a_large(a1_large));
and(and1, a1_equal, a0_small);
and(and2, a1_equal, a0_large);
or(a_small, a1_small, and1);
and(a_equal, a1_equal, a0_equal);
or(a_large, a1_large, and2);

endmodule
