`timescale 1ns / 1ps
module MAC(
input clk,
input [7:0] ain,
input [7:0] bin,
output reg [8:0] out,//matrix outputs
output reg [7:0] aout, bout
    );
 
wire [7:0] addresult, mulresult;
add a0(.clk(clk),.op1(ain),.op2(bin),.res(addresult));
mul m0(.clk(clk),.op1(ain),.op2(addresut),.res(out));
    
always @(posedge clk)begin
out = out + (ain*bin);
aout = ain;
bout = bin;
end
endmodule
