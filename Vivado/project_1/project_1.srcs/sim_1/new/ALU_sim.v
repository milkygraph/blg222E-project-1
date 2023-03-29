`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2023 10:42:08 PM
// Design Name: 
// Module Name: ALU_sim
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


module ALU_sim();
    wire[7:0] A;
    wire[7:0] B;
    reg[3:0] fun_sel;
    wire[7:0] ALUout;
    wire[3:0] flags;
    wire cin;
    
    assign A = 8'b10101101;
    assign B = 8'b01110011;
    assign cin = 1'b0;
    
    ALU uut(A, B, fun_sel, cin, ALUout, flags);
    
    initial begin
        fun_sel = 4'b0000; #62.5;
        fun_sel = 4'b0001; #62.5;
        fun_sel = 4'b0010; #62.5;
        fun_sel = 4'b0011; #62.5;
        fun_sel = 4'b0100; #62.5;
        fun_sel = 4'b0101; #62.5;
        fun_sel = 4'b0110; #62.5;
        fun_sel = 4'b0111; #62.5;
        fun_sel = 4'b1000; #62.5;
        fun_sel = 4'b1001; #62.5;
        fun_sel = 4'b1010; #62.5;
        fun_sel = 4'b1011; #62.5;
        fun_sel = 4'b1100; #62.5;
        fun_sel = 4'b1101; #62.5;
        fun_sel = 4'b1110; #62.5;
        fun_sel = 4'b1111; #62.5;                       
    end
endmodule
