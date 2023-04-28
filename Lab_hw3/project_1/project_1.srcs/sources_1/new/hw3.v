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
    wire[7:0] high_impedence = 8'bz;
    
    /*when EN = 1 (I & 1) = I , (z & 0) = 0, I | 0 = I
    when EN = 0 (I & 0) = 0, (z & 1) = z, 0 | z = z */
    
    assign O = (I & EN) | (high_impedence & ~EN);
    
endmodule

module bus_8bits(input[7:0] data1, input[7:0]data2, input sel, output out);
    tristate_buffer buffer1(data1, ~sel, out);
    tristate_buffer buffer2(data2, sel, out);
endmodule

module past2(input[7:0] data1, input[7:0]data2, input sel, output out1, output out2);
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

module memory(input[7:0] data, input[2:0] address, input chip_sel, input reset, 
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

/*In this part, you should implement a 32 byte memory module using 8 byte memory
module. 32 byte memory module should take 8-bit data as input and give 8-bit data as
output. Also, this module should take 5-bit address, reset, read enable, write enable, and
clock inputs. 2 bits of the address input should be used for chip selection and rest of 3
bits should be used for selecting line. For instance, if the address input is 00111, zeroth
chip (8-byte memory) and its 7th line (0-indexed) should be selected. Your module
should be able to perform the operations below.
� At the rising edge of the clock signal, the selected memory line should store the
data value, which is given as input, if the write enable is high.
� The module should clear the all stored data in the memory modules at the falling
edge of the reset signal.
4
� If read enable is high, the output of the module should be the stored data of the
selected memory line.
*/
module memory_32B(input[7:0] data, input[4:0] address, input reset, 
                  input read, input write, input clk, output[7:0] out);
                  
    //intermediate wires
    wire[2:0] chip_sel = 
endmodule