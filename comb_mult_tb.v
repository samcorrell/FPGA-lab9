`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 03:25:00 PM
// Design Name: 
// Module Name: comb_mult_tb
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


module comb_mult_tb;
    reg [3:0] a, b;
    wire [7:0] p;
    
    comb_mult uut(a,b,p);
    
    initial
    begin
        a=3; b=1;
        #20;
        a=8; b=8;
        #20;
        a=5; b=7;
        #20;
        a=3; b=5;
        #20 $stop;
    end
endmodule
