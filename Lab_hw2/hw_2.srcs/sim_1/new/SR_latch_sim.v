`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2023 02:28:42 PM
// Design Name: 
// Module Name: SR_latch_sim
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


module SR_latch_sim();
    reg S,R;
    wire Q, Qn;
    
    SR_latch uut(S,R,Q,Qn);
    
    initial begin
        S = 1; R = 0; #125;
        S = 0; R = 0; #125;
        S = 1; R = 0; #125;
        S = 0; R = 0; #125;
        S = 0; R = 1; #125;
    end
endmodule

module SR_latch_EN_sim();
    reg S,R,clk;
    wire Q, Qn;
    
    SR_flip_flop uut(S,R,clk,Q,Qn);
    
    initial begin
        S = 1; R = 0; clk = 0; #125;
        S = 0; R = 1; #125;
        S = 0; R = 1; #125;
        S = 1; R = 0; #125;
        S = 0; R = 0; #125;
        S = 1; R = 0; #125;
    end
    
    always begin
        clk = ~clk; #125;
    end
endmodule
