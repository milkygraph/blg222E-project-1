`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2023 01:30:27 PM
// Design Name: 
// Module Name: JK_flip_flop
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


module JK_flip_flop(input J, input K, input clk, output Q, output Qn);
    //intermediate wires 
    wire J_Qn_nand, K_Q_nand;
    wire S , R;
    
    NAND_gate gate1(J, Qn, J_Qn_nand);
    NAND_gate gate2(J_Qn_nand, J_Qn_nand, S);
    NAND_gate gate3(K, Q, K_Q_nand);
    NAND_gate gate4(K_Q_nand, K_Q_nand, R);
    
    SR_flip_flop JK_flipflop(S, R, clk, Q, Qn);
    
endmodule

