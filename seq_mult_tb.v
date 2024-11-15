`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 02:15:32 PM
// Design Name: 
// Module Name: seq_mult_tb
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


module seq_mult_tb;
    reg clk, en;
    reg [3:0] a, b;
    wire rdy;
    wire [7:0] p;
    
    seq_mult uut(clk,en,a,b,rdy,p);
    
    initial
    begin
        clk = 0; en = 0;
        a = 2; b = 3;
        forever #5 clk = ~clk;   
    end
    
    initial
    begin
        #15 en = 1;
        #60 en = 0; a = 8; b = 8;
        #15 en = 1;
        #60 en = 0; a = 5; b = 7;
        #15 en = 1;
        #100 $stop;
    end
endmodule
