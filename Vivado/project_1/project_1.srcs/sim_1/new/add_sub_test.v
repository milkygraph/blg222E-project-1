`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2023 12:32:30 AM
// Design Name: 
// Module Name: add_sub_test
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


module add_sub_test();
    reg[7:0] A, B;
    wire[7:0] result;
    wire overflow;
    wire carry;
    reg cin;
    
    add_sub_8bits operate(A,B,cin,result,carry,overflow);
    
    initial begin
        A = 8'd100; B = 8'd50; cin = 1'b1; #250;
        A = 8'd50; B = 8'd100; cin = 1'b1; #250;
        A = 8'd127; B = 8'd50; cin = 1'b0; #250;
        A = 8'b10101101; B = 8'b01110011; cin = 1'b1; #250;
         
    end
endmodule
