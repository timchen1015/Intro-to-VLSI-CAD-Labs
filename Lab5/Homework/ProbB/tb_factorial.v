`timescale 1ns/10ps
`define cycle 1.0
`ifdef syn
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "factorial_syn.v"
`else
`include "factorial.v"
`endif

module tb_factorial();
    reg clk;
    reg rst;
    reg enable;
    reg [2:0] level;
    wire [13:0] result;
    wire valid;

    factorial factorial (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .level(level),
        .result(result),
        .valid(valid)
    );

    integer i, error;
    reg [13:0] golden [0:7];

    always begin
    #(`cycle/2) clk = ~clk;
  end

    //monitor
    initial begin
        error = 0;

        golden[0] = 6;
        golden[1] = 24;
        golden[2] = 120;
        golden[3] = 720;
        golden[4] = 5040;
        golden[5] = 1;
        golden[6] = 2;
        golden[7] = 1;        

        wait(valid);
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (3!) -------------------\n");
            if(result==golden[0])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[0]);
                error = error + 1;
            end
        #(`cycle*1.9) ;
        wait(valid);
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (4!) -------------------\n");
            if(result==golden[1])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[1]);
                error = error + 1;
            end
        #(`cycle*1.9) ;
        wait(valid);
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (5!) -------------------\n");
            if(result==golden[2])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[2]);
                error = error + 1;
            end
        #(`cycle*1.9) ;
        wait(valid);        
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (6!) -------------------\n");
            if(result==golden[3])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[3]);
                error = error + 1;
            end
        #(`cycle*1.9) ;
        wait(valid);
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (7!) -------------------\n");
            if(result==golden[4])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[4]);
                error = error + 1;
            end
        #(`cycle*1.9) ;
        wait(valid);
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (1!) -------------------\n");
            if(result==golden[5])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[5]);
                error = error + 1;
            end
        #(`cycle*1.9) ;
        wait(valid);
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (2!) -------------------\n");
            if(result==golden[6])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[6]);
                error = error + 1;
            end
        #(`cycle*1.9) ;
        wait(valid);
        #(`cycle*0.1)  ;
        $display("\n\n----------------- Factorial Test1 (0!) -------------------\n");
            if(result==golden[7])
                $display("factorial result %d is correct\n",result);
            else begin
                $display("factorial result is Wrong .Your answer is %d , but Correct answer is %d \n",result, golden[7]);
                error = error + 1;
            end

        #(`cycle*1)  
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
        $finish;
    end

    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        level = 3'd0;
        #`cycle ;
        rst = 0;
        #(`cycle*0.6)
        // level = 3 (3! = 6)
        enable = 1;
        level = 3;
        #`cycle ;
        enable = 0;
        wait(valid);
        #`cycle ;
        // level = 4 (4! = 24)
        enable = 1;
        level = 4;
        #`cycle ;
        enable = 0;
        wait(valid);
        #`cycle ;
        // level = 5 (5! = 120)
        enable = 1;
        level = 5;
        #`cycle ;
        enable = 0;
        wait(valid);
        #`cycle ;
        // level = 6 (6! = 720)
        enable = 1;
        level = 6;
        #`cycle ;
        enable = 0;
        wait(valid);
        #`cycle ;
        // level = 7 (7! = 5040)
        enable = 1;
        level = 7;
        #`cycle ;
        enable = 0;
        wait(valid);
        #`cycle ;
        // level = 1 (1! = 1)
        enable = 1;
        level = 1;
        #`cycle ;
        enable = 0;
        wait(valid);
        #`cycle ;
        // level = 2 (2! = 2)
        enable = 1;
        level = 2;
        #`cycle ;
        enable = 0;
        wait(valid);
        #`cycle ;
        // level = 0 (0! = 1)
        enable = 1;
        level = 0;
        #`cycle ;
        enable = 0;
        wait(valid);
        #(`cycle*5)
        $finish;
    end

initial begin
	`ifdef FSDB
    $fsdbDumpfile("factorial.fsdb");
	$fsdbDumpvars;
    $fsdbDumpvars("+struct", "+mda", factorial);
    $fsdbDumpvars("+struct", "+mda", tb_factorial);
    `endif
end

`ifdef syn
	initial $sdf_annotate("factorial_syn.sdf", factorial);
`endif
endmodule
