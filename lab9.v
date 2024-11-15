`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 01:46:35 PM
// Design Name: 
// Module Name: lab9
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


module lab9();
endmodule

module seq_mult(
    input clk, en,
    input [3:0] a,b,
    output reg rdy,
    output reg [7:0] p
    
    );
    
    
    parameter[1:0] idle = 0, mult = 1, done = 2;
    reg [1:0] ns, ps;
    reg [7:0] md, md_next;
    reg [7:0] mr, mr_next;
    reg [7:0] p_mem, p_next;
    reg [2:0] shifts = 0;
    
    
    always @(posedge clk)
    begin
        ps<=ns;
        md<=md_next;
        mr<=mr_next;
        p_mem<=p_next;
        if(!en)
        begin
            ps<=idle;
            shifts<=0;
            p_mem<=0;
        end
        if(rdy)
            p<=p_mem;
        if(ns==mult)
            shifts<=shifts+1;
 
    end
    
    always @(*)
    begin
        md_next = md;
        mr_next = mr;
        p_next = p_mem;
        ns = ps;
        case(ps)
            idle:
            begin
                md_next = {4'b0, a};
                mr_next = {4'b0, b};
                if(en)
                    ns = mult;
                else
                    ns = idle;
                rdy = 0;
            end
            
            mult:
            begin
                if(mr[0]==1)
                    p_next = p_mem + md;
                mr_next = mr>>1;
                md_next = md<<1;
                if(!en)
                    ns = idle;
                if(en & shifts==4)
                    ns = done;
                if(en & shifts<4)
                    ns = mult;
                rdy = 0;
            end
            
            done:
            begin
                rdy = 1;
                if(en)
                    ns = done;
                else
                    ns = idle;
            end
                
            default:
            begin
                rdy = 0;
                ns = idle;
            end
        endcase
    end
    
endmodule



module comb_mult(
    input [3:0] a, b,
    output [7:0] p
    );
    wire [0:0] a0b0, a1b0, a2b0, a3b0, a0b1, a1b1, a2b1, a3b1, a0b2, a1b2, a2b2, a3b2, a0b3, a1b3, a2b3, a3b3;
    wire[7:0] pp1, pp2, pp3, pp4;
    assign a0b0 = a[0]*b[0]; assign a1b0 = a[1]*b[0]; assign a2b0 = a[2]*b[0]; assign a3b0 = a[3]*b[0]; 
    assign a0b1 = a[0]*b[1]; assign a1b1 = a[1]*b[1]; assign a2b1 = a[2]*b[1]; assign a3b1 = a[3]*b[1];  
    assign a0b2 = a[0]*b[2]; assign a1b2 = a[1]*b[2]; assign a2b2 = a[2]*b[2]; assign a3b2 = a[3]*b[2]; 
    assign a0b3 = a[0]*b[3]; assign a1b3 = a[1]*b[3]; assign a2b3 = a[2]*b[3]; assign a3b3 = a[3]*b[3];   
    
    assign pp1 = {4'b0, a3b0, a2b0, a1b0, a0b0};
    assign pp2 = {3'b0, a3b1, a2b1, a1b1, a0b1, 1'b0};
    assign pp3 = {2'b0, a3b2, a2b2, a1b2, a0b2, 2'b0};
    assign pp4 = {1'b0, a3b3, a2b3, a1b3, a0b3, 3'b0};
    
    
    assign p = pp1+pp2+pp3+pp4;
    
endmodule
