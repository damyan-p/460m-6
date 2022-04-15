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

always @(posedge clk) begin
temp = ain * bin;
out = out + temp;
aprev = ain;
bprev = bin;
end

endmodule
