`timescale 1ns/10ps

`include "top.v"
`define clkPeriod 10

module tb_top();
// ---------------------------------------------------- //
reg						     	clk;
reg						     	rst;
reg		[3:0]					X;
reg		[3:0]					Y;
reg								read_en;
reg								xy_valid;
wire							empty;
wire							finish;
wire 	[31:0]					read_data;

integer i, error;
reg [31:0] golden [0:7];

 top top(
	.clk(clk), 
	.rst(rst),
	.X(X),
	.Y(Y),
	.read_en(read_en),
	.xy_valid(xy_valid),
	.empty(empty),
	.finish(finish),
	.read_data(read_data)
	);

//monitor
initial begin
	error = 0;

	golden[0] = 1;
	golden[1] = 1;
	golden[2] = 2;
	golden[3] = 3;
	golden[4] = 4;
	golden[5] = 5;
	golden[6] = 6;
	golden[7] = 0;


	wait(finish);
	$display("\n\n----------------- First shot -------------------\n");
	for(i=0;i<8;i=i+1) begin
		if(top.fifo.F[i]==golden[i])
			$display("FIFO[%d] is correct\n",i);
		else begin
			$display("FIFO[%d] is Wrong .Your answer is %d , but Correct answer is %d \n",i,top.fifo.F[i],golden[i]);
			error = error + 1;
		end
	end

	#40
	golden[0] = 1;
	golden[1] = 2;
	golden[2] = 3;
	golden[3] = 4;
	golden[4] = 5;
	golden[5] = 6;
	golden[6] = 0;
	golden[7] = 0;
	wait(finish);

	$display("\n\n----------------- Second shot -------------------\n");
	for(i=0;i<8;i=i+1) begin
		if(top.fifo.F[i]==golden[i])
			$display("FIFO[%d] is correct\n",i);
		else begin
			$display("FIFO[%d] is Wrong .Your answer is %d , but Correct answer is %d \n",i,top.fifo.F[i],golden[i]);
			error = error + 1;
		end
	end

	#10 
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


//clock generator
always #(`clkPeriod/2) clk = ~clk;


initial begin
	clk = 0; rst = 1; xy_valid = 0;                 read_en=0;
#10			 rst = 0;                                                                            

#6                    xy_valid = 1;	X = 2; Y = 14;   //score=1
#10					  xy_valid = 1;	X = 3; Y = 12;   //score=1
#10					  xy_valid = 1;	X = 3; Y =  9;	 //score=2
#10					  xy_valid = 1;	X = 4; Y =  3;	 //score=3
#10					  xy_valid = 1;	X =10; Y = 13;	 //score=4
#10					  xy_valid = 1;	X =11; Y = 10;	 //score=5
#10					  xy_valid = 1;	X =10; Y =  3;	 //score=6
#10					  xy_valid = 1;	X = 0; Y = 11;	 //score=0
#10					  xy_valid = 1;	X = 2; Y = 14;	 //score=1
#10					  xy_valid = 0;	X = 2; Y = 14;	 //score=1

#10													read_en=1;
wait(empty);
#6													read_en=0;
#10                   xy_valid = 1;	X = 3; Y = 13;   //score=1
#10					  xy_valid = 1;	X = 3; Y =  8;   //score=2
#10					  xy_valid = 1;	X = 5; Y =  3;	 //score=3
#10					  xy_valid = 1;	X = 9; Y = 13;	 //score=4
#10					  xy_valid = 1;	X =11; Y =  9;	 //score=5
#10					  xy_valid = 1;	X =10; Y =  4;	 //score=6
#10					  xy_valid = 1;	X = 3; Y = 15;	 //score=0
#10					  xy_valid = 1;	X = 2; Y =  1;	 //score=0




#200 $finish;                                                                                                     
end

initial begin
	`ifdef FSDB
	$fsdbDumpfile("top.fsdb");
	$fsdbDumpvars;
    `elsif FSDB_ALL
    $fsdbDumpfile("top.fsdb");
	$fsdbDumpvars;
    $fsdbDumpvars("+struct", "+mda", top.fifo);
    `endif
end
endmodule

