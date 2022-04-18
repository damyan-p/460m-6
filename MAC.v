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
//multiply variables
reg [4:0] mF1,mF2; 
reg [2:0] mE1,mE2;
reg [2:0] mebuf;
reg [9:0] mfbuf;
wire msbuf = 0;
//add variables
reg [12:0] aF1,aF2; 
reg [2:0] aE1,aE2;
reg aS1,aS2;
reg [13:0] afracsum;
reg [2:0] aebuf;
reg asbuf = 0;
reg aovf;
initial begin
temp <= 0;
out <= 0;
aprev <= 0;
bprev <= 0;
mF1 <= 0;
mF2 <= 0;
aF1 <= 0;
aF2 <= 0;
end
assign apass = aprev;
assign bpass = bprev;
//addtest a0(.clk(clk),.ain(out),.op2(temp),.res(out));
//multest m0(.clk(clk),.ain(ain),.op2(bin),.res(temp));

//temp = ain * bin;taken care of by multest
//out = out + temp;addtest
always @(posedge clk) begin
aprev = ain;
bprev = bin;
//------------------multiply--------------------//
mF1 = {1'b1,ain[3:0]};
mF2 = {1'b1,bin[3:0]};
mE1 = ain[6:4] - 3;
mE2 = bin[6:4] - 3;
mebuf = mE1 + mE2 + 3;
mfbuf = mF1 * mF2;
if(ain == 0 || bin == 0) begin
temp = 0;
end else begin
  if(mfbuf == 0)begin
 temp = {(ain[7]^bin[7]),mebuf,4'b0000};
 end 
 else begin
 if(mfbuf[9])begin
 mfbuf = mfbuf >> 1;
 mebuf = mebuf + 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 if(mfbuf[9]==0 && mfbuf[8]==0)begin
 mfbuf = mfbuf << 1;
 mebuf = mebuf - 1;
 end
 else begin
  temp = {(ain[7]^bin[7]),mebuf,mfbuf[7:4]};
 end
end
end
//---------------adding-----------------------------//
//op1 out
//op2 temp
    aF1[12:7] = {out[7],1'b1,out[3:0]};
    aF1[13] = 0;
    aF2[12:7] = {temp[7],1'b1,temp[3:0]};
    aF2[13] = 0;
    aE1 = out[6:4];
    aE2 = temp[6:4];
    aS1 = out[7];
    aS2 = temp[7];
    if(out == 0) begin
    out = temp;
    end else if(temp == 0) begin
    out = out;
    end else begin
    if(aE1 == aE2)begin
    aebuf = aE1;
    asbuf = aS1;
    end
    else if (aE1 < aE2)begin
     asbuf = aS2;
     aF1[11:0] = aF1[11:0] >> (aE2 - aE1);
     aebuf = aE1 + (aE2 - aE1);
     end
    else if(aE1 > aE2)begin
    asbuf = aS1;
     aF2[11:0] = aF2[11:0] >> (aE1 - aE2);
     aebuf = aE2 + (aE1 - aE2);
    end
    afracsum = aF1 + aF2;
    aovf = (~afracsum[12]&&aF1[12]&&aF2[12])||(afracsum[12]&&(~aF1[12])&&(~aF2[12]));
    if(aovf)begin
    afracsum = afracsum >> 1;
    aebuf = aebuf + 1;
    end
    if(afracsum[13]) begin  //  doubling 'round', negative numbers ex. -1 + -1
    afracsum = afracsum >> 1;
    aebuf = aebuf + 1;
    end
    if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
        if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
         if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
           if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
           if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
           if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
    if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
      if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
         if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
         if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
        if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
     if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
     if(afracsum[11] != 1 && (afracsum != 0)) begin//not normalized
    afracsum[11:0] = afracsum[11:0] << 1;
    aebuf = aebuf - 1;
    end //else begin
    out <= {asbuf, aebuf, afracsum[10:7]};

end
end


endmodule
