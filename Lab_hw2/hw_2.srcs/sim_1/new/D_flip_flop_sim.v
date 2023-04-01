`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2023 02:55:01 PM
// Design Name: 
// Module Name: D_flip_flop_sim
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


module D_flip_flop_sim();
    reg D, clk;
    wire Q, Qn;
    
    D_flip_flop uut(D, clk, Q, Qn);
    
    initial begin
        clk = 0; D = 0; #250;
        D = 1; #250;
        D = 0; #250;
        D = 1; #250;
    end
    
    always begin
        clk <= ~clk; #20;
    end
endmodule
