`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2023 05:02:33 PM
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

module SR_latch_sim();
    reg S,R;
    wire Q, Qn;
    
    SR_latch uut(S,R,Q,Qn);
    
    initial begin
        S = 1; R = 0; #125;
        S = 0; R = 0; #125;
        S = 1; R = 0; #125;
        S = 0; R = 0; #125;
        S = 0; R = 1; #125;
        S = 1; R = 1; #125;
        S = 0; R = 1; #125;
        S = 0; R = 0; #125;
    end
endmodule

module SR_latch_EN_sim();
    reg S,R,EN;
    wire Q, Qn;
    
    SR_latch_EN uut(S,R,EN,Q,Qn);
    
    initial begin
        S = 0; R = 1; EN = 1; #100;
        S = 0; R = 0; EN = 1; #100;
        S = 1; R = 0; EN = 1; #100;
        S = 0; R = 0; EN = 1; #100;
        S = 1; R = 1; EN = 1; #100;
        S = 0; R = 1; EN = 0; #100;
        S = 0; R = 0; EN = 0; #100;
        S = 1; R = 0; EN = 0; #100;
        S = 0; R = 0; EN = 0; #100;
        S = 1; R = 1; EN = 0; #100;
    end
    
endmodule

module D_latch_sim();
    reg D, EN;
    wire Q, Qn;
    
    D_latch uut(D, EN, Q, Qn);
    
    initial begin
    D = 0; EN = 1; #250;
    D = 1; EN = 1; #250;
    D = 0; EN = 0; #250;
    D = 1; EN = 0; #250;
    end
endmodule

module D_flip_flop_sim();
    reg D, clk;
    wire Q, Qn;
    
    D_flip_flop uut(D, clk, Q, Qn);
    
    initial begin
        clk = 0; D = 1; #250;
        D = 0; #250;
        D = 1; #250;
        D = 0; #250;
    end
    
    always begin
        clk <= ~clk; #20;
    end
endmodule

module SR_flip_flop_sim();
    reg S, R, clk;
    wire Q, Qn;
    
    SR_flip_flop uut(S, R, clk, Q, Qn);

    initial begin
            clk = 0;
            S = 0; R = 1; #100;
            S = 1; R = 0; #100;
            S = 1; R = 0; #100;
            S = 0; R = 1; #100;
            S = 0; R = 0; #100;
            S = 1; R = 0; #100;
            S = 0; R = 1; #100;
            S = 0; R = 0; #100;
            S = 1; R = 0; #100;
            $stop;
    end
    always begin
        clk = ~clk; #50;
    end   
    
endmodule

module JK_flip_flop_sim();
    reg J;
    reg K;
    reg clk = 1;
    wire Q;
    wire Qn;
    
    JK_flip_flop uut(J,K,clk,Q,Qn);
    
    initial begin
            J = 0; K = 1; #100;
            J = 1; K = 0; #100;
            J = 1; K = 1; #100;
            J = 0; K = 1; #100;
            J = 1; K = 1; #100;
            J = 1; K = 0; #100;
            J = 0; K = 1; #100;
            J = 1; K = 1; #100;
            J = 1; K = 0; #100;
            $stop;
    end
    always begin
        clk = ~clk; #50;
    end
endmodule

module asynch_counter_sim();
    reg clk = 1, set;
    wire[3:0] out;
    
    asynch_counter uu(clk, set, out);
    
    initial begin
        set = 1; #50;
        set = 0;
    end
    
    always begin
        clk = ~clk; #25;
    end
endmodule

module synch_counter_sim();
    reg clk = 1, set;
    wire[3:0] out;
    
    synch_counter uut(clk, set, out);
    
    initial begin
        set = 1; #50
        set = 0;
    end
    
    always begin
        clk = ~clk; #25;
    end
endmodule

module pulse_generator_sim_1_2();
    reg[15:0] I;
    reg load, clk;
    wire O;
    
    pulse_generator uut(I, clk, load, O);
    
    initial begin
    clk = 0;
        forever begin
            clk = ~clk; #10;
        end
    end
    
    initial begin
        // 1/2 frequency
        I = 16'b0101010101010101; load = 1'b1; # 10;
        load = 1'b0;       
    end                       
  
endmodule

module pulse_generator_sim_1_4();
    reg[15:0] I;
    reg load, clk;
    wire O;
    
    pulse_generator uut(I, clk, load, O);
    
    initial begin
    clk = 0;
        forever begin
            clk = ~clk; #10;
        end
    end
    
    initial begin
        // 1/4 frequency
        I = 16'b0000111100001111; load = 1'b1; #10;
        load = 1'b0; #10;       
    end                       
  
endmodule

module pulse_generator_sim_1_8();
    reg[15:0] I;
    reg load, clk;
    wire O;
    
    pulse_generator uut(I, clk, load, O);
    
    initial begin
    clk = 0;
        forever begin
            clk = ~clk; #10;
        end
    end
    
    initial begin
        // 1/8 frequency
        I = 16'b0000000011111111; load = 1'b1; #10;
        load = 1'b0; #20;        
    end                       
  
endmodule

module pulse_generator_sim_1_7_pulse();
    reg[15:0] I;
    reg load, clk;
    wire O;
    
    pulse_generator uut(I, clk, load, O);
    
    initial begin
    clk = 0;
        forever begin
            clk = ~clk; #10;
        end
    end
    
    initial begin
        // 1/7 pulse gap duration rate
        I = 16'b0000000100000001; // set input to alternating pattern
        load = 1'b1; #10;
        load = 1'b0; 
    end                      
  
endmodule

module pulse_generator_sim_3_13_pulse();
    reg[15:0] I;
    reg load, clk;
    wire O;
    
    pulse_generator uut(I, clk, load, O);
    
    initial begin
    clk = 0;
        forever begin
            clk = ~clk; #10;
        end
    end
    
    initial begin
        // 3/13 pulse-gap duration rate
        I = 16'b1110000000000000; load = 1'b1; #10;
        load = 1'b0;          
    end                       
  
endmodule

module pulse_generator_sim_11_5_pulse();
    reg[15:0] I;
    reg load, clk;
    wire O;
    
    pulse_generator uut(I, clk, load, O);
    
    initial begin
    clk = 0;
        forever begin
            clk = ~clk; #10;
        end
    end
    
    initial begin
         // 11/5 pulse-gap duration rate
        I = 16'b1111111111100000; load = 1'b1; #10;
        load = 1'b0;          
    end                       
  
endmodule