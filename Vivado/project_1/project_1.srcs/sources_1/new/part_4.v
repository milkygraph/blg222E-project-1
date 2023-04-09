`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2023 11:13:04 PM
// Design Name: 
// Module Name: part_4
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

module MUX4(     
    input  [7:0] I0,
    input  [7:0] I1,
    input  [7:0] I2,
    input  [7:0] I3,
    input  [1:0] Sel, 
    output [7:0] Q);

    assign Q = (Sel == 0) ? I0 :
               (Sel == 1) ? I1 :
               (Sel == 2) ? I2 :
               (Sel == 3) ? I3 :
               7'bx;

endmodule

module MUX2(
    input  [7:0] I0,
    input  [7:0] I1,
    input        Sel, 
    output [7:0] Q);

    assign Q = (Sel == 0) ? I0 :
               (Sel == 1) ? I1 :
               7'bx;

endmodule

module ALUSystem(
    input [1:0] RF_OutASel, 
    input [1:0] RF_OutBSel, 
    input [1:0] RF_FunSel,
    input [3:0] RF_RSel,
    input [3:0] RF_TSel,
    input [3:0] ALU_FunSel,
    input [1:0] ARF_OutASel, 
    input [1:0] ARF_OutBSel, 
    input [1:0] ARF_FunSel,
    input [3:0] ARF_RSel,
    input       IR_LH,
    input       IR_Enable,
    input [1:0]      IR_Funsel,
    input       Mem_WR,
    input       Mem_CS,
    input [1:0] MuxASel,
    input [1:0] MuxBSel,
    input  MuxCSel,
    input       Clock
    );

    // output wires
    wire [7:0 ] A;
    wire [7:0] AOut, BOut; // outputs of RF
    wire ALUcin;
    wire [7:0] ALUOut;
    wire [3:0] ALUOutFlag;

    wire [7:0] ARF_AOut, Address;
    wire [15:0] IROut;
    wire [7:0] MemoryOut;
    wire [7:0] MuxAOut;
    wire [7:0] MuxBOut;
    wire [7:0] MuxCOut;

    MUX4 MUXA(ALUOut, MemoryOut, IROut[7:0], ARF_AOut, MuxASel, MuxAOut);
    MUX4 MUXB(ALUOut, MemoryOut, IROut[7:0], ARF_AOut, MuxBSel, MuxBOut);
    MUX2 MUXC(AOut, ARF_AOut, MuxCSel, MuxCOut);

    Register_File RF(Clock, MuxAOut, RF_OutASel, RF_OutBSel, RF_FunSel, RF_RSel, RF_TSel, RF_O1, BOut);
    
    ALU _ALU(MuxCOut, BOut, ALU_FunSel, ALUcin, ALUOut, ALUOutFlag);
    flag_reg _flag_reg(ALUOutFlag, Clock, ALUcin);

    Address_Register_File ARF(Clock, ARF_FunSel, ARF_RSel, ARF_OutASel, ARF_OutBSel, MuxBOut, ARF_AOut, Address);
    Memory mem(Address, ALUOut, Mem_WR, Mem_CS, Clock, MemoryOut);
    
    IR_16 _IR(Clock, IR_Enable, MemoryOut, IR_LH, IR_Funsel, IROut);

endmodule
