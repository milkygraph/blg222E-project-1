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
module MUX16(input[7:0] I0, input[7:0] I1, input[7:0] I2, input[7:0] I3, input[7:0] I4,
            input[7:0] I5, input[7:0] I6,input[7:0] I7, input[7:0] I8, input[7:0] I9, input[7:0] I10,
            input[7:0] I11,input[7:0] I12,input[7:0] I13,input[7:0] I14,input[7:0] I15,
            input[3:0] sel, output[7:0] O);
    assign O = (sel == 4'b0000)? I0 : 
                    (sel == 4'b0001)? I1 :
                    (sel == 4'b0010)? I2 :
                    (sel == 4'b0011)? I3:
                    (sel == 4'b0100)? I4 :
                    (sel == 4'b0101)? I5 :
                    (sel == 4'b0110)? I6 : 
                    (sel == 4'b0111)? I7 :
                    (sel == 4'b1000)? I8 :
                    (sel == 4'b1001)? I9 :
                    (sel == 4'b1010)? I10:
                    (sel == 4'b1011)? I11:
                    (sel == 4'b1100)? I12 :
                    (sel == 4'b1101)? I13 :
                    (sel == 4'b1110)? I14 : I15; 
endmodule

module ALU(input signed [7:0] A, input signed [7:0] B, input[3:0] fun_sel, input cin, 
output signed[7:0] outALU, output reg[3:0] flags = 0); 
    
    //intermediate wires for addition
    wire [7:0] A_plus_B;
    wire add_overflow;
    wire add_carry;
    
    //intermediate wires for subtraction
    wire[7:0] A_minus_B;
    wire sub_overflow;
    wire sub_carry;
    
    //2's complement addition and subtraction operations 
    add_sub_8bits add(A, B, 1'b0, cin, A_plus_B, add_carry, add_overflow);
    add_sub_8bits subtract(A, B, 1'b1, 1'b1, A_minus_B,sub_carry, sub_overflow);
        
    //intermediate wire for comparison
    wire[7:0] comparison; 
    
    //comparison
    assign comparison = (A_minus_B[7] == 0 && flags[3] == 0)? A : B;
    
    //intermediate wires for asr
    wire[7:0] A_sr, A_asr;
    wire sign;
    
    //arithmetic shift right
    assign sign = A[7];
    assign A_sr = A >> 1;
    assign A_asr[6:0] = A_sr[6:0];
    assign A_asr[7] = sign;
    
    //intermediate wires for csr
    wire signed [7:0] A_shifted;
    wire signed [7:0] A_circular_shift;
    wire csr_cout;
   
    //circular shift right
    assign csr_cout = A[0]; //assign flags[1] = A[0]; ??
    assign A_shifted = A >>> 1;
    assign A_circular_shift[6:0] = A_shifted[6:0];
    assign A_circular_shift[7]  = csr_cout;
    
//    //MUX to select which arithmetic operation will be outputed 

    MUX16 select_op(A, B, ~A, ~B, A_plus_B, A_minus_B, comparison, A & B, A | B, ~(A & B), 
                     A ^ B, A <<< 1, A >>> 1, A << 1, A_asr, A_circular_shift,
                     fun_sel, outALU);
  
    always @(*) begin
        //z flag
        if(outALU == 8'b00000000) begin
            flags[0] = 1'b1;
        end
        else begin
            flags[0] = 1'b0;
        end
        
        //c flag
        if(fun_sel == 4'b0100) begin 
            flags[1] = add_carry;
        end
        else if(fun_sel == 4'b0101) begin
            flags[1] = sub_carry;
        end
        else if(fun_sel == 4'b0110) begin
            flags[1] = sub_carry;
        end
        else if(fun_sel == 4'b1011) begin
            flags[1] = A[7];
        end   
        else if(fun_sel == 4'b1100) begin
            flags[1] = A[0];
        end
         else if(fun_sel == 4'b1111) begin
            flags[1] = csr_cout;
        end    
        else begin
            flags[1] = cin;
        end
        
        //n flag
        if(fun_sel == 4'b1110) begin
            flags[2] = A[7];
        end
        else begin
            flags[2] = outALU[7];
        end          
                 
        //o flag
        if(fun_sel == 4'b0100) begin
            flags[3] = add_overflow;
        end
        if(fun_sel == 4'b0101) begin
            flags[3] = sub_overflow;
        end  
        if(fun_sel == 4'b0100) begin
            flags[3] = sub_overflow;
        end
        if(fun_sel == 4'b0100) begin
            flags[3] = A[7] ^ A[6];
        end     
        else begin
            flags[3] = flags[3];
        end          
    end
    
endmodule

module flag_reg(input[3:0] ALU_flags, input clk, output c);
    reg[3:0] flags;
    
    always@(posedge clk) begin
        flags = ALU_flags;
    end
    
    assign c = flags[1];
endmodule

