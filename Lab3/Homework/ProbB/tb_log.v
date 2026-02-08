`timescale 1ns/10ps

`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "log_syn.v"
`else
`include "log.v"
`endif

module tb_log;

reg [7:0] x;
wire [7:0] y;

integer error;

// Expected results
reg [7:0] expected_results [0:8];
integer i ;

log ulog(
    .x(x),
    .y(y)
);


initial begin
	error = 0;
	expected_results[0] = 8'b0000_0110 ; //1.5
	expected_results[1] = 8'b0000_1000 ; //1.875
	expected_results[2] = 8'b0000_0100 ; //1.125
	expected_results[3] = 8'b0000_1000 ; //2
	expected_results[4] = 8'b0000_0110 ; //1.4375
	expected_results[5] = 8'b0000_0100 ; //1
	expected_results[6] = 8'b0000_0110 ; //1.375
	expected_results[7] = 8'b0000_0101 ; //1.1875
	expected_results[8] = 8'b0000_0111 ; //1.8125

	for (i = 0; i < 9; i = i + 1) begin
		#5;
		if (y !== expected_results[i]) begin
			error = error + 1;
			$display("Test %0d Failed: x = %b, Expected = %b, Got = %b", i, x, expected_results[i], y);
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
	#0	x = 8'b0110_0000; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b0111_1000; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b0100_1000; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b1000_0000; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b0101_1100; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b0100_0000; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b0101_1000; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b0100_1100; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#9	x = 8'b0111_0100; 
	#1 ;
		$display("x = %b , y = %b ", x , y );
	#20	$finish;
end

initial begin
	`ifdef FSDB
		$fsdbDumpfile("log.fsdb");
		$fsdbDumpvars;
	`endif
end

`ifdef syn
	initial $sdf_annotate("log_syn.sdf", ulog);
`endif

endmodule