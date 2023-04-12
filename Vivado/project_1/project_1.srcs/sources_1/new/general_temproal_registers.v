`timescale 1ns / 1ps

module Register_File(
    input clk,
    input [7:0] I,
    input [2:0] O1_sel,
    input [2:0] O2_sel,
    input [1:0] fun_sel,
    input [3:0] R_sel,
    input [3:0] T_sel,
    output reg [7:0] OutA,
    output reg [7:0] OutB
    );

    /* The idea of this design is to use a unified enable block from which
    ** the active registers will be selected.
    ** Selection of the registers do not affect the enable states
    ** they are only changed by the register selector reg provided below
    */
    
    reg  [7:0] register_selector = 0;
    wire [7:0] outputs[7:0];

    // select the registers that should be made active
    always @(*) begin
        case(R_sel)
            4'b0000: begin
                register_selector[0] = 0;
                register_selector[1] = 0;
                register_selector[2] = 0;
                register_selector[3] = 0;
            end
            4'b0001: begin
                register_selector[0] = 0;
                register_selector[1] = 0;
                register_selector[2] = 0;
                register_selector[3] = 1;
            end 
            4'b0010: begin
                register_selector[0] = 0;
                register_selector[1] = 0;
                register_selector[2] = 1;
                register_selector[3] = 0;
            end 
            4'b0011: begin

                register_selector[0] = 0;
                register_selector[1] = 0;
                register_selector[2] = 0;
                register_selector[3] = 1;
            end 
            4'b0100: begin
                register_selector[0] = 0;
                register_selector[1] = 1;
                register_selector[2] = 0;
                register_selector[3] = 0;
            end 
            4'b0101: begin
                register_selector[0] = 0;
                register_selector[1] = 1;
                register_selector[2] = 0;
                register_selector[3] = 1;
            end 
            4'b0110: begin
                register_selector[0] = 0;
                register_selector[1] = 1;
                register_selector[2] = 1;
                register_selector[3] = 0;
            end 
            4'b0111: begin
                register_selector[0] = 0;
                register_selector[1] = 1;
                register_selector[2] = 1;
                register_selector[3] = 1;
            end 
            4'b1000: begin
                register_selector[0] = 1;
                register_selector[1] = 0;
                register_selector[2] = 0;
                register_selector[3] = 0;
            end 
            4'b1001: begin
                register_selector[0] = 1;
                register_selector[1] = 0;
                register_selector[2] = 0;
                register_selector[3] = 1;
            end 
            4'b1010: begin
                register_selector[0] = 1;
                register_selector[1] = 0;
                register_selector[2] = 1;
                register_selector[3] = 0;
            end 
            4'b1011: begin
                register_selector[0] = 1;
                register_selector[1] = 0;
                register_selector[2] = 1;
                register_selector[3] = 1;

            end 
            4'b1100: begin
                register_selector[0] = 1;
                register_selector[1] = 1;
                register_selector[2] = 0;
                register_selector[3] = 0;
            end 
            4'b1101: begin
                register_selector[0] = 1;
                register_selector[1] = 1;
                register_selector[2] = 0;
                register_selector[3] = 1;
            end 
            4'b1110: begin
                register_selector[0] = 1;
                register_selector[1] = 1;
                register_selector[2] = 1;
                register_selector[3] = 0;
            end 
            4'b1111: begin
                register_selector[0] = 1;
                register_selector[1] = 1;
                register_selector[2] = 1;
                register_selector[3] = 1;
            end 
        endcase
    end
    always @(*) begin
        case(T_sel)
            4'b0000: begin
                register_selector[4] = 0;
                register_selector[5] = 0;
                register_selector[6] = 0;
                register_selector[7] = 0;
            end
            4'b0001: begin
                register_selector[4] = 0;
                register_selector[5] = 0;
                register_selector[6] = 0;
                register_selector[7] = 1;
            end 
            4'b0010: begin
                register_selector[4] = 0;
                register_selector[5] = 0;
                register_selector[6] = 1;
                register_selector[7] = 0;
            end 
            4'b0011: begin
                register_selector[4] = 0;
                register_selector[5] = 0;
                register_selector[6] = 1;
                register_selector[7] = 1;
            end 
            4'b0100: begin
                register_selector[4] = 0;
                register_selector[5] = 1;
                register_selector[6] = 0;
                register_selector[7] = 0;
            end 
            4'b0101: begin
                register_selector[4] = 0;
                register_selector[5] = 1;
                register_selector[6] = 0;
                register_selector[7] = 1;
            end 
            4'b0110: begin
                register_selector[4] = 0;
                register_selector[5] = 1;
                register_selector[6] = 1;
                register_selector[7] = 0;
            end 
            4'b0111: begin
                register_selector[4] = 0;
                register_selector[5] = 1;
                register_selector[6] = 1;
                register_selector[7] = 1;
            end 
            4'b1000: begin
                register_selector[4] = 1;
                register_selector[5] = 0;
                register_selector[6] = 0;
                register_selector[7] = 0;
            end 
            4'b1001: begin
                register_selector[4] = 1;
                register_selector[5] = 0;
                register_selector[6] = 0;
                register_selector[7] = 1;
            end 
            4'b1010: begin
                register_selector[4] = 1;
                register_selector[5] = 0;
                register_selector[6] = 1;
                register_selector[7] = 0;
            end 
            4'b1011: begin
                register_selector[4] = 1;
                register_selector[5] = 0;
                register_selector[6] = 1;
                register_selector[7] = 1;
            end 
            4'b1100: begin
                register_selector[4] = 1;
                register_selector[5] = 1;
                register_selector[6] = 0;
                register_selector[7] = 0;
            end 
            4'b1101: begin
                register_selector[4] = 1;
                register_selector[5] = 1;
                register_selector[6] = 0;
                register_selector[7] = 1;
            end 
            4'b1110: begin
                register_selector[4] = 1;
                register_selector[5] = 1;
                register_selector[6] = 1;
                register_selector[7] = 0;
            end 
            4'b1111: begin
                register_selector[4] = 1;
                register_selector[5] = 1;
                register_selector[6] = 1;
                register_selector[7] = 1;
            end
        endcase
    end

    
    // initiate and update the register
    n_bit_register #(8) R1(clk, register_selector[0], I, fun_sel, outputs[0]);
    n_bit_register #(8) R2(clk, register_selector[1], I, fun_sel, outputs[1]);
    n_bit_register #(8) R3(clk, register_selector[2], I, fun_sel, outputs[2]);
    n_bit_register #(8) R4(clk, register_selector[3], I, fun_sel, outputs[3]);
    n_bit_register #(8) T1(clk, register_selector[4], I, fun_sel, outputs[4]);
    n_bit_register #(8) T2(clk, register_selector[5], I, fun_sel, outputs[5]);
    n_bit_register #(8) T3(clk, register_selector[6], I, fun_sel, outputs[6]);
    n_bit_register #(8) T4(clk, register_selector[7], I, fun_sel, outputs[7]);
        
        
    /// assign the output variables for the given selection 
    always @(posedge clk) begin
        case(O1_sel)
            3'b000: begin
                OutA = outputs[4];
            end
            3'b001: begin 
                OutA = outputs[5];
            end
            3'b010: begin 
                OutA = outputs[6];
            end
            3'b011: begin 
                OutA = outputs[7];
            end
            3'b100: begin 
                OutA = outputs[0];
            end
            3'b101: begin 
                OutA = outputs[1];
            end
            3'b110: begin 
                OutA = outputs[2];
            end
            3'b110: begin 
                OutA = outputs[3];
            end
            3'b111: begin 
                OutA = outputs[4];
            end
        endcase
    end
    
    always @(posedge clk) begin
        case(O2_sel)
            3'b000: begin
                OutB = outputs[4];
            end
            3'b001: begin 
                OutB = outputs[5];      
            end
            3'b010: begin
                OutB = outputs[6];
            end
            3'b011: begin 
                OutB = outputs[7];
            end
            3'b100: begin 
                OutB = outputs[0];
            end
            3'b101: begin 
                OutB = outputs[1];
            end
            3'b110: begin
                OutB = outputs[2];
            end
            3'b111: begin 
                OutB = outputs[3];
            end
        endcase
    end 
endmodule
