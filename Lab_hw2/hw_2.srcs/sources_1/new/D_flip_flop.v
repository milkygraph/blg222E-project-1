`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2023 03:48:24 PM
// Design Name: 
// Module Name: D_flip_flop
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

module D_latch(input D, input EN, output Q, output Qn);
    //intermediate wires
    wire D_EN;
    wire D_comp;
    wire Dcomp_EN;
    
    NAND_gate gate(D, EN, D_EN);
    NAND_gate gate1(D, D, D_comp);
    NAND_gate gate2(D_comp, EN, Dcomp_EN);
    NAND_gate gate3(D_EN, Qn, Q);
    NAND_gate gate4(Dcomp_EN, Q, Qn);
endmodule

module D_flip_flop(input D, input clk, output Q, output Qn);
    //intermediate wires 
    wire Q1, Qn1;
    
    D_latch latch1(D, clk, Q1, Qn1);
    D_latch latch2(Q1, ~clk, Q, Qn); 
endmodule
