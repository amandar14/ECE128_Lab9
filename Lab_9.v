`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 01:44:15 PM
// Design Name: 
// Module Name: Lab_9
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


//module Lab_9();
//endmodule

module seq_mult(clk, reset, a, b, p);
    input [3:0] a, b;
    output reg [7:0] p;
    input clk, reset;
    
    
    parameter s0_idle = 0, s1_multiply = 1, s2_update_result = 2, s3_done = 3;
    
    reg [2:0] PS, NS;
    reg [3:0] operand_bb/*, operand_bb_n*/;
    reg [7:0] partial_product, multiplicand/*, partial_product_n, multiplicand_n*/;
    reg [2:0] shift_count/*, shift_count_n*/;
    //reg ready;
   //reg [7:0] final_product;
    
    always @(posedge clk)
    begin
    if(reset == 1) begin
        PS <= s0_idle;
//        partial_product <= 8'b0;
//        shift_count <= 0;
//        multiplicand <= 0;
//        operand_bb <= 0;
        end
    else begin
        PS <= NS;
//        partial_product <= partial_product_n;
//        shift_count <= shift_count_n;
//        multiplicand <= multiplicand_n;
//        operand_bb <= operand_bb_n;
//        if (ready)
//            p <= partial_product;
    end
    end
    
    always @(posedge clk)
    begin
        case(PS)
            s0_idle: begin
                partial_product <= 8'b0;
                shift_count <= 0;
                multiplicand <= {4'b0, a};
                operand_bb <= b;
                NS <= s1_multiply;
             //   ready <= 0;
            end
            
            s1_multiply: begin
                NS = s2_update_result;
                if (operand_bb[0] == 0 && shift_count<4) begin
                    partial_product <= partial_product;
                    shift_count <= shift_count+3'b001;
                    multiplicand <= multiplicand<<1;
                    operand_bb <= operand_bb>>1;
                end
                else if (operand_bb[0] == 1 && shift_count<4) begin
                    partial_product <= partial_product + multiplicand;
                    shift_count <= shift_count+3'b001;
                    multiplicand <= multiplicand<<1;
                    operand_bb <= operand_bb>>1;
                end
                
                if (shift_count == 4) begin
                    NS = s2_update_result;
                end
                else begin
                    NS = s1_multiply;
                end
            end
            
            s2_update_result: begin
                NS = s3_done;
                p <= partial_product;
            end
            
            s3_done: begin
                NS = s0_idle;
            end
//            default: begin
//                partial_product = 8'b0;
//                shift_count = 0;
//                multiplicand = {4'b0, a};
//                operand_bb = b;
//                NS = s1_multiply;
//                ready = 0;
//            end
         endcase
    end
endmodule

module comb_mult(a,b,p);
    input [3:0] a,b;
    output [7:0] p;
    
    wire [3:0] m0;
    wire [4:0] m1;
    wire [5:0] m2;
    wire [6:0] m3;
    wire [7:0] s1,s2,s3;
    
    assign m0 = {4{a[0]}} & b[3:0];
    assign m1 = {4{a[1]}} & b[3:0];
    assign m2 = {4{a[2]}} & b[3:0];
    assign m3 = {4{a[3]}} & b[3:0];
    
    assign s1 = m0 + (m1 << 1);
    assign s2 = s1 + (m2 << 2);
    assign s3 = s2 + (m3 << 3);
    assign p = s3;
endmodule
