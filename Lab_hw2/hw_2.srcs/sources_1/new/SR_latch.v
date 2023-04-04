`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2023 02:14:24 PM
// Design Name: 
// Module Name: SR_latch
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
module NAND_gate(input a, input b, output z);
    assign z = ~(a & b);
endmodule


module SR_latch(input S, input R, output Q, output Qn);
    //intermediate wires
    wire S_nand;
    wire R_nand;
    
    //instantuate NAND gates
    NAND_gate gate1(S,S,S_nand);
    NAND_gate gate2(R,R,R_nand);
    NAND_gate gate3(S_nand, Qn, Q);
    NAND_gate gate4(R_nand, Q, Qn);
endmodule

module SR_latch_EN(input S, input R, input EN, output Q, output Qn);
    //intermediate wires
    wire SEN;
    wire REN;
    
    NAND_gate gate1(S, EN, SEN);
    NAND_gate gate2(R, EN, REN);
    NAND_gate gate3(SEN, Qn, Q);
    NAND_gate gate4(REN, Q, Qn);
endmodule

module SR_flip_flop(input S, input R, input clk, output Q, output Qn);
    // intermediate wires
    wire clk_inv, clk_inv2;
    wire S_clkinv_nand, R_clkinv_nand;
    wire Q0, Qn0;
    wire Q0_clkinv2_nand, Qn0_clkinv2_nand;
    
    NAND_gate gate1(clk, clk, clk_inv);
    NAND_gate gate2(S, clk, S_clkinv_nand);
    NAND_gate gate3(R, clk, R_clkinv_nand);
    NAND_gate gate4(S_clkinv_nand, Qn0, Q0);
    NAND_gate gate5(R_clkinv_nand, Q0, Qn0);
    
    NAND_gate gate6(clk_inv, clk_inv, clk_inv2);
    NAND_gate gate7(Q0, clk_inv2, Q0_clkinv2_nand);
    NAND_gate gate8(Qn0, clk_inv2, Qn0_clkinv2_nand);
    NAND_gate gate9(Q0_clkinv2_nand, Qn, Q);
    NAND_gate gate10(Qn0_clkinv2_nand, Q, Qn);    
    
endmodule