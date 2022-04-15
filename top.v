`timescale 1ns / 1ps
module top(
input clk,
input [7:0] a00, a01, a02, a10, a11, a12, a20, a21, a22,
input [7:0] b00, b01, b02, b10, b11, b12, b20, b21, b22,
output reg [7:0] c1,c2,c3,c4,c5,c6,c7,c8//matrix to output
    );
    
//  c1  c2  c3
//  c4  c5  c6
//  c7  c8  c9    

wire [7:0] c12,c13,c22,c23,c33,c42,c43,c52,c53,c63,c72,c82;

MAC m1(.clk(clk), .ain(a00), .bin(b00), .out(c1), .aout(c12), .bout(bc13));

endmodule
