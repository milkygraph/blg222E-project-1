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

module ALU(input signed [7:0] A, input signed [7:0] B, input[3:0] fun_sel, 
output signed [7:0] outALU, output reg[3:0] flags = 0); 
    // result of operation
    reg[8:0] result;
    reg counter;


    always @(*) begin
        //operations
        case(fun_sel)
        4'b0000: begin 
            result = A;
        end
        4'b0001: begin
            result = B;
        end
        4'b0010: begin
            result = ~A;
        end
        4'b0011: begin
            result = ~B;
        end
        4'b0100: begin
            result = A + B + flags[1];
            flags[1] = result[8];
            flags[3] = A[7] & B[7] & ~result[7] | ~A[7] & ~B[7] & result[7];
        end 
        4'b0101: begin
            result = A - B;
            flags[1] = result[8];
            flags[3] = ~A[7] & B[7] & result[7] | A[7] & ~B[7] & ~result[7];         
        end
        4'b0110: begin
            //subtraction
            result = A - B;
            flags[1] = result[8];
            flags[3] = ~A[7] & B[7] & result[7] | A[7] & ~B[7] & ~result[7];   
            
            //comparison
            if(result[7] == 0 && flags[3] == 0) begin
                result = A;
            end 
            else begin
                result = B;
            end
        end
        4'b0111: begin
            result =  A & B;
        end
        4'b1000: begin
            result =  A | B;
        end 
        4'b1001: begin
            result =  ~(A & B);
        end
        4'b1010: begin
            result =  A ^ B;
        end
        4'b1011: begin
            result = A <<< 1;
            flags[1] = A[7];
        end
        4'b1100: begin
            result = A >>> 1;
            flags[1] = A[0];
        end 
        4'b1101: begin
            result = A << 1;
            flags[3] = A[7] ^ A[6];
        end
        4'b1110: begin
            result = A >> 1;
        end
        4'b1111: begin
            flags[1] = A[0];
            result = A >>> 1;
            result[7] = flags[1];
        end
        endcase
                                               
        //z flag
        if(result == 8'b00000000) begin
            flags[0] = 1'b1;
        end
        else begin
            flags[0] = 1'b0;
        end  
      
        //n flag; in asr sign is preserved so this will not change anything
        flags[2] = result[7];
       
    end 
    assign outALU = result;   
endmodule


