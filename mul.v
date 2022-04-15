`timescale 1ns / 1ps
module mul(
input clk,
input [7:0] op1,op2,
output reg[7:0] res = 0
    );
//multiply works!
reg [4:0] F1,F2; 
reg [2:0] E1,E2;
reg [2:0] state,next_state;
reg done = 0;//flag to determine if math finished 
reg [2:0] ebuf;
reg [9:0] fbuf;
wire sbuf = 0;

initial begin
state = 0;
next_state = 0;
end 

always @(posedge clk)begin
case (state)
 0:begin//getting sign,exp,frac from each op
    F1 = {1'b1,op1[3:0]};
    F2 = {1'b1,op2[3:0]};
    E1 = op1[6:4] - 3;
    E2 = op2[6:4] - 3;
    next_state = done? 0:1;
    end
    
 1:begin//adding exponents and mul ops
 ebuf = E1 + E2 + 3;
 fbuf = F1 * F2;
 if(fbuf == 0)begin
 res = {(op1[7]^op2[7]),ebuf,4'b0000};
 next_state = 0;
 done = 1;
 end
 else next_state = 2;
 end
 2:begin//check for overflow
 if(fbuf[9])begin
 fbuf = fbuf >> 1;
 ebuf = ebuf + 1;
 end
 next_state = 3;
 end
 3:begin//normalizing
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 next_state = 3;
 end
 else begin
  res = {(op1[7]^op2[7]),ebuf,fbuf[7:4]};
  done = 1;
  next_state = 0;
 end
 end
endcase
end

always @(posedge clk) begin
    state <= next_state;
    end    
endmodule
