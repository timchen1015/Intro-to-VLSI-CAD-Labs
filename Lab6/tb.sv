`timescale 1ns/1ps
`define CYCLE_TIME 0.8 // ns, modify according to your design
`define MAX_CYCLE 150000    // adjust this if you need more cycles

// use "make rtl_plot" or "make syn_plot" if you want to plot the image pixel values in terminal
`ifdef plot
`define PLOT_IMG
`endif

// use "make rtl_color" or "make syn_color" if you want to color the pixel values in terminal
`ifdef color
`define USECOLOR
`endif

// use "make syn" to run post-synthesis simulation without plotting image pixel values
// use "make_rtl" to run rtl simulation without plotting image pixel values
`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "cubic_syn.v"
`else
`include "cubic.v"
`endif

module tb (
);

integer err, count;
integer file;  
integer i;

integer error_pixels;
integer j,idx,pv;

reg [7:0]   ANS[0:16383];
//cubic
reg         clk;
reg         rst;
reg         enable;
reg [7:0]   x0;
reg [7:0]   y0;
reg [7:0]   original_w;
reg [7:0]   original_h;
reg [7:0]   scaled_w;
reg [7:0]   scaled_h;
//ImgROM
reg [7:0]   Img_Q;
reg         Img_CEN;
reg [13:0]  Img_A;
//ResultSRAM
reg [7:0]   Result_Q;
reg         Result_CEN;
reg [7:0]   Result_D;
reg [13:0]  Result_A;
reg done;

always begin #(`CYCLE_TIME/2) clk = ~clk; end

`ifdef syn
	initial begin
        $sdf_annotate("cubic_syn.sdf", cubic);
    end
`endif

initial begin
    //initial 
    rst = 0;
    clk = 0;
    enable = 0;
    #(1*`CYCLE_TIME);
    rst = 1;
    #(5*`CYCLE_TIME);
    rst = 0;
    $readmemh("lab6_ans.txt", ANS);
    $readmemh("lab6_img.txt", ImgROM.memory);

    //program start
    enable = 1;
    x0 = 2;
    y0 = 0;
    original_w = 25;
    original_h = 30;
    scaled_w = 61;
    scaled_h = 30;
    wait(done);
    $display("Simulation finish \n");
    checkAns;
    plot_result_bmp;

    $finish;
end

initial begin
    #(`MAX_CYCLE*`CYCLE_TIME)
    $display("-------------------------------------------------------------");
    $display("-- Reach Max cycle!!!!!!");
    $display("-- You can modify MAX_CYCLE in tb.sv if needed.");
    $display("-- Please raise DONE signal after completion");
    $display("-- Simulation terminated");
    $display("-------------------------------------------------------------");
    $finish;
end

initial begin
    $fsdbDumpfile("cubic.fsdb");
    $fsdbDumpvars();
	$fsdbDumpvars("+struct", "+mda", tb);
end

MEM #(.depth(16384)) ImgROM(
  .clk(clk),
  .rst(rst), 
  .A (Img_A), 
  .WEN(1'd1), 
  .CEN(Img_CEN), 
  .D (8'd0 ), 
  .Q (Img_Q )
);

MEM #(.depth(16384)) ResultSRAM(
  .clk(clk     ), 
  .rst(rst), 
  .A (Result_A ), 
  .WEN(Result_WEN), 
  .CEN(Result_CEN), 
  .D (Result_D), 
  .Q (Result_Q)
);

cubic cubic (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .x0(x0),
    .y0(y0),
    .original_w(original_w),
    .original_h(original_h),
    .scaled_w(scaled_w),
    .scaled_h(scaled_h),
    .done(done),

    //ImgROM
    .Img_Q(Img_Q),
    .Img_CEN(Img_CEN),
    .Img_A(Img_A),

    //ResultSRAM
    .Result_Q(Result_Q),
    .Result_CEN(Result_CEN),
    .Result_WEN(Result_WEN),
    .Result_D(Result_D),
    .Result_A(Result_A)
);

task checkAns;
    begin
    err =0;
    for(i=0;i<1830;i=i+1)begin
        if(ANS[i] !== ResultSRAM.memory[i] )begin
            err++ ;
            if(ANS[i] == ResultSRAM.memory[i] + 1|| (ANS[i] == ResultSRAM.memory[i] -1))$write("Rounding or precision problem!!!!!!!!! Result[%d][%d], your answer:%d, correct answer:%d\n", i/61,i%61, ResultSRAM.memory[i], ANS[i]);
       
            else $write("Result[%d][%d], your answer:%d, correct answer:%d\n", i/61,i%61, ResultSRAM.memory[i], ANS[i]);
        end
    end

    error_pixels=0;
    `ifdef PLOT_IMG
    $display("---- origin (%3d , %3d), size %3d x %3d",x0,y0,original_w,original_h);
    `ifdef USECOLOR
    $write("  ");
    for (i=0;i<original_w;i=i+1) begin
            $write("%c[1;34m %2d%c[0m",27,i,27);
    end
    $write("\n");
    `endif
    for(j=0;j<original_h;j=j+1) begin
        `ifdef USECOLOR
            $write("%c[1;34m%2d%c[0m",27,j,27);
        `endif
        for (i=0;i<original_w;i=i+1) begin
            idx = (j + y0) * 29 + (i + x0);
            pv=tb.ImgROM.memory[idx];
            $write(" %2x",pv);
        end
        $write("\n");
    end
    $display("---- resize %3d x %3d",scaled_w,scaled_h);
    `ifdef USECOLOR
    $write("  ");
    for (i=0;i<scaled_w;i=i+1) begin
        $write("%c[1;34m %2d%c[0m",27,i,27);
    end
    $write("\n");
    `endif
    for(j=0;j<scaled_h;j=j+1) begin
        `ifdef USECOLOR
            $write("%c[1;34m%2d%c[0m",27,j,27);
        `endif
        for (i=0;i<scaled_w;i=i+1) begin
            idx=j*scaled_w+i;
            pv=tb.ResultSRAM.memory[idx];
            if (pv ===ANS[idx]) begin
                $write(" %2x",pv);
            end
            else begin
                `ifdef USECOLOR
                $write("%c[1;31m %2x%c[0m",27,pv,27);
                `else
                $write(">%2x",pv);
                `endif
                error_pixels=error_pixels+1;
            end
        end
        $write("\n");
    end
    $display("---- error count %d",error_pixels);
    `endif

    if(err == 0)begin
        
        $display("-------------------------------------------------------------");
        $display("\n");
        $display(" █████╗ ██╗     ██╗         ██████╗  █████╗ ███████╗███████╗");
        $display("██╔══██╗██║     ██║         ██╔══██╗██╔══██╗██╔════╝██╔════╝");
        $display("███████║██║     ██║         ██████╔╝███████║███████╗███████╗");
        $display("██╔══██║██║     ██║         ██╔═══╝ ██╔══██║╚════██║╚════██║");
        $display("██║  ██║███████╗███████╗    ██║     ██║  ██║███████║███████║");
        $display("╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝");
        $display("\n");
        $display("-------------------------------------------------------------");
    end
    else begin
        $display("-------------------------------------------------------------");
        $display("\n");
        $display("        ****************************               ");
        $display("        **                        **       |\__||  ");
        $display("        **  OOPS!!                **      / X,X  | ");
        $display("        **                        **    /_____   | ");
        $display("        **  Simulation Failed!!   **   /^ ^ ^ \\  |");
        $display("        **                        **  |^ ^ ^ ^ |w| ");
        $display("        ****************************   \\m___m__|_|");
        $display("         Totally has %d errors                     ", err); 
        $display("\n");
        $display("-------------------------------------------------------------");
    end
    end
    endtask

task plot_result_bmp;
    integer obmp, i, j;
    integer mem_addr;
    begin
        $display("Plotting cubic result to bmp...");
        obmp = $fopen("cubic_result.bmp", "wb");
        if (obmp == 0) begin
            $display("Error: Failed to open cubic_result.bmp for writing!");
            $finish;
        end

        $fwrite(obmp, "%c%c", 8'h42, 8'h4D);
        $fwrite(obmp, "%c%c%c%c", 8'hB6, 8'h0B, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h00, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h36, 8'h04, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h28, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h3D, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h1E, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c", 8'h01, 8'h00);
        $fwrite(obmp, "%c%c", 8'h08, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h00, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h00, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h00, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h00, 8'h00, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h00, 8'h01, 8'h00, 8'h00);
        $fwrite(obmp, "%c%c%c%c", 8'h00, 8'h01, 8'h00, 8'h00);

        for (i = 0; i < 256; i = i + 1) begin
            $fwrite(obmp, "%c%c%c%c", i[7:0], i[7:0], i[7:0], 8'h00);
        end

        for (i = 29; i >= 0; i = i - 1) begin
            for (j = 0; j < 61; j = j + 1) begin
                $fwrite(obmp, "%c", tb.ResultSRAM.memory[i * 61 + j]);
            end
            $fwrite(obmp, "%c%c%c", 8'h00, 8'h00, 8'h00);
        end

        $fflush(obmp);
        $fclose(obmp);
        $display("Cubic result plotted to cubic_result.bmp");
    end
endtask

endmodule

module MEM #(parameter depth=16384)(clk, rst, A, CEN, WEN, D, Q);

  input                                 clk;
  input                                 rst;
  input  [$clog2(depth)-1:0]              A;
  input                                 CEN;
  input                                 WEN;
  input  [7:0]                            D;
  output [7:0]                            Q;

  reg    [7:0]                            Q;
  reg    [$clog2(depth)-1:0]      latched_A;
  reg    [$clog2(depth)-1:0]  latched_A_neg;
  reg    [7:0] memory           [0:depth-1];
  integer                                 j;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
        for ( j=0 ; j<depth; j=j+1) begin
            memory[j] <= 7'b0;
        end
    end
    else begin
        if (~WEN && ~CEN ) begin
            memory[A] <= D;
        end
        if (~CEN) begin
           latched_A <= A;
        end
            
    end
  end
  
  always@(negedge clk) begin
    if (~CEN) latched_A_neg <= latched_A;
  end
  
  always @(*) begin
    if (~CEN) begin
      Q = memory[latched_A_neg];
    end
    else begin
      Q = 8'hzz;
    end
  end

endmodule
