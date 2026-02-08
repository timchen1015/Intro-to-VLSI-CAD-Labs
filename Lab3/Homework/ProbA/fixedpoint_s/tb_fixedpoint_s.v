`timescale 1ns/10ps

`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "fixedpoint_s_syn.v"
`else
`include "fixedpoint_s.v"
`endif

module tb_fixedpoint_s;

reg [7:0] in1;
reg [7:0] in2;
wire [7:0] out;
integer error;

reg [7:0] expected_results [0:8];
integer i ;

fixedpoint_s fixedpoint_s(
	.in1(in1),
	.in2(in2),
	.out(out)
);


initial begin
	error = 0;
	expected_results[0] = 8'h04;
	expected_results[1] = 8'hdf;
	expected_results[2] = 8'h23;
	expected_results[3] = 8'hdc;
	expected_results[4] = 8'hf8;
	expected_results[5] = 8'h0c;
	expected_results[6] = 8'h10;
	expected_results[7] = 8'h31;
	expected_results[8] = 8'h14;

	for (i = 0; i < 9; i = i + 1) begin
		#5;
		if (out !== expected_results[i]) begin
			error = error + 1;
			$display("Test %0d Failed: in1 = %b, in2 = %b, Expected = %b, Got = %b", i, in1, in2, expected_results[i], out);
		end
		#5 ;
	end

	if (error === 0) begin
		$display("\n\n");
		$display("        ****************************               ");
		$display("        **                        **       |\__||  ");
		$display("        **  Congratulations !!    **      / O.O  | ");
		$display("        **                        **    /_____   | ");
		$display("        **  Simulation PASS!!     **   /^ ^ ^ \\  |");
		$display("        **                        **  |^ ^ ^ ^ |w| ");
		$display("        ****************************   \\m___m__|_|");
		$display("\n");
	end else begin
		$display("\n\n");
		$display("        ****************************               ");
		$display("        **                        **       |\__||  ");
		$display("        **  OOPS!!                **      / X,X  | ");
		$display("        **                        **    /_____   | ");
		$display("        **  Simulation Failed!!   **   /^ ^ ^ \\  |");
		$display("        **                        **  |^ ^ ^ ^ |w| ");
		$display("        ****************************   \\m___m__|_|");
		$display("         There are %d errors                     ", error);
		$display("\n");
	end
end

initial begin
	#0		in1 = 8'he0; in2 = 8'he0; //-1 * -1 = 1, 0000_0001 
    #1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'ha8; in2 = 8'h60; //-2.75 * 3 = -8.25, , 1101_1111
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'h66; in2 = 8'h58; //3.1875 * 2.75 = 8.765625 round to 8.75 , 0010_0011
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'h66; in2 = 8'ha6; //3.1875 * -2.8125 = -8.9648 round to 8.75 , 1101_1100
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'he0; in2 = 8'h40; //-1 * 2 = -2
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'h31; in2 = 8'h40; //1.53125 * 2 =  3.0625
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'h7c; in2 = 8'h22; //3.875 * 1.0625 = 4.117
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'h66; in2 = 8'h7c; //3.1875 * 3.875 = 12.35
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9		in1 = 8'h66; in2 = 8'h31; //3.1875 * 1.53125 = 4.88
	#1 ;
		$display (" in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#20		$finish ;
	
end

initial begin
	`ifdef FSDB
		$fsdbDumpfile("fixedpoint_s.fsdb") ;
		$fsdbDumpvars;
	`endif
end

`ifdef syn
	initial $sdf_annotate("fixedpoint_s_syn.sdf",fixedpoint_s);
`endif



endmodule
