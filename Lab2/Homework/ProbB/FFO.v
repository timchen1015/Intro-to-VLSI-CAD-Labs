module FFO(
    input [7:0] data ,
    output valid ,
    output [2:0] position
);
//put your design here

wire pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7;
and(pos0, data[0], 1'b1);
and(pos1, data[1], ~data[0]);
and(pos2, data[2], ~data[0], ~data[1]);
and(pos3, data[3], ~data[0], ~data[1], ~data[2]);
and(pos4, data[4], ~data[0], ~data[1], ~data[2], ~data[3]);
and(pos5, data[5], ~data[0], ~data[1], ~data[2], ~data[3], ~data[4]);
and(pos6, data[6], ~data[0], ~data[1], ~data[2], ~data[3], ~data[4], ~data[5]);
and(pos7, data[7], ~data[0], ~data[1], ~data[2], ~data[3], ~data[4], ~data[5], ~data[6]);

or(valid, pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7);

or(position[0], pos1, pos3, pos5, pos7);
or(position[1], pos2, pos3, pos6, pos7);
or(position[2], pos4, pos5, pos6, pos7);

    
endmodule
