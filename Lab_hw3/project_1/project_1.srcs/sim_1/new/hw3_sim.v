`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2023 07:36:45 PM
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
/*Example Memory Simulation
• Reset all lines
• Write 25 to Address 30
• Write 15 to Address 20
• Read Address 12
• Write 18 to Address 10
• Read Address 15
• Read Address 30
• Read Address 10*/

module memory_32B_sim();
    reg[7:0] data;
    reg[4:0] address;
    reg reset, read, write, clk,;
    wire[7:0] out;
    
    memory_32B uut(data, address, reset, read, write, clk, out);
    initial begin
        clk = 0;
        reset = 1; #20;
        reset = 0;
        data = 8'b25; write = 1'b1; address = 5'd30; #105;
        data = 8'b15; write = 1'b1; address = 5'd20; #125;
        write = 1'b0; read = 1'b1; address = 5'd20; #125;
        write = 1'b0; read = 1'b1; address = 5'd12; #125;
        data = 8'b18; write = 1'b1; address = 5'b10; #125;
        write = 1'b0; read = 1'b1; address = 5'd15; #125;
        write = 1'b0; read = 1'b1; address = 5'd30; #125;
        write = 1'b0; read = 1'b1; address = 5'd10; #125;
    end
    
    always begin
        clk = ~clk #10;
    end
endmodule
