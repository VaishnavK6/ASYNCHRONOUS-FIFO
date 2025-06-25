`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2025 11:29:12
// Design Name: 
// Module Name: Write_pointer_block
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


module Write_pointer_block(
       input wclk,
       input wrst,
       input w_en,
       input [3:0]sync_rptr_gray,
       output reg [3:0]wptr_bin,
       output reg [3:0]wptr_gray,
       output reg full);

       reg [3:0] next_bin;

       always@(posedge wclk) begin
           full <= (wptr_gray == {~sync_rptr_gray[3:2], sync_rptr_gray[1:0]});
           if(wrst) begin
               wptr_bin <= 0;
               wptr_gray <= 0;
           end else if(w_en && ~full) begin
               wptr_bin  <=  wptr_bin + 1;
               wptr_gray <= (wptr_bin + 1) ^ ((wptr_bin +1) >> 1);
           end
       end
       
       
endmodule
