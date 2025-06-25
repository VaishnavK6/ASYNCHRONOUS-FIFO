`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 19:19:02
// Design Name: 
// Module Name: Synchronizer
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


module Synchronizer(
    input clk,
    input source_signal,
    output reg syn_out
    );
    reg syn_ff1;
    always@(posedge clk)begin
       syn_ff1<=source_signal;
       syn_out<=syn_ff1;
       end
       
endmodule
