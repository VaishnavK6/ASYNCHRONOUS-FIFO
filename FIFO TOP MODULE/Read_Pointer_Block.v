`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2025 15:30:44
// Design Name: 
// Module Name: Read_Pointer_Block
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Read_Pointer_Block(
       input rclk,
       input rrst,
       input r_en,
       input [3:0]sync_wptr_gray,
       output reg [3:0]rptr_bin,
       output reg [3:0]rptr_gray,
       output reg empty);

       always@(posedge rclk) begin
           if(rrst) begin
               rptr_bin <= 0;
               rptr_gray <= 0;
           end else if(r_en && !empty) begin
               rptr_bin <= rptr_bin + 1;
               rptr_gray <= (rptr_bin + 1) ^ ((rptr_bin + 1) >> 1);
           end
       end
       
       always@(*)
        empty <= (rptr_gray == sync_wptr_gray);
endmodule
