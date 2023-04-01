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
