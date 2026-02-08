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
//  Autor: 			HAN-YU, CHEN (Heidi)				  	     //
//	Filename:		tb_ALU.sv		                             //
//	Description:	testbench for your module	 				 //
// 	Date:			2025/02/13								     //
// 	Version:		1.0	    	                                 //
///////////////////////////////////////////////////////////////////
`timescale 1ns/10ps
`define CYCLE 10

`include "ALU.v"

module tb_ALU;

    reg [7:0] src1_in, src2_in;
    reg sel_in;
    wire [15:0] result_o;

    integer i;
    reg [15:0] answer;

    integer err = 0;
    integer seed;

    // Instantiate the ALU
    ALU ALU (
        .src1(src1_in),
        .src2(src2_in),
        .sel(sel_in),
        .result(result_o)
    );

    initial begin
        err = 0;
        #(`CYCLE);

        // Test edge cases
        for ( i=0 ; i<10 ; i=i+1 ) begin
            case (i)
                0:  {src1_in, src2_in, sel_in} = {8'hFF, 8'h01, 1'b1};
                1:  {src1_in, src2_in, sel_in} = {8'h80, 8'h80, 1'b1}; 
                2:  {src1_in, src2_in, sel_in} = {8'h00, 8'h00, 1'b1}; 
                3:  {src1_in, src2_in, sel_in} = {8'hFF, 8'hFF, 1'b1}; 
                4:  {src1_in, src2_in, sel_in} = {8'h01, 8'h01, 1'b1}; 
                5:  {src1_in, src2_in, sel_in} = {8'h80, 8'h02, 1'b0}; 
                6:  {src1_in, src2_in, sel_in} = {8'h40, 8'h40, 1'b0}; 
                7:  {src1_in, src2_in, sel_in} = {8'hFF, 8'hFF, 1'b0}; 
                8:  {src1_in, src2_in, sel_in} = {8'h01, 8'hFF, 1'b1}; 
                9:  {src1_in, src2_in, sel_in} = {8'h80, 8'h80, 1'b0}; 
            endcase

            #(`CYCLE / 2);

            if (sel_in)
                answer = src1_in + src2_in;
            else
                answer = src1_in * src2_in;
            
            if (result_o !== answer) begin
                $display("Error!  Your result = %d, answer = %d", result_o, answer);
                $display("src1 = %d, src2 = %d, sel = %d\n", src1_in, src2_in, sel_in);
                err = err + 1;
            end 
            else begin
                $display("Correct! src1 = %d, src2 = %d, sel = %d, result = %d", src1_in, src2_in, sel_in, result_o);
            end

            #(`CYCLE / 2);
        end



        // random test
        seed = $time ; 
        for (i = 0; i < 100; i = i + 1) begin
            src1_in = $random(seed) & 8'hFF; 
            src2_in = $random(seed) & 8'hFF;
            sel_in  = $random(seed) & 1'b1;  
            #(`CYCLE / 2);
            answer =( sel_in )? src1_in + src2_in : src1_in * src2_in;

            if (result_o !== answer) begin
                $display("Error! Your result = %d, answer = %d", result_o, answer);
                $display("src1 = %d, src2 = %d, sel = %d", src1_in, src2_in, sel_in);
                err = err + 1;
            end else begin
                $display("Correct! src1 = %d, src2 = %d, sel = %d, result = %d", src1_in, src2_in, sel_in, result_o);
            end

            #(`CYCLE / 2);
        end

        if (err == 0) begin
            $display("\n");
            $display("\n");                             
            $display("                               / \                      ");
            $display("                              / .'_     ");
            $display("                             / __| \     ");
            $display("             `.             | / (-' |     ");
            $display("           `.  \_..._       :  (_,-/     ");
            $display("         `-. `,'     `-.   /`-.__,'     ");
            $display("            `/ __       \ /     /     ");
            $display("            /`/  \       :'    /     ");
            $display("          _,\o\_o/       /    /     ");
            $display("         (_) ___.--.    /    /     ");
            $display("          `-. -._.i \.      :     ");
            $display("             `.\  ( |:.     |     ");
            $display("            ,' )`-' |:..   / \     ");
            $display("   __     ,'   |    `.:.      `.     ");
            $display("  (_ `---:     )      \:.       \     ");
            $display("   ,'     `. .'\       \:.       )     ");
            $display(" ,' ,'     ,'  \\ o    |:.      /     ");
            $display("(_,'  ,7  /     \`.__.':..     /,,,     ");
            $display("  (_,'(_,'   _gdMbp,,dp,,,,,,dMMMMMbp,,     ");
            $display("          ,dMMMMMMMMMMMMMMMMMMMMMMMMMMMb,     ");
            $display("       .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMb,     ");
            $display("     .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM,     ");
            $display("    ,MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM     ");
            $display("\n");
            $display("  ▄███████▄    ▄████████    ▄████████    ▄████████  ");
            $display("   ███    ███   ███    ███   ███    ███   ███    ███  ");
            $display("   ███    ███   ███    ███   ███    █▀    ███    █▀   ");
            $display("   ███    ███   ███    ███   ███          ███         ");
            $display(" ▀█████████▀  ▀███████████ ▀███████████ ▀███████████  ");
            $display("   ███          ███    ███          ███          ███  ");
            $display("   ███          ███    ███    ▄█    ███    ▄█    ███  ");
            $display("  ▄████▀        ███    █▀   ▄████████▀   ▄████████▀   ");
            $display("\n");
        end else begin
            $display("\n");
            $display("\n");
            $display("                     .--'''''''''--.      ");
            $display("                  .'      .---.      '.      ");
            $display("                 /    .-----------.   \\      ");
            $display("                /        .-----.       \\      ");
            $display("                |       .-.   .-.       |      ");
            $display("                |      /   \ /   \      |      ");
            $display("                 \    | .-. | .-. |    /      ");
            $display("                  '-._| | | | | | |_.-'      ");
            $display("                      | '-' | '-' |      ");
            $display("                       \___/ \___/      ");
            $display("                    _.-'  /   \  `-._      ");
            $display("                  .' _.--|     |--._ '.      ");
            $display("                  ' _...-|     |-..._ '      ");
            $display("                         |     |      ");
            $display("                 **************************               ");
            $display("                 *                        *         ");
            $display("                 *  OOPS!!                *       ");
            $display("                 *                        *    ");
            $display("                 *  Simulation Failed!!   *  ");
            $display("                 *                        *   ");
            $display("                 **************************   ");
            $display("                  Total errors: %d", err);
            $display("\n");
        end

        $finish;
    end


    // FSDB dump for waveform (optional)
    initial begin
        `ifdef FSDB
            $fsdbDumpfile("ALU.fsdb");
            $fsdbDumpvars;
        `endif
    end
endmodule
