`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2023 06:41:37 PM
// Design Name: 
// Module Name: JK_flip_flop_sim
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


module JK_flip_flop_sim();
    reg J = 0, K = 0;
    reg clk;
    wire Q, Qn;
    
    JK_flip_flop uut(J,K,clk,Q,Qn);
    
    initial begin
        clk = 0;
        J = 0; K = 0; #100;
        J = 0; K = 1; #100;
        J = 0; K = 0; #100;
        J = 1; K = 1; #100;
        J = 1; K = 1; #100;
        J = 0; K = 1; #100;
        
    end
    
    always begin
        clk = ~clk; #100;
    end
endmodule
