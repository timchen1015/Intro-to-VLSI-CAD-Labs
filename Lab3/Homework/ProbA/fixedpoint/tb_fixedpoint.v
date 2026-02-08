`timescale 1ns/10ps

`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "fixedpoint_syn.v"
`else
`include "fixedpoint.v"
`endif

module tb_fixedpoint;

reg [7:0] in1;
reg [7:0] in2;
wire [7:0] out;
integer error;

// Expected results
reg [7:0] expected_results [0:8];
integer i ;

fixedpoint f0(
	.in1(in1),
	.in2(in2),
	.out(out)
);

initial begin
	error = 0;
	expected_results[0] = 8'b1100_0100;
	expected_results[1] = 8'b0001_0110;
	expected_results[2] = 8'b0010_0010;
	expected_results[3] = 8'b0010_1101;
	expected_results[4] = 8'b0010_0111;
	expected_results[5] = 8'b0000_0110;
	expected_results[6] = 8'b0010_1000;
	expected_results[7] = 8'b0010_0000;
	expected_results[8] = 8'b0111_0000;

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
	#0	in1 = 8'b1110_0000; in2 = 8'b1110_0000; 
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b0111_1000; in2 = 8'b0011_0000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b0100_1000; in2 = 8'b0111_1000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b1010_0000; in2 = 8'b0100_1000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b0111_1100; in2 = 8'b0101_0000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b0010_1000; in2 = 8'b0010_1000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b1101_1000; in2 = 8'b0011_0000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b0111_0000; in2 = 8'b0100_1000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#9	in1 = 8'b1001_0000; in2 = 8'b1100_1000;
	#1 ;
		$display("in1 = %b, in2 = %b, out = %b", in1, in2, out);
	#20	$finish;
end

initial begin
	`ifdef FSDB
		$fsdbDumpfile("fixedpoint.fsdb");
		$fsdbDumpvars;
	`endif
end

`ifdef syn
	initial $sdf_annotate("fixedpoint_syn.sdf", f0);
`endif

endmodule