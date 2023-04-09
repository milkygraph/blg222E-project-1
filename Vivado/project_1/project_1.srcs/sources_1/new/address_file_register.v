`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2023 05:25:39 PM
// Design Name: 
// Module Name: part2c
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



module Address_Register_File(
    input clk,
    input [1:0] FunSel,
    input [3:0] RSel,
    input [1:0] OutASel,
    input [1:0] OutBSel,
    input [7:0] I,
    output reg [7:0] OutA ,
    output reg [7:0] OutB 
    );
    reg [3:0] EN = 0;
    wire [3:0] outputs [7:0];
    always@(RSel)
    begin
        case(RSel)
            4'b0000: begin
                        EN[0] = 0;
                        EN[1] = 0;
                        EN[2] = 0;
                        EN[3] = 0;
                    end
            4'b0001: begin
                        EN[0] = 0;
                        EN[1] = 0;
                        EN[2] = 0;
                        EN[3] = 1;
                        
                    end
            4'b0010: begin
                        EN[0] = 0;
                        EN[1] = 0;
                        EN[2] = 1;
                        EN[3] = 0;
                    end
            4'b0011: begin 
                        EN[0] = 0;
                        EN[1] = 0;
                        EN[2] = 1;
                        EN[3] = 1;
                    end
            4'b0100: begin
                        EN[0] = 0;
                        EN[1] = 1;
                        EN[2] = 0;
                        EN[3] = 0;
                    end
            4'b0101: begin
                        EN[0] = 0;
                        EN[1] = 1;
                        EN[2] = 0;
                        EN[3] = 1;
                    end
            4'b0110: begin
                        EN[0] = 0;
                        EN[1] = 1;
                        EN[2] = 1;
                        EN[3] = 0;
                    end
            4'b0111: begin
                        EN[0] = 0;
                        EN[1] = 1;
                        EN[2] = 1;
                        EN[3] = 1;
                    end
            4'b1000: begin
                        EN[0] = 1;
                        EN[1] = 0;
                        EN[2] = 0;
                        EN[3] = 0;
                    end
            4'b1001: begin
                        EN[0] = 1;
                        EN[1] = 0;
                        EN[2] = 0;
                        EN[3] = 1;
                    end
            4'b1010: begin
                        EN[0] = 1;
                        EN[1] = 0;
                        EN[2] = 1;                        
                        EN[3] = 0;
                    end
            4'b1011: begin
                        EN[0] = 1;
                        EN[1] = 0;
                        EN[2] = 1;
                        EN[3] = 1;
                    end
            4'b1100: begin
                        EN[0] = 1;
                        EN[1] = 1;
                        EN[2] = 0;
                        EN[3] = 0;
                    end
            4'b1101: begin
                        EN[0] = 1;
                        EN[1] = 1;
                        EN[2] = 0;
                        EN[3] = 1;
                    end
            4'b1110: begin
                        EN[0] = 1;
                        EN[1] = 1;
                        EN[2] = 1;
                        EN[3] = 0;
                    end
            4'b1111: begin
                        EN[0] = 1;
                        EN[1] = 1;
                        EN[2] = 1;
                        EN[3] = 1;
                    end    
        endcase        
    end    
    
    n_bit_register #(8) PC(clk, EN[0], I, FunSel, outputs[0]);
    n_bit_register #(8) AR(clk, EN[1], I, FunSel, outputs[1]);
    n_bit_register #(8) SP(clk, EN[2], I, FunSel, outputs[2]);
    n_bit_register #(8) PCPast(clk, EN[3], I, FunSel, outputs[3]);
    
    
    
    always@(*)
    begin
        case(OutASel)
            2'b00: OutA = outputs[1];
            2'b01: OutA = outputs[2];
            2'b10: OutA = outputs[3]; 
            2'b11: OutA = outputs[0];
        endcase
    end
    always@(*)
    begin
        case(OutBSel)
            2'b00: OutB = outputs[1];
            2'b01: OutB = outputs[2];
            2'b10: OutB = outputs[3];
            2'b11: OutB = outputs[0];
        endcase
    end
endmodule
