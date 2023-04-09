`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2023 12:46:30 PM
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


//2's complement adder/subtractor
module add_sub_8bits(input[7:0] a, input[7:0] b, input op, input cin, output[7:0] result, output cout, output overflow);
    //intermediate wires to store b after the xor operation with cin and carry from the addition of each bit
    wire[7:0] b_xored;
    wire[8:0] carry;
    
    //first carry is cin
    assign carry[0] = cin;
    
    //bit by bit b xor operation, addition, and carry storing
    generate
        genvar i;
        for(i = 0; i < 8; i = i + 1) begin
            assign b_xored[i] = b[i] ^ op; //1's complement 
            assign result[i] = a[i] ^ b_xored[i] ^ carry[i];
            assign carry[i + 1] = a[i] & carry[i] |  b_xored[i] & carry[i] | a[i] & b_xored[i];
        end
    endgenerate

    //overflow and carry outputs 
    assign overflow = carry[7] ^ carry[8];
    assign cout = carry[8];
endmodule



