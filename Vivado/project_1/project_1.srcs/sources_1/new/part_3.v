`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2023 11:13:04 PM
// Design Name: 
// Module Name: part_3
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

module ALU(input signed [7:0] A, input signed [7:0] B, input[3:0] fun_sel, input cin, 
output signed[7:0] outALU, output[3:0] flags); 
    //intermediate wires for addition
    wire [7:0] A_plus_B;
    wire add_overflow;
    wire add_carry;
    
    //intermediate wires for subtraction
    wire[7:0] A_minus_B;
    wire sub_overflow;
    wire sub_carry;
    
    //intermediate wires for asr
    wire signed [7:0] A_sr;
    wire signed [7:0] A_asr;
    wire sign;
    //intermediate wires for csr
    wire signed [7:0] A_shifted;
    wire signed [7:0] A_circular_shift;
    wire cout;
    
    
    //2's complement addition and subtraction operations 
     add_sub_8bits add(A, B, 1'b0, flags[1], A_plus_B, add_carry, add_overflow);
     add_sub_8bits subtract(A, B, 1'b1, 1'b1, A_minus_B,sub_carry, sub_overflow);
    
    //arithmetic shift right
    assign sign = A[7];
    assign A_sr = A >> 1;
    assign A_asr[6:0] = A_sr[6:0];
    assign A_asr[7] = sign;
    
    //circular shift right
    assign cout = A[0]; //assign flags[1] = A[0]; ??
    assign A_shifted = A >>> 1;
    assign A_circular_shift[6:0] = A_shifted[6:0];
    assign A_circular_shift[7]  = cout;
    
    
    assign outALU = (fun_sel == 4'b0000)? A : 
                    (fun_sel == 4'b0001)? B :
                    (fun_sel == 4'b0010)? ~A :
                    (fun_sel == 4'b0011)? ~B :
                    (fun_sel == 4'b0100)? A_plus_B :
                    (fun_sel == 4'b0101)? A_minus_B :
                    (fun_sel == 4'b0110)? A_minus_B : //comparison is done by subtraction
                    (fun_sel == 4'b0111)? A & B :
                    (fun_sel == 4'b1000)? A | B :
                    (fun_sel == 4'b1001)? ~(A & B) :
                    (fun_sel == 4'b1010)? A ^ B:
                    (fun_sel == 4'b1011)? A <<< 1:
                    (fun_sel == 4'b1100)? A >>> 1 :
                    (fun_sel == 4'b1101)? A << 1 :
                    (fun_sel == 4'b1110)? A_asr : 
                    (fun_sel == 4'b1111)? A_circular_shift : 8'bz;
  
   //Z assignment
   assign flags[0] = (outALU == 8'b00000000)? 1'b1 : 1'b0;
   
   //c assignment
   assign flags[1] = (fun_sel == 4'b0100)? add_carry : 
                     (fun_sel == 4'b0101)? sub_carry :
                     (fun_sel == 4'b0110)?  sub_carry : 
                     (fun_sel == 4'b1011)? A[7] :
                     (fun_sel == 4'b1100)? A[0] : 
                     (fun_sel == 4'b1111)? cout : cin; 
  
  //N assignment                  
  assign flags[2] = (fun_sel == 4'b1110)? A[7] : outALU[7];    
  
  //O assignment
   assign flags[3] = (fun_sel == 4'b0100)? add_overflow : 
                     (fun_sel == 4'b0101)? sub_overflow :
                     (fun_sel == 4'b0110)?  sub_overflow : 
                     (fun_sel == 4'b1101)? A[7] ^ A[6] : 1'b0;     
endmodule

module flag_reg(input[3:0] ALU_flags, input clk, output c);
    reg[3:0] flags;
    
    always@(posedge clk) begin
        flags = ALU_flags;
    end
    
    assign c = flags[1];
endmodule