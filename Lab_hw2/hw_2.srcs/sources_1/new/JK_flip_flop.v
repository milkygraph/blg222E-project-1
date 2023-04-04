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
    wire JQn_nand;
    wire S, R;
    wire KQ_nand;

    NAND_gate gate1(J, Qn, JQn_nand);
    NAND_gate gate2(JQn_nand, JQn_nand, S);
    NAND_gate gate3(K, Q, KQ_nand);
    NAND_gate gate4(KQ_nand, KQ_nand, R);
    
    SR_flip_flop JK_flipflop(S, R, clk, Q, Qn);
       
endmodule

module sr_latch_with_enable(
    input S,
    input R,
    input E,
    output Q,
    output Q_neg
    );
    wire Snot, Rnot;
    
    nand_gate nand1(S, E, Snot);
    nand_gate nand2(R, E, Rnot);
    nand_gate nand3(Snot, Q_neg, Q);
    nand_gate nand4(Rnot, Q, Q_neg);    
endmodule

module sr_flip_flop(input D, input clk, output Q, output Qn);
    wire NOT_clk;
    wire NOT_D;
    wire QM;
    wire QMn;
    
    nand_gate NOT1(clk, clk, NOT_clk);
    nand_gate NOT2(D, D, NOT_D);
    
    sr_latch_with_enable latch1(D, NOT_D, NOT_clk, QM, QMn);
    sr_latch_with_enable latch2(QM, QMn, clk, Q, Qn);

endmodule 

module jk_flip_flop (input J, input K, input clk, output Q, output Qn);
    wire J_and_Qn, J_and_Qn_not;
    wire NOT_K;
    wire K_and_Q, K_and_Q_not;
    wire OR_out;
    
    nand_gate NOT1(K, K, NOT_K);
    nand_gate AND2(NOT_K, Q, K_and_Q_not);
    nand_gate NOT2(K_and_Q_not, K_and_Q_not, K_and_Q);
    nand_gate AND3(J, Qn, J_and_Qn_not);
    nand_gate NOT3(J_and_Qn_not, J_and_Qn_not, J_and_Qn);
    nand_gate OR(K_and_Q_not, J_and_Qn_not, OR_out);
    
    sr_flip_flop flip(OR_out, clk, Q, Qn);

endmodule
