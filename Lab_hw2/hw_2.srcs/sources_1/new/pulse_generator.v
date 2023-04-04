`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2023 02:39:18 PM
// Design Name: 
// Module Name: pulse_generator
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


module pulse_generator(input[15:0] I, input clk, input load, output O);
    reg carry;
    reg[15:0] data;
    always@(posedge clk) begin
        if(load) begin
            data = I;
        end
        else begin
            carry = data[15];
            data = data <<< 1;
            data[0] = data[15];
        end
    end
    
    assign O = carry;
endmodule
