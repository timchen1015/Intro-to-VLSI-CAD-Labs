module Comp1(
    input a,
    input b,
    output a_small,
    output a_equal,
    output a_large
);
//put your design here
wire a_bar, b_bar;
not(a_bar, a);
not(b_bar, b);
and(a_small, a_bar, b);
and(a_large, b_bar, a);
nor(a_equal, a_small, a_large);

endmodule
