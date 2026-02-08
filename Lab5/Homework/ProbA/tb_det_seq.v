`timescale 1ns/10ps
`define cycle 1.0
`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "det_seq_syn.v"
`else
`include "det_seq.v"
`endif

module tb_det_seq();
    reg clk;
    reg rst;
    reg [7:0] data_in;
    wire [2:0] numLPHP;
    wire [2:0] numiVCAD;
    wire finish_flag;

    det_seq det_seq (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .numLPHP(numLPHP),
        .numiVCAD(numiVCAD),
        .finish_flag(finish_flag)
    );
    
    integer i, error;
    reg [2:0] golden [0:1];

    always begin
    #(`cycle/2) clk = ~clk;
  end

    //monitor
    initial begin
        error = 0;

        golden[0] = 5 ;
        golden[1] = 6 ;      

        wait(finish_flag);
        $display("\n\n----------------- Detect Sequence Test  -------------------\n");
            if(numLPHP==golden[0])
                $display("numLPHP %d is correct\n",numLPHP);
            else begin
                $display("numLPHP is Wrong. Your answer is %d , but Correct answer is %d \n",numLPHP,golden[0]);
                error = error + 1;
            end
            if(numiVCAD==golden[1])
                $display("numiVCAD %d is correct\n",numiVCAD);
            else begin
                $display("numiVCAD is Wrong. Your answer is %d , but Correct answer is %d \n",numiVCAD,golden[1]);
                error = error + 1;
            end
        #`cycle  ;
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

        clk = 0;
        rst = 1;
        data_in = 0;
        #`cycle  rst = 0;
        #(`cycle*0.6) data_in = 8'd76;  
        #`cycle  data_in = 8'd80;      
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd80;  
        #`cycle  data_in = 8'd84;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd32; 
        #`cycle  data_in = 8'd83;  
        #`cycle  data_in = 8'd116; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd118; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd110; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd115; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd103; 
        #`cycle  data_in = 8'd97;  
        #`cycle  data_in = 8'd121; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd115; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd108; 
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd107; 
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd110; 
        #`cycle  data_in = 8'd103; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd102; 
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd114; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd97;  
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd98;  
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd121; 
        #`cycle  data_in = 8'd102; 
        #`cycle  data_in = 8'd114; 
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd110; 
        #`cycle  data_in = 8'd100; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd102; 
        #`cycle  data_in = 8'd114; 
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd109; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd68;  


        #`cycle  data_in = 8'd76;  
        #`cycle  data_in = 8'd76;  
        #`cycle  data_in = 8'd80;     
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd76;  
        #`cycle  data_in = 8'd80;  
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd80;   
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd68;  
        #`cycle  data_in = 8'd76;  
        #`cycle  data_in = 8'd80;   
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd80;  
        #`cycle  data_in = 8'd76;  
        #`cycle  data_in = 8'd80;   
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd80;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd68;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd76;    
        #`cycle  data_in = 8'd80;    
        #`cycle  data_in = 8'd72;       
        #`cycle  data_in = 8'd68;   
        #`cycle  data_in = 8'd76;  
        #`cycle  data_in = 8'd80;   
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd80;   
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd68;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd68;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd68;  

        #`cycle  data_in = 8'd73;  
        #`cycle  data_in = 8'd110; 
        #`cycle  data_in = 8'd116; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd114; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd100; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd105; 
        #`cycle  data_in = 8'd86;  
        #`cycle  data_in = 8'd67;  
        #`cycle  data_in = 8'd65;  
        #`cycle  data_in = 8'd68;  
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd115; 
        #`cycle  data_in = 8'd116; 
        #`cycle  data_in = 8'd117; 
        #`cycle  data_in = 8'd100; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd110; 
        #`cycle  data_in = 8'd116; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd97;  
        #`cycle  data_in = 8'd114; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd119; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd108; 
        #`cycle  data_in = 8'd99;  
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd109; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd116; 
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd99;  
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd109; 
        #`cycle  data_in = 8'd101; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd116; 
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd76;  
        #`cycle  data_in = 8'd80;  
        #`cycle  data_in = 8'd72;  
        #`cycle  data_in = 8'd80;  
        #`cycle  data_in = 8'd32;  
        #`cycle  data_in = 8'd108; 
        #`cycle  data_in = 8'd97;  
        #`cycle  data_in = 8'd98;  
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd114; 
        #`cycle  data_in = 8'd97;  
        #`cycle  data_in = 8'd116; 
        #`cycle  data_in = 8'd111; 
        #`cycle  data_in = 8'd114; 
        #`cycle  data_in = 8'd121; 
        #`cycle  data_in = 8'd46;  

        #(`cycle*2) $finish;
    end

initial begin
	`ifdef FSDB
    $fsdbDumpfile("det_seq.fsdb");
	$fsdbDumpvars;
    $fsdbDumpvars("+struct", "+mda", det_seq);
    $fsdbDumpvars("+struct", "+mda", tb_det_seq);
    `endif
end

`ifdef syn
	initial $sdf_annotate("det_seq_syn.sdf", det_seq);
`endif

endmodule

