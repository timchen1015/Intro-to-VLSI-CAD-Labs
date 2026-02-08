`include "RCA8.v"
module Multiplier(
    input   [7:0]   A,
    input   [7:0]   B,
    output  [15:0]  product
);
   // put your design here

wire [7:0] p0, p1, p2, p3, p4, p5, p6, p7;
wire [8:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7;

//assign pi = A & {8{B[i]}};
and(p0[0], A[0], B[0]);
and(p0[1], A[1], B[0]);
and(p0[2], A[2], B[0]);
and(p0[3], A[3], B[0]);
and(p0[4], A[4], B[0]);
and(p0[5], A[5], B[0]);
and(p0[6], A[6], B[0]);
and(p0[7], A[7], B[0]);

and(p1[0], A[0], B[1]);
and(p1[1], A[1], B[1]);
and(p1[2], A[2], B[1]);
and(p1[3], A[3], B[1]);
and(p1[4], A[4], B[1]);
and(p1[5], A[5], B[1]);
and(p1[6], A[6], B[1]);
and(p1[7], A[7], B[1]);

and(p2[0], A[0], B[2]);
and(p2[1], A[1], B[2]);
and(p2[2], A[2], B[2]);
and(p2[3], A[3], B[2]);
and(p2[4], A[4], B[2]);
and(p2[5], A[5], B[2]);
and(p2[6], A[6], B[2]);
and(p2[7], A[7], B[2]);

and(p3[0], A[0], B[3]);
and(p3[1], A[1], B[3]);
and(p3[2], A[2], B[3]);
and(p3[3], A[3], B[3]);
and(p3[4], A[4], B[3]);
and(p3[5], A[5], B[3]);
and(p3[6], A[6], B[3]);
and(p3[7], A[7], B[3]);

and(p4[0], A[0], B[4]);
and(p4[1], A[1], B[4]);
and(p4[2], A[2], B[4]);
and(p4[3], A[3], B[4]);
and(p4[4], A[4], B[4]);
and(p4[5], A[5], B[4]);
and(p4[6], A[6], B[4]);
and(p4[7], A[7], B[4]);

and(p5[0], A[0], B[5]);
and(p5[1], A[1], B[5]);
and(p5[2], A[2], B[5]);
and(p5[3], A[3], B[5]);
and(p5[4], A[4], B[5]);
and(p5[5], A[5], B[5]);
and(p5[6], A[6], B[5]);
and(p5[7], A[7], B[5]);

and(p6[0], A[0], B[6]);
and(p6[1], A[1], B[6]);
and(p6[2], A[2], B[6]);
and(p6[3], A[3], B[6]);
and(p6[4], A[4], B[6]);
and(p6[5], A[5], B[6]);
and(p6[6], A[6], B[6]);
and(p6[7], A[7], B[6]);

and(p7[0], A[0], B[7]);
and(p7[1], A[1], B[7]);
and(p7[2], A[2], B[7]);
and(p7[3], A[3], B[7]);
and(p7[4], A[4], B[7]);
and(p7[5], A[5], B[7]);
and(p7[6], A[6], B[7]);
and(p7[7], A[7], B[7]);

//assign temp0 = {0, p0};
and(temp0[8], 0, 0);
and(temp0[7], p0[7], 1);
and(temp0[6], p0[6], 1);
and(temp0[5], p0[5], 1);
and(temp0[4], p0[4], 1);
and(temp0[3], p0[3], 1);
and(temp0[2], p0[2], 1);
and(temp0[1], p0[1], 1);
and(temp0[0], p0[0], 1);



RCA8 RCA8_0(.a(temp0[8:1]), .b(p1), .sum(temp1[7:0]), .overflow(temp1[8]));
RCA8 RCA8_1(.a(temp1[8:1]), .b(p2), .sum(temp2[7:0]), .overflow(temp2[8]));
RCA8 RCA8_2(.a(temp2[8:1]), .b(p3), .sum(temp3[7:0]), .overflow(temp3[8]));
RCA8 RCA8_3(.a(temp3[8:1]), .b(p4), .sum(temp4[7:0]), .overflow(temp4[8]));
RCA8 RCA8_4(.a(temp4[8:1]), .b(p5), .sum(temp5[7:0]), .overflow(temp5[8]));
RCA8 RCA8_5(.a(temp5[8:1]), .b(p6), .sum(temp6[7:0]), .overflow(temp6[8]));
RCA8 RCA8_6(.a(temp6[8:1]), .b(p7), .sum(temp7[7:0]), .overflow(temp7[8]));

//assign product = {temp7, temp6[0], temp5[0], temp4[0], temp3[0], temp2[0],temp1[0], temp0[0]};
and(product[15], temp7[8], 1);
and(product[14], temp7[7], 1);
and(product[13], temp7[6], 1);
and(product[12], temp7[5], 1);
and(product[11], temp7[4], 1);
and(product[10], temp7[3], 1);
and(product[9], temp7[2], 1);
and(product[8], temp7[1], 1);
and(product[7], temp7[0], 1);
and(product[6], temp6[0], 1);
and(product[5], temp5[0], 1);
and(product[4], temp4[0], 1);
and(product[3], temp3[0], 1);
and(product[2], temp2[0], 1);
and(product[1], temp1[0], 1);
and(product[0], temp0[0], 1);







endmodule
