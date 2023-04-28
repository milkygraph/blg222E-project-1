`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2023 03:35:24 PM
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


module tristate_buffer(input[7:0] I, input EN, output[7:0] O);
    //wire[7:0] high_impedence = 8'bz;
    
    /*when EN = 1 (I & 1) = I , (z & 0) = 0, I | 0 = I
    when EN = 0 (I & 0) = 0, (z & 1) = z, 0 | z = z */
    
   // assign O = (I & {8{EN}}) | (high_impedence & ~{8{EN}});
   assign O = (EN == 1)? I : 8'bz;
    
endmodule

module bus_8bits(input[7:0] data1, input[7:0]data2, input sel, output[7:0] out);
    tristate_buffer buffer1(data1, ~sel, out);
    tristate_buffer buffer2(data2, sel, out);
endmodule

module part2(input[7:0] data1, input[7:0]data2, input sel, output[7:0] out1, output[7:0] out2);
    //itermediate wires
    wire[7:0] bus_out;
    
    bus_8bits bus(data1, data2, sel, bus_out);
    tristate_buffer buffer1(bus_out, ~sel, out1);
    tristate_buffer buffer2(bus_out, sel, out2);
endmodule

module memory_line(input[7:0] data, input reset, input line_select, 
                   input read, input write, input clk, output[7:0] out);
      //register to store data
      reg[7:0] data_register;
      
      //intermediate wires
      wire[7:0] input_data;
      
      //buffer to connect input data to memory on write and line_select signals
      tristate_buffer input_buffer(data, write & line_select, input_data);
      
      //write operation
      always@(posedge clk) begin
        data_register = input_data;
      end
      
      //clear operation
      always@(negedge reset) begin
        data_register = 8'b0;
      end
      
      //buffer to connect reg data to output line 
      tristate_buffer out_buffer(data_register, read & line_select, out);
                   
endmodule

module memory_8B(input[7:0] data, input[2:0] address, input chip_sel, input reset, 
              input read, input write, input clk, output[7:0] out);
    //intermediate wires
    wire line_sel;
    //buffers to select a memory line (bus)
    tristate_buffer buffer1(data, ~address[0] & ~address [1] & ~address[2] & chip_sel, line_sel);
    tristate_buffer buffer2(data, ~address[0] & ~address [1] & address[2] & chip_sel, line_sel);
    tristate_buffer buffer3(data, ~address[0] & address [1] & ~address[2] & chip_sel, line_sel);
    tristate_buffer buffer4(data, ~address[0] & address [1] & address[2] & chip_sel, line_sel);
    tristate_buffer buffer5(data, address[0] & ~address [1] & ~address[2] & chip_sel, line_sel);
    tristate_buffer buffer6(data, address[0] & ~address [1] & address[2] & chip_sel, line_sel);
    tristate_buffer buffer7(data, address[0] & address [1] & ~address[2] & chip_sel, line_sel);
    tristate_buffer buffer8(data, address[0] & address [1] & address[2] & chip_sel, line_sel);
    
    //memory lines
    memory_line word1(data, reset, line_sel, read, write, clk, out);
    memory_line word2(data, reset, line_sel, read, write, clk, out);
    memory_line word3(data, reset, line_sel, read, write, clk, out);
    memory_line word4(data, reset, line_sel, read, write, clk, out);
    memory_line word5(data, reset, line_sel, read, write, clk, out);
    memory_line word6(data, reset, line_sel, read, write, clk, out);
    memory_line word7(data, reset, line_sel, read, write, clk, out);
    memory_line word8(data, reset, line_sel, read, write, clk, out);
endmodule

module memory_32B(input[7:0] data, input[4:0] address, input reset, 
                  input read, input write, input clk, output[7:0] out);
                  
    //intermediate wires
    wire[1:0] chip_sel = address[1:0];
    wire[2:0] line_sel = address[4:2];
    
    memory_8B chip1(data, line_sel, ~chip_sel[1] & ~chip_sel[0], reset, read, write, clk, out);
    memory_8B chip2(data, line_sel, ~chip_sel[1] & chip_sel[0], reset, read, write, clk, out);
    memory_8B chip3(data, line_sel, chip_sel[1] & ~chip_sel[0], reset, read, write, clk, out);
    memory_8B chip4(data, line_sel, chip_sel[1] & chip_sel[0], reset, read, write, clk, out);
endmodule

module memory_128B(input[31:0] data, input[4:0] address, input reset, 
                  input read, input write, input clk, output[31:0] out);

    //intermediate wires
    wire[7:0] input_byte1, input_byte2, input_byte3, input_byte4;
    wire[7:0] output_byte1, output_byte2, output_byte3, output_byte4;
    
    //store each byte of the 32 bits separately
    assign input_byte1 = data[7:0];
    assign input_byte2 = data[15:8];
    assign input_byte3 = data[23:16];
    assign input_byte4 = data[31:24];
    
    memory_32B memory1(input_byte1, address, reset, read, write, clk, output_byte1);
    memory_32B memory2(input_byte2, address, reset, read, write, clk, output_byte2);
    memory_32B memory3(input_byte3, address, reset, read, write, clk, output_byte3);
    memory_32B memory4(input_byte4, address, reset, read, write, clk, output_byte4);
    
    assign out = {output_byte4, output_byte3, output_byte2, output_byte1};
endmodule