`timescale 1ns / 1ps
module MAC(
input clk,
input [7:0] ain,
input [7:0] bin,
output reg [7:0] out,//matrix outputs
output [7:0] apass, bpass
    );
    
reg [7:0] temp;
reg [7:0] aprev;
reg [7:0] bprev;

initial begin
temp <= 0;
out <= 0;
aprev <= 0;
bprev <= 0;
end

assign apass = aprev;
assign bpass = bprev;

wire [7:0] addresult, mulresult;
addtest a0(.clk(clk),.op1(out),.op2(temp),.res(out));
multest m0(.clk(clk),.op1(ain),.op2(bin),.res(temp));

always @(posedge clk) begin
//temp = ain * bin;taken care of by multest
//out = out + temp;addtest
aprev = ain;
bprev = bin;
end

endmodule
