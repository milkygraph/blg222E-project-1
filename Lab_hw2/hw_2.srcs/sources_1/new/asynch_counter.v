`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2023 02:59:40 AM
// Design Name: 
// Module Name: asynch_counter
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


module asynch_counter(input clk, output[3:0] bits);
    //intermediate wires
    wire Q0, Q1, Q2, Q3;
    wire Qn0, Qn1, Qn2, Qn3;
    wire reset;
    
    assign reset = (Q0 & Q1 & Q2 & Q3);
    JK_flip_flop ff1(~reset, 1'b1, clk, Q0, Qn0);
    JK_flip_flop ff2(~reset, 1'b1, Q0, Q1, Qn1);
    JK_flip_flop ff3(~reset, 1'b1, Q1,  Q2, Qn2);
    JK_flip_flop ff4(~reset, 1'b1, Q2, Q3, Qn3);
    
    assign bits[0] = Q0;
    assign bits[1] = Q1;
    assign bits[2] = Q2;
    assign bits[3] = Q3;
    
endmodule

module synch_counter(input clk, output[3:0] bits);
    //intermediate wires
    wire Q0, Q1, Q2, Q3;
    wire Qn0, Qn1, Qn2, Qn3;
    wire reset;
    
    assign reset = (Q0 & Q1 & Q2 & Q3);    
    //first bit is always toggled so J = 1 and k = 1
    JK_flip_flop ff1(~reset, 1'b1, clk, Q0, Qn0);
    
    //second bit toggles only when first bit is 1
    wire J1 = Q0 & ~reset;
    JK_flip_flop ff2(J1, Q0, clk, Q1, Qn1);
    
    //third bit toggles when both 1st and 2nd are 1
    wire J2, K2;
    assign J2 = Q0 & Q1 & ~reset;
    assign K2 = Q0 & Q1;
    JK_flip_flop ff3(J2, K2, clk,  Q2, Qn2);
    
    //fourth bit toggles when 1st, 2nd, and 3rd are all 1s
    wire J3, K3;
    assign J3 = Q0 & Q1 & Q2 & ~reset;
    assign K3 = Q0 & Q1 & Q2;
    JK_flip_flop ff4(J3, K3, clk, Q3, Qn3);
    
    assign bits[0] = Q0;
    assign bits[1] = Q1;
    assign bits[2] = Q2;
    assign bits[3] = Q3;   
endmodule