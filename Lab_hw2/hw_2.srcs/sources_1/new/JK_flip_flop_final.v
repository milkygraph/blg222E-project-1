`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2023 01:26:42 PM
// Design Name: 
// Module Name: jk_flip_flop
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
module NAND_gate(
    input a,
    input b,
    output c
    );
    assign c = ~(a & b);
endmodule

module SR_latch_enable(
    input  S,
    input  R,
    input  E,
    output Q,
    output Qn
    );
    wire S_NAND, R_NAND;
    
    NAND_gate S_E(S, E, S_NAND);
    NAND_gate R_E(R, E, R_NAND);
    NAND_gate for_q(S_NAND, Qn, Q);
    NAND_gate for_q_neg(R_NAND, Q, Qn);
    
endmodule

module SR_flip_flop(
        input  S,
        input  R,
        input  clk,
        output Q,
        output Q_neg);
    wire clk_neg, clk_neg_neg, Q_int, Q_neg_int;
    NAND_gate clk_NOT(clk, clk, clk_neg);
    NAND_gate clk_NOT_NOT(clk_neg, clk_neg, clk_neg_neg);

    SR_latch_enable sr_1(S, R, clk_neg, Q_int, Q_neg_int);
    SR_latch_enable sr_2(Q_int, Q_neg_int, clk_neg_neg, Q, Q_neg);
endmodule

module JK_flip_flop(
        input  J,
        input  K,
        input  clk,
        output Q,
        output Q_neg);
    wire K_comp, J_Q_neg, K_comp_Q, JK, JK_comp;
    
    NAND_gate K_NOT(K, K, K_comp);
    NAND_gate J_NAND_Q_NOT(J, Q_neg, J_Q_neg);
    NAND_gate K_NOT_NAND_Q(K_comp, Q, K_comp_Q);
    NAND_gate J_K(J_Q_neg , K_comp_Q, JK);
    NAND_gate J_K_NOT(JK, JK, JK_comp);
    
    SR_flip_flop JK_ff(JK, JK_comp, clk, Q, Q_neg);
endmodule
