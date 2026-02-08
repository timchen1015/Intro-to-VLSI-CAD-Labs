`timescale 1ns/10ps
`define clkPeriod 10

`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "FIFO_syn.v"
`else
`include "FIFO.v"
`endif

module tb_FIFO;
    reg clk;
    reg rst;
    reg write_en;
    reg read_en;
    reg [31:0] write_data;
    wire [31:0] read_data;
    wire full_flag;
    wire empty_flag;

    FIFO FIFO (
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .write_data(write_data),
        .read_en(read_en),
        .read_data(read_data),
        .full_flag(full_flag),
        .empty_flag(empty_flag)
    );
integer error ;
//monitor
initial begin
	error=0;
	#100
	$display("\n-----------------------FIFO test---------------------------\n");
	if(full_flag==1'd1) 
		$display($time, "  The FIFO is full. full_flag is %d.\n",full_flag);
	else begin 
		$display($time, "  full_flag is Wrong .Your full_flag is %d , but Correct full_flag is 1 \n",full_flag);	
		error = error +1; 
	end
    #10
	if(full_flag==1'd1) 
		$display($time, "  The FIFO is full. full_flag is %d.\n",full_flag);
	else begin 
		$display($time, "  full_flag is Wrong .Your full_flag is %d , but Correct full_flag is 1 \n",full_flag);	
		error = error +1; 
	end
	//---------------------------------read data--------------------------------------// 
    #10	
	if(read_data==32'd1) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read_data is Wrong .Your read_data is %h , but Correct read_data is 00000001 \n",read_data);	
		error = error +1; 
	end
    #10
	if(read_data==32'd2) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read data is Wrong .Your read_data is %h , but Correct src2 is 00000002 \n",read_data);	
		error = error +1; 
	end
    #10
	if(read_data==32'd3) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read data is Wrong .Your read_data is %h , but Correct src2 is 00000003 \n",read_data);	
		error = error +1; 
	end
    #10
	if(read_data==32'd4) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read data is Wrong .Your read_data is %h , but Correct src2 is 00000004 \n",read_data);	
		error = error +1; 
	end
    #10
	if(read_data==32'd5) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read data is Wrong .Your read_data is %h , but Correct src2 is 00000005 \n",read_data);	
		error = error +1; 
	end
    #10
	if(read_data==32'd6) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read data is Wrong .Your read_data is %h , but Correct src2 is 00000006 \n",read_data);	
		error = error +1; 
	end
    #10
	if(read_data==32'd7) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read data is Wrong .Your read_data is %h , but Correct src2 is 00000007 \n",read_data);	
		error = error +1; 
	end
    #10
	if(read_data==32'd8) 
		$display($time, "  read_data %h is correct\n", read_data);
	else begin 
		$display($time, "  read data is Wrong .Your read_data is %h , but Correct src2 is 00000008 \n",read_data);	
		error = error +1; 
	end
    if(empty_flag==1'd1) 
		$display($time, "  The FIFO is empty. empty_flag is %d.\n",empty_flag);
	else begin 
		$display($time, "  empty_flag is Wrong .Your empty_flag is %d , but Correct empty_flag is 1 \n",empty_flag);	
		error = error +1; 
	end
	//-----------------------------------------------------------------------//

	if(error === 0)begin
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
    // clock generation
    always #(`clkPeriod/2) clk = ~clk;

    initial begin
    // Initialize signals
        clk = 1'b0;
        rst = 1'b1;
        write_en = 1'b0;
        read_en = 1'b0;
        write_data = 32'd0;

        #10 rst = 1'b0;

    // Write data into FIFO
        repeat (8) begin
            #10 write_en = 1;
            write_data = write_data + 1;
        end
        #10 write_en = 0;

    // Read data from FIFO
        repeat (8) begin
            #10 read_en = 1;
        end
        #10 read_en = 0;

/*   // Write again after emptying
        repeat (4) begin
            #10 write_en = 1;
            write_data = write_data + 2;
        end
        #10 write_en = 0;

    // Read again
        repeat (4) begin
            #10 read_en = 1;
        end
        #10 read_en = 0;*/

        $finish;
    end
    
    initial begin
        `ifdef FSDB
        $fsdbDumpfile("FIFO.fsdb");
        $fsdbDumpvars;
        $fsdbDumpvars("+struct", "+mda", FIFO);
        `endif
    end

    `ifdef syn
        initial $sdf_annotate("FIFO_syn.sdf", f0);
    `endif
endmodule
