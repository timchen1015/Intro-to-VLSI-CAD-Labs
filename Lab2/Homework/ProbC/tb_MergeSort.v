///////////////////////////////////////////////////////////////////
//        ██╗          ██████╗      ██╗  ██╗     ██████╗         //
//        ██║          ██╔══██╗     ██║  ██║     ██╔══██╗        //
//        ██║          ██████╔╝     ███████║     ██████╔╝        //
//        ██║          ██╔═══╝      ██╔══██║     ██╔═══╝         //
//        ███████╗     ██║          ██║  ██║     ██║             //
//        ╚══════╝     ╚═╝          ╚═╝  ╚═╝     ╚═╝             //
//                                                               //
//                                                               //
//                                                               //
//            2025  Introduction To VLSI CAD                     //
//              advisor: Lih-Yih, Chiou                          //
///////////////////////////////////////////////////////////////////
//  Autor: 			CHE-YU, CHANG (Steven)				  	     //
//	Filename:		tb_MergeSort.sv		                         //
//	Description:	testbench for your module	 				 //
// 	Date:			2025/02/13								     //
// 	Version:		1.0	    	                                 //
///////////////////////////////////////////////////////////////////

`timescale 1ns/10ps
`define CYCLE 10.0

//`include "/usr/cad/CBDK/CBDK018_UMC_Faraday_v1.0/orig_lib/fsa0m_a/2009Q2v2.0/GENERIC_CORE/FrontEnd/verilog/fsa0m_a_generic_core_21.lib.src"
`ifdef SYN
`include "/usr/cad/CBDK/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v"
`include "MergeSort_syn.v"
`else
`include "MergeSort.v"
`endif

module tb;



integer i, j,m,n,k,t,a,b;
reg [3:0] in1, in2, in3, in4, in5, in6;
reg [3:0] out_ans[0:5];
reg [3:0]temp;
wire [3:0]out1, out2, out3, out4, out5, out6;
integer err;


MergeSort MergeSort(
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .in4(in4),
    .in5(in5),
    .in6(in6),
    .out1(out1),
    .out2(out2),
    .out3(out3),
    .out4(out4),
    .out5(out5),
    .out6(out6)
);

initial begin
    err = 0; 
    # (`CYCLE);

    for (i = 0; i < 5; i=i+1) begin
        for (j = 0; j < 5; j=j+1) begin
            for (m = 0; m < 5; m=m+1) begin
                for (n = 0; n < 5; n=n+1) begin
                    for (k = 0; k < 7; k=k+1) begin
                        for (t = 0; t < 15; t=t+1) begin
                            // feed input
                            in1 = i;
                            in2 = j;
                            in3 = m;
                            in4 = n;
                            in5 = k;
                            in6 = t;
                            # (`CYCLE/2);
            

                            // check answer
                            out_ans[0] = in1;
                            out_ans[1] = in2;
                            out_ans[2] = in3;
                            out_ans[3] = in4;
                            out_ans[4] = in5;
                            out_ans[5] = in6;
                            for (a = 0; a < 5; a=a+1) begin
                                 for (b= 0; b < 5-a; b=b+1) begin
                                    if(out_ans[b]<out_ans[b+1]) begin
                                        temp = out_ans[b];
                                        out_ans[b] = out_ans[b+1];
                                        out_ans[b+1] = temp;
                                    end
                                 end
                            end

                            if( (out_ans[0]==out1) && (out_ans[1]==out2) && (out_ans[2]==out3) && (out_ans[3]==out4) && (out_ans[4]==out5) && (out_ans[5]==out6) ) begin
                                $display("Correct!!!! The correct answer is %d %d %d %d %d %d", out_ans[0],out_ans[1],out_ans[2],out_ans[3],out_ans[4],out_ans[5]);
                            end
                            else begin
                                err = err + 1;
                                $display("The correct answer is %d %d %d %d %d %d", out_ans[0],out_ans[1],out_ans[2],out_ans[3],out_ans[4],out_ans[5]);
                                $display("Error: Your answer is %d %d %d %d %d %d,",out1,out2,out3,out4,out5,out6);
                                $display("---------------------------------------------------------------------------------\n");
                            end
                            # (`CYCLE/2);
                        end
                    end
                end
            end
        end
    end
    

    if ((err) === 0) begin
        $display("\n");               
        $display("               -=====-                      ");
        $display("                 _..._                                 ");
        $display("               .~     `~.                               ");
        $display("       ,_     /          }                            ");
        $display("      ,_\'--, \   _.'`~~/                              ");                       
        $display("       \'--,_`{_,}    -(                              ");
        $display("        '.`-.`\;--,___.'_                            ");
        $display("          '._`/    |_ _{@}                         ");
        $display("             /     ` |-';/           _                  ");
        $display("            /   \    /  |       _   {@}_                 ");
        $display("           /     '--;_       _ {@}  _Y{@}                 ");
        $display("          _\          `\    {@}\Y/_{@} Y/                  ");
        $display("         / |`-.___.    /    \Y/\|{@}Y/\|//                  ");
        $display("         `--`------'`--`^^^^^^^^^^^^^^^^^^^               ");       
        

        $display("            _______  _______  _______  _______             ");     
        $display("           |       ||   _   ||       ||       |            ");
        $display("           |    _  ||  |_|  ||  _____||  _____|            ");
        $display("           |   |_| ||       || |_____ | |_____             ");
        $display("           |    ___||       ||_____  ||_____  |            ");
        $display("           |   |    |   _   | _____| | _____| |            ");
        $display("           |___|    |__| |__||_______||_______|            ");
        $display("\n");

    end
    else begin
            $display("        ****************************                    ");
            $display("        **                        **                 /)  ");
            $display("        **  OOPS!!                **        //___// ((     ");
            $display("        **                        **        \`@_@'/  ))    ");
            $display("        **  Simulation Failed!!   **        {_:Y:.}_//      ");
            $display("        **                        **     --{_}^-'{_}--      ");
            $display("        ****************************                        ");
            $display("         Totally has %d errors                         ", err); 
            $display("\n");
        end
		$finish;
end  

initial begin
	`ifdef FSDB
		$fsdbDumpfile("MergeSort.fsdb") ;
		$fsdbDumpvars;
	`endif
end

`ifdef SYN
	initial $sdf_annotate("MergeSort_syn.sdf", MergeSort);
`endif

endmodule

//vcs -R -sverilog tb_CLA32.v -debug_access+all -full64 +define+FSDB
//vcs -R -sverilog tb_CLA32.v -debug_access+all -full64 +define+FSDB+syn