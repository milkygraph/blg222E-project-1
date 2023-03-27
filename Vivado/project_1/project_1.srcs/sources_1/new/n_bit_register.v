`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2023 12:58:14 PM
// Design Name: 
// Module Name: n_bit_register
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


module n_bit_register
    #(parameter N = 10)(
    input clk,
    input EN,
    input [N-1:0] I,
    input [1:0] fun_sel,
    output[N-1:0] Q
    );
    
    reg [N-1:0] Reg = 0;

    always @(posedge clk) begin
        if(EN) 
        begin
            case(fun_sel)
                2'b00: begin
                    Reg <= 0;
                end
                2'b01: begin
                    Reg <= I;
                end
                2'b10: begin
                    Reg <= Reg - 1;
                end
                2'b11: begin
                    Reg <= Reg + 1;
                end
            endcase
        end
    end
    
    assign Q = Reg;
    
endmodule


module IR_16(
    input clk,
    input EN,
    input [15:0] I,
    input [1:0] fun_sel,
    output [15:0] Q
    );
    parameter N = 16;
    n_bit_register #(16) first(clk, EN, I, fun_sel, Q);
    
endmodule

module IR_8(
    input clk,
    input EN,
    input [7:0] I,
    input [1:0] fun_sel,
    output [7:0] Q
    );
    n_bit_register #(8) second(clk, EN, I, fun_sel, Q);
    
endmodule



