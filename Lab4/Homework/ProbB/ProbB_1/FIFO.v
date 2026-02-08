`timescale 1ns/10ps
`define Depth 8
`define DataSize 32


module FIFO (full_flag, empty_flag, read_data, clk, rst, write_data, write_en, read_en);
input 						clk; 
input 						rst;
input [`DataSize-1:0]		write_data;
input						write_en;
input 						read_en;
output       				full_flag;
output 		      			empty_flag;
output reg [`DataSize-1:0]	read_data;


// put your design here
reg [`DataSize-1:0]queue[`Depth-1:0];
reg [3:0] read_ptr, write_ptr;

assign full_flag = (write_ptr == `Depth);
assign empty_flag = (write_ptr == read_ptr);
integer i;

always @(posedge clk) begin
    if(rst) begin
        read_data <= 32'd0;
        read_ptr <= 4'd0;
        write_ptr <= 4'd0;
        for (i = 0; i < `Depth; i = i + 1) begin
            queue[i] <= 32'd0;
        end
    end
    else begin
        if(write_en && !full_flag) begin
            queue[write_ptr] <= write_data;
            write_ptr <= write_ptr + 4'd1;
        end
        else if(read_en && !empty_flag) begin
            read_data <= queue[read_ptr];
            read_ptr <= read_ptr + 4'd1;
        end
        else begin
            read_data <= 32'd0;
        end
    end
    
end 

endmodule
