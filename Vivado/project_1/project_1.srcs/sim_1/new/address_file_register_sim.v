`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2023 09:15:53 PM
// Design Name: 
// Module Name: part2sim
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


module address_file_register_sim(

    );
    reg  [7:0] In;
    wire [7:0] OutA;
    wire [7:0] OutB;
    reg  [1:0] fun_select = 2'b00;
    reg  [3:0]RSel ;
    reg  [1:0]OutSelA = 2'b01;
    reg  [1:0]OutSelB = 2'b10;

    reg clk = 1;
    
    
    part2c uut (clk, fun_select, RSel, OutSelA, OutSelB, In, OutA, OutB);
    
    initial begin
        fun_select = 2'b00; In = 8'b00011111; RSel = 4'b1111; #100;
        fun_select = 2'b01; In = 8'b00011111; RSel = 4'b0011; #100;
        fun_select = 2'b10; In = 8'b00011111; RSel = 4'b0001; #100;
        fun_select = 2'b11; In = 8'b00011111; RSel = 4'b0001; #100;
        #1000;
        $finish;
    end   
    always begin
        clk = ~clk; #50;
    end
endmodule
