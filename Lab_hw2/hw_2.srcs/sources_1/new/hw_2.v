`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2023 02:03:16 PM
// Design Name: 
// Module Name: 
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

module SR_flip_flop(input  S, input  R, input  clk, output Q, output Q_neg);
    wire clk_neg, clk_neg_neg, Q_int, Q_neg_int;
    
    NAND_gate clk_NOT(clk, clk, clk_neg);
    NAND_gate clk_NOT_NOT(clk_neg, clk_neg, clk_neg_neg);

    SR_latch_EN sr_1(S, R, clk_neg, Q_int, Q_neg_int);
    SR_latch_EN sr_2(Q_int, Q_neg_int, clk_neg_neg, Q, Q_neg);
endmodule

module JK_flip_flop(input  J, input  K, input clk, output Q, output Q_neg);
    
    wire K_comp, J_Q_neg, K_comp_Q, JK, JK_comp;
    
    NAND_gate K_NOT(K, K, K_comp);
    NAND_gate J_NAND_Q_NOT(J, Q_neg, J_Q_neg);
    NAND_gate K_NOT_NAND_Q(K_comp, Q, K_comp_Q);
    NAND_gate J_K(J_Q_neg , K_comp_Q, JK);
    NAND_gate J_K_NOT(JK, JK, JK_comp);
    
    SR_flip_flop JK_ff(JK, JK_comp, clk, Q, Q_neg);
    
endmodule

module MUX(input I0, input I1, input s, output o);
    assign o = (s == 0) ? I0 : I1;
endmodule

module asynch_counter(input clk, input set, output[3:0] bits);
   //intermediate wires
    wire Q0, Q1, Q2, Q3;
    wire Qn0, Qn1, Qn2, Qn3;
    wire Qs_nand, logic_0, J, K;
    wire clk_1, ff1_clk, ff2_clk, ff3_clk;
    
    assign K = 1;
    assign logic_0 = 0;
    assign Qs_nand = ~(Q1 & Q2 & Q3);
    
    MUX mux_ff0(Qs_nand, logic_0, set, J);
    JK_flip_flop ff0(J, K, clk, Q0, Qn0);
    
    MUX clk_mux(Qn0, clk, ~Qs_nand, clk_1);
    
    MUX mux_ff1(clk_1, clk, set, ff1_clk);
    JK_flip_flop ff1(J, K, ff1_clk, Q1, Qn1);
    
    MUX mux_ff2(Qn1, clk, set, ff2_clk);
    JK_flip_flop ff2(J, K, ff2_clk, Q2, Qn2);

    MUX mux_ff3(Qn2, clk, set, ff3_clk);
    JK_flip_flop ff3(J, K, ff3_clk, Q3, Qn3); 
    
    assign bits[0] = Q0;  
    assign bits[1] = Q1;  
    assign bits[2] = Q2;  
    assign bits[3] = Q3;  
endmodule

module synch_counter(input clk, input set, output[3:0] bits);
    //intermediate wires
    wire Q0, Q1, Q2, Q3;
    wire Qn0, Qn1, Qn2, Qn3;      
    wire J0, J1, J2, J3;
    wire K0, K1, K2, K3;                            
    wire and_1, and_2, and_3, or_1, or_2, or_3;
    wire Qs_nand, logic_0, logic_1;
    
    assign logic_0 = 0;
    assign logic_1 = 1;
    assign Qs_nand = ~(Q1 & Q2 & Q3);
    
    assign and_1 = Q0 & Qs_nand;
    assign or_1 = and_1 | ~Qs_nand;
    assign and_2 = Q1 & or_1;
    assign or_2 = and_2 | ~Qs_nand;
    assign and_3 = Q2 & or_2;
    assign or_3 = and_3 | ~Qs_nand;

    MUX ff0_J(Qs_nand, logic_0, set, J0);
    MUX ff0_K(Qs_nand, logic_1, set, K0);
    
    MUX ff1_J(or_1, logic_0, set, J1);
    MUX ff1_K(or_1, logic_1, set, K1);
    
    MUX ff2_J(or_2, logic_0, set, J2);
    MUX ff2_K(or_2, logic_1, set, K2);
    
    MUX ff3_J(or_3, logic_0, set, J3);
    MUX ff3_K(or_3, logic_1, set, K3);

    JK_flip_flop ff0(J0, K0, clk, Q0, Qn0);
    JK_flip_flop ff1(J1, K1, clk, Q1, Qn1);
    JK_flip_flop ff2(J2, K2, clk, Q2, Qn2);
    JK_flip_flop ff3(J3, K3, clk, Q3, Qn3);  
    
    assign bits[0] = Q0;
    assign bits[1] = Q1;
    assign bits[2] = Q2;
    assign bits[3] = Q3;
endmodule

module pulse_generator(input[15:0] I, input clk, input load, output O);
    reg[15:0] data_reg;
    always@(posedge clk) begin
        if(load) begin
            data_reg = I;
        end
        else begin
            data_reg[0] <= data_reg[15] ;
            data_reg[15] <= data_reg[14] ;
            data_reg[14] <= data_reg[13] ;
            data_reg[13] <= data_reg[12] ;
            data_reg[12] <= data_reg[11] ;
            data_reg[11] <= data_reg[10] ;
            data_reg[10] <= data_reg[9] ;
            data_reg[9] <= data_reg[8] ;  
            data_reg[8] <= data_reg[7] ;
            data_reg[7] <= data_reg[6] ;
            data_reg[6] <= data_reg[5] ;
            data_reg[5] <= data_reg[4] ;
            data_reg[4] <= data_reg[3] ;
            data_reg[3] <= data_reg[2] ;
            data_reg[2] <= data_reg[1] ;
            data_reg[1] <= data_reg[0] ;                        
        end
    end
    
    assign O = data_reg[15];
endmodule