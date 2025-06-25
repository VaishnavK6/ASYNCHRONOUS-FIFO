`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2025 16:39:29
// Design Name: 
// Module Name: FIFO_tb
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
module FIFO_tb();

    reg wclk = 0, rclk = 0;
    reg wrst = 1, rrst = 1;
    reg w_en = 0, r_en = 0;
    reg [31:0] wdata = 0;
    wire [31:0] rdata;
    wire full, empty;

    // Instantiate the FIFO Top Module
    FIFO_Top_module uut (
        .wclk(wclk),
        .rclk(rclk),
        .w_en(w_en),
        .r_en(r_en),
        .wrst(wrst),
        .rrst(rrst),
        .wdata(wdata),
        .rdata(rdata),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 wclk = ~wclk;   // 100 MHz
    always #10 rclk = ~rclk;  // 50 MHz

    integer i;

    initial begin
        // Apply reset
        #10 wrst = 1; rrst = 1;
        #20 wrst = 0; rrst = 0;

        // ----------------------
        // Burst Write Phase
        // ----------------------
        for (i = 1; i <= 8; i = i + 1) begin
            @(posedge wclk);
            if (!full) begin
                w_en <= 1;
                wdata <= i;
            end
            @(posedge wclk);
            w_en <= 0;
        end

        // Wait before read burst
        #50;

        // ----------------------
        // Burst Read Phase
        // ----------------------
        for (i = 1; i <= 8; i = i + 1) begin
            @(posedge rclk);
            if (!empty) begin
                r_en <= 1;
            end
            @(posedge rclk);
            r_en <= 0;
        end

        // Wait and finish
        #50;
        $finish;
    end
endmodule


