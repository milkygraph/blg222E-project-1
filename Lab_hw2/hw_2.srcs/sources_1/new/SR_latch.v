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
    //intermediate wires
    wire S_CLK;
    wire R_CLK;
    
    NAND_gate gate1(S, clk, S_CLK);
    NAND_gate gate2(R, clk, R_CLK);
    NAND_gate gate3(S_CLK, Qn, Q);
    NAND_gate gate4(R_CLK, Q, Qn);
 
endmodule