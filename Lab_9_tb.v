`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 02:13:18 PM
// Design Name: 
// Module Name: Lab_9_tb
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


//module Lab_9_tb();
//endmodule

module seq_mult_tb();
    reg clk, reset;
    reg [3:0] A, B;
    wire [7:0] P;
    
    always #1 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        #20;
        A = 6;
        B = 3;
        #10
        reset = 0;
        #20
        A = 4;
        B = 7;
        #20
        A = 12;
        B = 15;
        #20
        A=1;
        B=1;
    end
    
    seq_mult uut(clk, reset, A, B, P);
endmodule

module comb_mult_tb();
    reg [3:0] A, B;
    wire [7:0] P;
    
    comb_mult uut(A,B,P);
    
    initial begin
        A = 6;
        B = 3;
        #10
        #20
        A = 4;
        B = 7;
        #20
        A = 12;
        B = 15;
        #20
        A=1;
        B=1;
    end
    
endmodule