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
        end //else do nothing
    end
    
    assign Q = Reg;
    
endmodule


module IR_16(
    input clk,
    input EN,
    input [7:0] I,
    input L_H,
    input [1:0] fun_sel,
    output [15:0] Q
    );
    
    reg[15:0] Reg;
    
    always @(posedge clk) begin
        if(EN) 
        begin
            case(fun_sel)
                2'b00: begin
                    Reg <= 0;
                end
                2'b01: begin
                    if(L_H) begin
                        Reg[7:0] = I;
                    end
                    else begin
                        Reg[15:8] = I;
                    end
                end
                2'b10: begin
                    Reg <= Reg - 1;
                end
                2'b11: begin
                    Reg <= Reg + 1;
                end
            endcase
        end // else do nothing
    end
    
    assign Q = Reg;    
endmodule

