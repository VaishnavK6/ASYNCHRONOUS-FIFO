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
    input wclk,
    input rclk,
    input WE_A,
    input RE_B,
    input [2:0] ADDR_A,
    input [2:0] ADDR_B,
    output reg [31:0] Q_OUT_B
    );
    reg [31:0] ram_vec[7:0];
    //read before write
    always@(posedge wclk)begin
    if(WE_A)begin
       ram_vec[ADDR_A]<=D_IN_A;
       end
      end
       
    always@(posedge rclk)begin
        if(RE_B)
       Q_OUT_B<=ram_vec[ADDR_B];    
       end        
endmodule
