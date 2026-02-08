`include "Multiplier.v"

module ALU (
    input [7:0] src1 ,
    input [7:0] src2 ,
    input sel ,
    output [15:0] result
);

//put your design here

wire [15:0]temp0, temp1;
RCA8 RCA8_0(.a(src1), .b(src2), .sum(temp1[7:0]), .overflow(temp1[8]));
assign temp1[15:9] = 7'b0;

Multiplier M(.A(src1), .B(src2), .product(temp0));

wire sel_0;
wire [15:0]temp0_s, temp1_s;

not(sel_0, sel);
and(temp0_s[0], temp0[0], sel_0);
and(temp0_s[1], temp0[1], sel_0);
and(temp0_s[2], temp0[2], sel_0);
and(temp0_s[3], temp0[3], sel_0);
and(temp0_s[4], temp0[4], sel_0);
and(temp0_s[5], temp0[5], sel_0);
and(temp0_s[6], temp0[6], sel_0);
and(temp0_s[7], temp0[7], sel_0);
and(temp0_s[8], temp0[8], sel_0);
and(temp0_s[9], temp0[9], sel_0);
and(temp0_s[10], temp0[10], sel_0);
and(temp0_s[11], temp0[11], sel_0);
and(temp0_s[12], temp0[12], sel_0);
and(temp0_s[13], temp0[13], sel_0);
and(temp0_s[14], temp0[14], sel_0);
and(temp0_s[15], temp0[15], sel_0);

and(temp1_s[0], temp1[0], sel);
and(temp1_s[1], temp1[1], sel);
and(temp1_s[2], temp1[2], sel);
and(temp1_s[3], temp1[3], sel);
and(temp1_s[4], temp1[4], sel);
and(temp1_s[5], temp1[5], sel);
and(temp1_s[6], temp1[6], sel);
and(temp1_s[7], temp1[7], sel);
and(temp1_s[8], temp1[8], sel);
and(temp1_s[9], temp1[9], sel);
and(temp1_s[10], temp1[10], sel);
and(temp1_s[11], temp1[11], sel);
and(temp1_s[12], temp1[12], sel);
and(temp1_s[13], temp1[13], sel);
and(temp1_s[14], temp1[14], sel);
and(temp1_s[15], temp1[15], sel);


//or(result, temp0_s, temp1_s);
or(result[0], temp0_s[0], temp1_s[0]);
or(result[1], temp0_s[1], temp1_s[1]);
or(result[2], temp0_s[2], temp1_s[2]);
or(result[3], temp0_s[3], temp1_s[3]);
or(result[4], temp0_s[4], temp1_s[4]);
or(result[5], temp0_s[5], temp1_s[5]);
or(result[6], temp0_s[6], temp1_s[6]);
or(result[7], temp0_s[7], temp1_s[7]);
or(result[8], temp0_s[8], temp1_s[8]);
or(result[9], temp0_s[9], temp1_s[9]);
or(result[10], temp0_s[10], temp1_s[10]);
or(result[11], temp0_s[11], temp1_s[11]);
or(result[12], temp0_s[12], temp1_s[12]);
or(result[13], temp0_s[13], temp1_s[13]);
or(result[14], temp0_s[14], temp1_s[14]);
or(result[15], temp0_s[15], temp1_s[15]);















endmodule
