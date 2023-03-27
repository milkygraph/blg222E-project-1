`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2023 01:21:11 PM
// Design Name: 
// Module Name: register
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


module register();
    wire [7:0] In1;
    wire [15:0] In2;
    wire [7:0] Out1;
    wire [15:0] Out2;
    reg [1:0] select;
    reg enable = 1;
    reg clk = 0;

    assign In1 = 8'b11110000;
    assign In2 = 16'b0000000011110011;

    IR_16 second(clk, enable, In2, select, Out2);
    IR_8 first(clk, enable, In1, select, Out1);
    
    initial begin
        select = 2'b00; #100;
        select = 2'b01; #200;
        select = 2'b10; #200;
        select = 2'b11; #200;
        select = 2'b00; #100;
    end
    
    always begin
        clk = ~clk; #100;
    end
         
endmodule
