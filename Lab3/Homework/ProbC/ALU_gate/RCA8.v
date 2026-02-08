`include "RCA4.v"
module RCA8(
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] sum,
    output overflow
);

// put your design here
wire carry_wire;

RCA4 RCA4_0(.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .sum(sum[3:0]), .cout(carry_wire));
RCA4 RCA4_1(.a(a[7:4]), .b(b[7:4]), .cin(carry_wire), .sum(sum[7:4]), .cout(overflow));

endmodule
