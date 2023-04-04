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
    reg J, K;
    reg clk;
    wire Q, Qn;
    
    JK_flip_flop uut(J,K,clk,Q,Qn);
    
    initial begin
        clk = 1'b0; J = 1'b0; K = 1'b1; #100;
        J = 1'b0; K = 1'b1; #100;
        J = 1'b0; K = 1'b1; #100;
        J = 1'b0; K = 1'b0; #100;
        J = 1'b0; K = 1'b0; #100;
        J = 1'b1; K = 1'b0; #100;
        J = 1'b1; K = 1'b0; #100;
        J = 1'b1; K = 1; #100;
        J = 1'b1; K = 1'b1; #100;       
    end
    
    always begin
        clk <= ~clk; #20;
    end
endmodule
