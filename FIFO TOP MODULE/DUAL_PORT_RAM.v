`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 14:10:55
// Design Name: 
// Module Name: DUAL_PORT_RAM
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


module DUAL_PORT_RAM(
    input [31:0] D_IN_A,
    input [31:0] D_IN_B,
    input clk,
    input WE_A,
    input WE_B,
    input [2:0] ADDR_A,
    input [2:0] ADDR_B,
    output reg [31:0] Q_OUT_A,
    output reg [31:0] Q_OUT_B
    );
    reg [31:0] ram_vec[7:0];
    //read before write
    always@(posedge clk)begin
    if(WE_A)begin
       ram_vec[ADDR_A]<=D_IN_A;
       end
       Q_OUT_A<=ram_vec[ADDR_A];
       
       end
       
    always@(posedge clk)begin
    if(WE_B)begin
       ram_vec[ADDR_B]<=D_IN_B;
       end
       Q_OUT_B<=ram_vec[ADDR_B];
       
       end        
endmodule
