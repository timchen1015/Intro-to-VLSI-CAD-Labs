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
//	Filename:		tb_FFO.sv		                             //
//	Description:	testbench for your module	 				 //
// 	Date:			2025/02/13								     //
// 	Version:		1.0	    	                                 //
///////////////////////////////////////////////////////////////////

`timescale 1ns/10ps
`define CYCLE 10

`include "FFO.v"

module tb_FFO;

    reg [7:0] data;
    wire valid;
    wire [2:0] position;
    
    integer i;
    integer err;
    reg [2:0] expected_position;
    reg expected_valid;

    FFO FFO (
        .data(data),
        .valid(valid),
        .position(position)
    );

    initial begin
        err = 0;
        data = 8'b00000000;
        #(`CYCLE);

        for (i = 0; i < 256; i = i + 1) begin
            data = i;
            #(`CYCLE / 2);
            
            if (data == 8'b00000000) begin
                expected_position = 3'b000;
                expected_valid = 1'b0 ;
            end 
            else begin
                expected_position = 3'b000;
                expected_valid = 1'b1 ;
                while (!data[expected_position]) begin
                    expected_position = expected_position + 1;
                end
            end
            
            // Validate results
            if (valid == expected_valid && (expected_valid==1'b0 || position == expected_position)) begin
                $write("Correct! Data = %b, Valid = %b, Position = %d\n", data, valid, position);
            end else begin
                $write("Error: Data = %b, Expected Position = %d, Your Position = %d, Expected Valid = %d, Your Valid = %d\n", data, expected_position, position,expected_valid,valid);
                err = err + 1;
            end

            #(`CYCLE / 2);
        end

        if (err == 0) begin
$display("\n");
$display("\n");             
$display("                               (####)          ");
$display("                             (#######)          ");
$display("                           (#########)          ");
$display("                          (#########)          ");
$display("                         (#########)          ");
$display("                        (#########)          ");
$display("        __&__          (#########)          ");
$display("       /     \\        (#########)   |\\/\\/\\/|              ");
$display("      |       |      (#########)    |      |              ");
$display("      |  (o)(o)       (o)(o)(##)    |      |              "); 
$display("      C   .---_)    ,_C     (##)    | (o)(o)              ");  
$display("       | |.___|    /___,   (##)     C      _)             ");  
$display("       |  \__/       \     (#)       | ,___|              "); 
$display("       /_____\        |    |         |   /                ");   
$display("      /_____/ \       OOOOOO        /____\                ");  
$display("     /         \     /      \      /      \               ");
 
$display("  ▄███████▄    ▄████████    ▄████████    ▄████████  ");
$display("   ███    ███   ███    ███   ███    ███   ███    ███  ");
$display("   ███    ███   ███    ███   ███    █▀    ███    █▀   ");
$display("   ███    ███   ███    ███   ███          ███         ");
$display(" ▀█████████▀  ▀███████████ ▀███████████ ▀███████████  ");
$display("   ███          ███    ███          ███          ███  ");
$display("   ███          ███    ███    ▄█    ███    ▄█    ███  ");
$display("  ▄████▀        ███    █▀   ▄████████▀   ▄████████▀   ");

        end 
        else begin
            $display("\n");
            $display("\n");
$display("                                 _,.-------.,_                                                 ");
$display("                               ,;~'             '~;,                                           ");
$display("                             ,;                     ;,                                         ");
$display("                            ;                         ;                                        ");
$display("                           ,'                         ',                                       ");
$display("                          ,;                           ;,                                      ");
$display("                          ; ;      .           .      ; ;                                      ");
$display("                          | ;   ______       ______   ; |                                      ");
$display("                          |  `/~=     ~= . =~     =~\'  |                                      ");
$display("                          |  ~  ,-~~~^~, | ,~^~~~-,  ~  |                                      ");
$display("                           |   |        }:{        |   |                                       ");
$display("                           |   l       / | \       !   |                                       ");
$display("                           .~  (__,.--= .^. =--.,__)  ~.                                       ");
$display("                           |     ---;' / | \ `;---     |                                       ");
$display("                            \__.       \/^\/       .__/                                        ");
$display("                             V| \                 / |V                                         ");
$display("          __                  | |T~\___!___!___/~T| |                  _____                   ");
$display("       .-~  ~=-.              | |`IIII_I_I_I_IIII'| |               .-~     =-.                ");
$display("      /         \             |  \,III I I I III,/  |              /           Y               ");
$display("     Y          ;              \   `~~~~~~~~~~'    /               i           |               ");
$display("     `.   _     `._              \   .       .   /               __)         .'                ");
$display("       )=~         `-.._           \.    ^    ./           _..-'~         ~=<_                 ");
$display("    .-~                 ~`-.._       ^~~~^~~~^       _..-'~                   ~.               ");
$display("   /                          ~`-.._           _..-'~                           Y              ");
$display("   {        .~=-._                  ~`-.._ .-'~                  _..-~;         ;              ");
$display("    `._   _,'     ~`-.._                  ~`-.._           _..-'~     `._    _.-               ");
$display("       ~~=              ~`-.._                  ~`-.._ .-'~              ~~=~                  ");
$display("     .----.            _..-'  ~`-.._                  ~`-.._          .-~~~~-.                 ");
$display("    /      `.    _..-'~             ~`-.._                  ~`-.._   (        =.               ");
$display("   Y        `=--~                  _..-'  ~`-.._                  ~`-'         |               ");
$display("   |                         _..-'~             ~`-.._                         ;               ");
$display("   `._                 _..-'~                         ~`-.._            -._ _.'                ");
$display("      =-.==      _..-'~                                     ~`-.._        ~`.                  ");
$display("       /        `.                                                ;          Y                 ");
$display("      Y           Y           OOPS! You Failed !                  Y           |                ");
$display("      |           ;                                              `.          /                 ");
$display("      `.       _.'                                                 =-.____.-'                  ");
$display("        ~-----=                        ");
$display("                              Total errors: %d", err);
$display("\n");
$display("\n");


           
        end

        $finish;
    end

    // FSDB dump for waveform (optional)
    initial begin
        `ifdef FSDB
            $fsdbDumpfile("FFO.fsdb");
            $fsdbDumpvars;
        `endif
    end

endmodule