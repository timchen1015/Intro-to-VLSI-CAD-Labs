`timescale 1ns/10ps
`define cycle 1.0

`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "WashingMachine_syn.v"
`else
`include "WashingMachine.v"
`endif


module tb_WashingMachine();
  reg clk;
	reg rst;
	reg [5:0]slot;
	reg start;
	reg cancel;
	reg [4:0]set_time;
	wire [5:0]refund;
	wire  busy;
	wire  finish;
  integer i,err;
 
  WashingMachine w0(.busy(busy), .finish(finish), .refund(refund), .clk(clk), .rst(rst), .slot(slot), .start(start), .cancel(cancel), .set_time(set_time));

  always begin
    #(`cycle/2) clk = ~clk;
  end

 initial begin
            clk = 1;	rst = 1;	slot = 6'd0;	start = 0;		cancel = 0;		set_time = 0;
    #`cycle  			    rst = 1;
    #(`cycle*0.4)  		rst = 0; 
    #`cycle  						        slot = 6'd50;
	  #`cycle  						        slot = 0;		  start = 1;
	  #`cycle  										              start = 0;
    #`cycle  						        slot = 0;
    #`cycle  						        slot = 0;
    #`cycle  						        slot = 0;
    #`cycle  						        slot = 0;
    #`cycle  						        slot = 0;
    #`cycle  						        slot = 10;
    #`cycle  						        slot = 10;
    #`cycle  						        slot = 20;
    #`cycle  						        slot = 10;
    #`cycle  						        slot = 0;                   cancel = 1;
    #`cycle  						        slot = 0;                   cancel = 0;
    #`cycle  						        slot = 60;      
    #`cycle                     slot = 0;	    start = 0;		cancel = 0;		set_time = 7;
    #`cycle                             	    start = 1;		cancel = 0;		
    #`cycle                             	    start = 0;                  set_time = 0;
    # (7*`cycle);
    #`cycle  						        slot = 10;      
    #`cycle                     slot = 0;	    start = 1;		
    #`cycle                             	    start = 0;
    #`cycle  						        slot = 50;      
    #`cycle                     slot = 0;	    start = 1;		
    #`cycle                             	    start = 0;
    # (2*`cycle)                                            cancel = 1;
    #`cycle                                                 cancel = 0;

   
    #100 $finish;
 end

 


  initial begin
    err = 0;
    #(0.1*`cycle)
    #(4*`cycle)
    for(i=0;i<5;i=i+1) begin
      if(busy)
        err = err;
      else begin
        err=err+1;
        $display("\nWrong! Busy flag should be 1!\n");
      end
      #(`cycle) ;
    end

    if(finish && busy==0 && err==0) begin
      $display("\nSuccessfully completed the first laundry!\n");
      err = err;
    end
    else begin
      $display("\nWrong! There are something error!\n");
      err = err+1;
    end
    //-------------------------------------------------------
    #(5.5*`cycle)
    if(refund==6'd50)
      err = err;
    else begin
      err = err+1;
      $display("\nFxxk! Machine stole my money! Refund should be 50 \n");
    end
    #(0.5*`cycle);
    //-------------------------------------------------------
    #(3.5*`cycle);
    if(refund==6'd10)
      err = err;
    else begin
      err = err+1;
      $display("\nFxxk! Machine stole my money! After the washing machine starts running, it should refund me 10 dollar!\n");
    end
    #(0.5*`cycle);

    for(i=0;i<7;i=i+1) begin
      if(busy)
        err = err;
      else begin
        err=err+1;
        $display("\nWrong! Busy flag should be 1!\n");
      end
      #(`cycle) ;
    end

    if(finish && busy==0 && err==0) begin
      $display("\nSuccessfully completed the second laundry!\n");
      err = err;
    end
    else begin
      $display("\nYour machine is broken! It can not set time!\n");
      err = err+1;
    end
    //-------------------------------------------------------
    #(4*`cycle);
    if(busy==0) begin
      err = err;
    end
    else begin
      $display("\GodTone: Foshin Company!!!!\n");
      err = err+1;
    end
    //-------------------------------------------------------
    #(5.5*`cycle);
    if(refund==0) begin
      err = err;
    end
    else begin
      $display("\GodTone: Foshin Company!!!!\n");
      err = err+1;
    end
    #(0.5*`cycle);
    if(busy==0 && err==0) begin
      err = err;
      $display("\nSuccessfully passed the test! Your washing machine is the strongest in the world!\n");
      $display("\nGodTone: That's amazing!!!!!\n");
      
    end
    else begin
      $display("\GodTone: Foshin Company!!!!\n");
      err = err+1;
    end
    

    if(err===0)begin
          $display("\n");
		  $display("\n");
			$display("        **************************               ");
			$display("        *                        *       |\__||  ");
			$display("        *  Congratulations !!    *      / O.O  | ");
			$display("        *                        *    /_____   | ");
			$display("        *  Simulation PASS!!     *   /^ ^ ^ \\  |");
			$display("        *                        *  |^ ^ ^ ^ |w| ");
			$display("        **************************   \\m___m__|_|");
			$display("\n");
    end
    else begin
          $display("\n");
		  $display("\n");
			$display("        **************************               ");
			$display("        *                        *       |\__||  ");
			$display("        *  OOPS!!                *      / X,X  | ");
			$display("        *                        *    /_____   | ");
			$display("        *  Simulation Failed!!   *   /^ ^ ^ \\  |");
			$display("        *                        *  |^ ^ ^ ^ |w| ");
			$display("        **************************   \\m___m__|_|");
			$display("\n");
    end

   // $finish;
  end

  `ifdef FSDB
  initial begin
       $fsdbDumpfile("WashingMachine.fsdb");
       $fsdbDumpvars;
   end
  `endif

 `ifdef syn
    initial $sdf_annotate("WashingMachine_syn.sdf",w0);
 `endif

endmodule

