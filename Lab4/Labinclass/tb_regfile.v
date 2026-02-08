`timescale 1ns/10ps

`include "regfile.v"

// ---------------------- define ---------------------- //
// ----You can define the parameters you want below---- //
`define clkPeriod 10
`define AddrSize 5
`define DataSize 32

module regfile_tb();
// ---------------------------------------------------- //
// ----------------------   reg  ---------------------- //
reg						     	clk;
reg						     	rst;
reg						     	reg_enable;
reg 					     	reg_write;
reg	[`AddrSize-1:0]	src1_addr;
reg	[`AddrSize-1:0]	src2_addr;
reg	[`AddrSize-1:0]	write_addr;
reg	[`DataSize-1:0]	write_data;

// ----------------------  wire  ---------------------- //
wire [`DataSize-1:0] src1;
wire [`DataSize-1:0] src2;

integer i, error;

regfile RF (.clk(clk), .rst(rst), .reg_enable(reg_enable), .reg_write(reg_write),
			.src1_addr(src1_addr), .src2_addr(src2_addr), .write_addr(write_addr),
			.write_data(write_data), .src1(src1), .src2(src2));

//monitor
initial begin
	error=0;
	#100
	//-----------------------------------------------------------------------// 	
			if(src1==32'h0000_0000) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src1 is Wrong .Your src1 is %h , but Correct src1 is 00000000 \n",src1);	
				error = error +1; 
			end
		 	if(src2==32'hffff_0006) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src2 is Wrong .Your src2 is %h , but Correct src2 is ffff0006 \n",src2);	
				error = error +1; 
			end
	//-----------------------------------------------------------------------//

	#10
	//-----------------------------------------------------------------------// 	
			if(src1==32'hffff_0001) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src1 is Wrong .Your src1 is %h , but Correct src1 is ffff0001 \n",src1);	
				error = error +1; 
			end
		 	if(src2==32'h0000_0000) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src2 is Wrong .Your src2 is %h , but Correct src2 is 00000000 \n",src2);	
				error = error +1; 
			end
	//-----------------------------------------------------------------------//

	#10
	//-----------------------------------------------------------------------// 	
			if(src1==32'hffff_0002) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src1 is Wrong .Your src1 is %h , but Correct src1 is ffff0002 \n",src1);	
				error = error +1; 
			end
		 	if(src2==32'hffff_0003) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src2 is Wrong .Your src2 is %h , but Correct src2 is ffff0003 \n",src2);	
				error = error +1; 
			end
	//-----------------------------------------------------------------------//

	#10
	//-----------------------------------------------------------------------// 	
			if(src1==32'hffff_0005) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src1 is Wrong .Your src1 is %h , but Correct src1 is ffff0005 \n",src1);	
				error = error +1; 
			end
		 	if(src2==32'hffff_ffff) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src2 is Wrong .Your src2 is %h , but Correct src2 is ffffffff \n",src2);	
				error = error +1; 
			end
	//-----------------------------------------------------------------------//

	#10
	//-----------------------------------------------------------------------// 	
			if(src1==32'h0000_0000) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src1 is Wrong .Your src1 is %h , but Correct src1 is 00000000 \n",src1);	
				error = error +1; 
			end
		 	if(src2==32'h00000000) 
				$display("time", $time, "  output is correct\n");
			else begin 
				$display("time", $time, "  src2 is Wrong .Your src2 is %h , but Correct src2 is 00000000 \n",src2);	
				error = error +1; 
			end
	//-----------------------------------------------------------------------//



	
	$display("-----------------------register file---------------------------");
  for(i=0;i<`RegSize;i=i+1)
	begin
	case(i)
	5'd5:begin	
			if(RF.R[i]==32'hffff_0001) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be ffff0001",i,RF.R[i]); error=error+1; end
		end
	5'd15:begin	
			if(RF.R[i]==32'hffff_0002) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be ffff0002",i,RF.R[i]); error=error+1; end
		end
	5'd24:begin	
			if(RF.R[i]==32'hffff_0003) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be ffff0003",i,RF.R[i]); error=error+1; end
		end
	5'd30:begin	
			if(RF.R[i]==32'hffff_0004) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be 00000004",i,RF.R[i]); error=error+1; end
		end
	5'd31:begin	
			if(RF.R[i]==32'hffff_0005) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be 00000005",i,RF.R[i]); error=error+1; end
		end
	5'd2:begin	
			if(RF.R[i]==32'hffff_0006) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be ffff0006",i,RF.R[i]); error=error+1; end
		end
	5'd3:begin	
			if(RF.R[i]==32'hffff_ffff) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be ffffffff",i,RF.R[i]); error=error+1; end
		end
	default:begin
			if(RF.R[i]==32'h0000_0000) $display("R[%d] = %h  ",i,RF.R[i]);
			else begin $display("error! your R[%d] = %h  , but it should be 00000000",i,RF.R[i]); error=error+1; end
		end
	endcase
	end
	
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
	clk = 0; rst = 1; reg_enable = 0; reg_write = 0; write_addr = 5'd0;  write_data = 32'd0;           src1_addr = 5'd0;   src2_addr = 5'd0;
#10			 rst = 0;                                                                                  src1_addr = 5'd0;   src2_addr = 5'd0;

#6                    reg_enable = 1; reg_write = 1; write_addr = 5'd5;  write_data = 32'hffff_0001;   src1_addr = 5'd0;   src2_addr = 5'd0;
#10                   reg_enable = 1; reg_write = 1; write_addr = 5'd15; write_data = 32'hffff_0002;   src1_addr = 5'd0;   src2_addr = 5'd0;
#10                   reg_enable = 1; reg_write = 1; write_addr = 5'd24; write_data = 32'hffff_0003;   src1_addr = 5'd0;   src2_addr = 5'd0;
#10                   reg_enable = 1; reg_write = 1; write_addr = 5'd30; write_data = 32'hffff_0004;   src1_addr = 5'd0;   src2_addr = 5'd0;
#10                   reg_enable = 1; reg_write = 1; write_addr = 5'd31; write_data = 32'hffff_0005;   src1_addr = 5'd0;   src2_addr = 5'd0;
#10                   reg_enable = 1; reg_write = 1; write_addr = 5'd2;  write_data = 32'hffff_0006;   src1_addr = 5'd0;   src2_addr = 5'd0;
#10                   reg_enable = 1; reg_write = 1; write_addr = 5'd0;  write_data = 32'hffff_0007;   src1_addr = 5'd0;   src2_addr = 5'd0;
#10                   reg_enable = 1; reg_write = 1; write_addr = 5'd3;  write_data = 32'hffff_ffff;   src1_addr = 5'd0;   src2_addr = 5'd0;
     
#10                   reg_enable = 1; reg_write = 0;                                                   src1_addr = 5'd1;   src2_addr = 5'd2;
#10                   reg_enable = 1; reg_write = 0;                                                   src1_addr = 5'd5;   src2_addr = 5'd1;
#10                   reg_enable = 1; reg_write = 0;                                                   src1_addr = 5'd15;  src2_addr =5'd24;
#10                   reg_enable = 1; reg_write = 0;                                                   src1_addr = 5'd31;  src2_addr =5'd3;
#10                   reg_enable = 0; reg_write = 0;                                                   src1_addr = 5'd31;  src2_addr =5'd3;

#200 $finish;                                                                                                     
end

initial begin
	`ifdef FSDB
	$fsdbDumpfile("regfile.fsdb");
	$fsdbDumpvars;
    `elsif FSDB_ALL
    $fsdbDumpfile("regfile.fsdb");
    $fsdbDumpvars("+struct", "+mda", RF);
    `endif
end
endmodule

