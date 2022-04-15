`timescale 1ns / 1ps
module multest(
input clk,
input [7:0] op1,op2,
output reg[7:0] res = 0
    );
//multiply works!
reg [4:0] F1,F2; 
reg [2:0] E1,E2;

reg [2:0] ebuf;
reg [9:0] fbuf;
wire sbuf = 0;

initial begin
F1 <= 0;
F2 <= 0;
end

always @(*)begin
F1 = {1'b1,op1[3:0]};
 F2 = {1'b1,op2[3:0]};
    E1 = op1[6:4] - 3;
    E2 = op2[6:4] - 3;
   
    

 ebuf = E1 + E2 + 3;
 fbuf = F1 * F2;
 
 if(fbuf == 0)begin
 res = {(op1[7]^op2[7]),ebuf,4'b0000};
 end 
 
 else begin
 if(fbuf[9])begin
 fbuf = fbuf >> 1;
 ebuf = ebuf + 1;
 end



 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 if(fbuf[9]==0 && fbuf[8]==0)begin
 fbuf = fbuf << 1;
 ebuf = ebuf - 1;
 end
 
 
 else begin
  res = {(op1[7]^op2[7]),ebuf,fbuf[7:4]};
 end

end
end

  
endmodule
