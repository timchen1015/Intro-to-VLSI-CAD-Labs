`timescale 1ns/10ps
`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "moore_syn.v"
`else
`include "moore.v"
`endif

module tb_moore;

reg clk, rst, din;   //inputs
wire qout;           //outputs
integer error;

moore m0 (.qout(qout), .clk(clk), .rst(rst), .din(din));


initial clk = 1'b0;
always #5 clk = ~clk;

//moniter
initial begin
	error=0;
	#25 if(qout==1'd1) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 1 \n",qout);	error = error +1; end
	#10 if(qout==1'd0) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 0 \n",qout);	error = error +1; end
	#10 if(qout==1'd1) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 1 \n",qout);	error = error +1; end	
	#10 if(qout==1'd0) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 0 \n",qout);	error = error +1; end
	#10 if(qout==1'd1) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 1 \n",qout);	error = error +1; end
	#10 if(qout==1'd1) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 1 \n",qout);	error = error +1; end
	#10 if(qout==1'd0) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 0 \n",qout);	error = error +1; end
	#10 if(qout==1'd0) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 0 \n",qout);	error = error +1; end
	#10 if(qout==1'd1) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 1 \n",qout);	error = error +1; end
	#10 if(qout==1'd0) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 0 \n",qout);	error = error +1; end
	#10 if(qout==1'd0) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 0 \n",qout);	error = error +1; end
	#10 if(qout==1'd1) $display("time", $time, "  output is correct\n");
			else begin $display("time", $time, "  qout is Wrong .Your qout is %h , but Correct qout is 1 \n",qout);	error = error +1; end

	if(error === 0)begin
        $display("\n");
        $display("\n");
        $display("        ****************************               ");
        $display("        **                        **       |\\__||  ");
        $display("        **  Congratulations !!    **      / O.O  | ");
        $display("        **                        **    /_____   | ");
        $display("        **  Simulation PASS!!     **   /^ ^ ^ \\  |");
        $display("        **                        **  |^ ^ ^ ^ |w| ");
        $display("        ****************************   \\m___m__|_|");
        $display("\n");
	end
	else begin
        $display("\n");
        $display("\n");
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
      rst=1;
	#20	rst=0; din=1; //s0
	#10	din=0; //s1
	#10	din=0; //s0
	#10	din=1; //s2
	#10	din=0; //s3
	#10	din=1; //s3
	#10	din=0; //s2
    #10	din=0; //s1
    #10	din=0; //s0
	#40 $finish;
end

initial begin
  `ifdef FSDB
	$fsdbDumpfile("moore.fsdb");
	$fsdbDumpvars;
  `endif
  #10000 $finish;
end

`ifdef syn
	initial $sdf_annotate("moore_syn.sdf", m0);
`endif

endmodule
