`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2025 15:59:44
// Design Name: 
// Module Name: FIFO_Top_module
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


module FIFO_Top_module(
       input wclk,rclk,w_en,r_en,wrst,rrst,
       input [31:0]wdata,
       output [31:0]rdata,
       output full,empty);
       
       wire [3:0] sync_rptr_gray , sync_wptr_gray;
       wire [3:0] wptr_bin,wptr_gray;
       wire [3:0] rptr_bin,rptr_gray;

       Write_pointer_block write_block(.wclk(wclk),
                                       .wrst(wrst),
                                       .w_en(w_en),
                                       .sync_rptr_gray(sync_rptr_gray),
                                       .wptr_bin(wptr_bin),
                                       .wptr_gray(wptr_gray),
                                       .full(full));
                                       
                                       
       Read_Pointer_Block Read_block ( .rclk(rclk),
                                       .rrst(rrst),
                                       .r_en(r_en),
                                       .sync_wptr_gray(sync_wptr_gray),
                                       .rptr_bin(rptr_bin),
                                       .rptr_gray(rptr_gray),
                                       .empty(empty));   
         genvar i;                              
         generate
            for (i = 0; i < 4; i = i + 1) begin : SYNC_RPTR
             Synchronizer sync_r (
            .clk(wclk),
            .rst(wrst),
            .source_signal(rptr_gray[i]),
            .syn_out(sync_rptr_gray[i])
             );
             end
         endgenerate
         
         genvar j;                              
         generate
            for (j = 0; j < 4; j = j + 1) begin : SYNC_WPTR
             Synchronizer sync_w (
            .clk(rclk),
            .rst(rrst),
            .source_signal(wptr_gray[j]),
            .syn_out(sync_wptr_gray[j])
             );
             end
         endgenerate
         
         DUAL_PORT_RAM Ram_Block(.D_IN_A(wdata),
                                 .wclk(wclk),
                                 .rclk(rclk),
                                 .WE_A(w_en & ~full),
                                 .WE_B(r_en & ~empty),
                                 .ADDR_A(wptr_bin[2:0]),
                                 .ADDR_B(rptr_bin[2:0]),
                                 .Q_OUT_B(rdata));
                   
                                                           
endmodule
