`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2023 01:43:28 PM
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


module JK_flip_flop_sim(
    );
    reg J;
    reg K;
    reg clk = 1;
    wire Q;
    wire Qn;
    
    JK_flip_flop uut(J,K,clk,Q,Qn);
    
initial begin
        J = 0; K = 1; #100;
        J = 1; K = 0; #100;
        J = 1; K = 1; #100;
        J = 0; K = 1; #100;
        J = 1; K = 1; #100;
        J = 1; K = 0; #100;
        J = 0; K = 1; #100;
        J = 1; K = 1; #100;
        J = 1; K = 0; #100;
        $stop;
    end
    always begin
        clk = ~clk; #50;
    end
endmodule
