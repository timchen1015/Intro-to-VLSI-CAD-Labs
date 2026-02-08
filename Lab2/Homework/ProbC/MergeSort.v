`include "CompUnit.v"

module MergeSort(
    input  [3:0] in1,
    input  [3:0] in2,
    input  [3:0] in3,
    input  [3:0] in4,
    input  [3:0] in5,
    input  [3:0] in6,
    output [3:0] out1,
    output [3:0] out2,
    output [3:0] out3,
    output [3:0] out4,
    output [3:0] out5,
    output [3:0] out6
);
//put your design here
//letf
wire [3:0] level1_left1, level1_left2, level1_left3, level2_left1, level2_left2, level2_left3;
CompUnit unit1(.a(in1), .b(in2), .Large(level1_left1), .Small(level1_left2));
CompUnit unit2(.a(level1_left1), .b(in3), .Large(level2_left1), .Small(level1_left3));
CompUnit unit3(.a(level1_left2), .b(level1_left3), .Large(level2_left2), .Small(level2_left3));

//right
wire [3:0]level1_right1, level1_right2, level1_right3,level2_right1, level2_right2, level2_right3;
CompUnit unit4(.a(in4), .b(in5), .Large(level1_right1), .Small(level1_right2));
CompUnit unit5(.a(level1_right1), .b(in6), .Large(level2_right1), .Small(level1_right3));
CompUnit unit6(.a(level1_right2), .b(level1_right3), .Large(level2_right2), .Small(level2_right3));

wire [3:0]L0, M0, M1, S0, F0, F1;
//large0, medium0, medium1, small0, final0, final1
CompUnit unit7(.a(level2_left1), .b(level2_right1), .Large(out1), .Small(L0));
CompUnit unit8(.a(level2_left2), .b(level2_right2), .Large(M0), .Small(M1));
CompUnit unit9(.a(level2_left3), .b(level2_right3), .Large(S0), .Small(out6));

CompUnit unit10(.a(L0), .b(M0), .Large(out2), .Small(F0));
CompUnit unit11(.a(M1), .b(S0), .Large(F1), .Small(out5));
CompUnit unit12(.a(F0), .b(F1), .Large(out3), .Small(out4));

endmodule
