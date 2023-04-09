`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2023 05:19:34 PM
// Design Name: 
// Module Name: RF_sim
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


module RF_sim();

    reg  [7:0] In;
    wire [7:0] OutA;
    wire [7:0] OutB;
    reg  [1:0] fun_select = 2'b00;
    reg  [3:0] RSel;
    reg  [3:0] TSel;
    reg  [2:0] OutSelA = 3'b001;
    reg  [2:0] OutSelB = 3'b010;

    reg clk = 0;
    
    Register_File uut(clk, In, OutSelA, OutSelB, fun_select, RSel, TSel, OutA, OutB);
    
    initial begin
        fun_select = 2'b01; In = 8'b00000001; RSel = 4'b1010; TSel = 4'b1010; #200;
        fun_select = 2'b11; In = 8'b00001111; RSel = 4'b0101; TSel = 4'b1110; #200;
    end
    
    always begin
        clk = ~clk; #100;
    end
endmodule
