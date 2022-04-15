`timescale 1ns / 1ps
module add(
input clk,
input [7:0] op1,op2,
output reg[7:0] res = 0
    );
reg [2:0] state,next_state;  
reg done = 0;//flag to determine if math finished
reg [12:0] F1,F2; 
reg [2:0] E1,E2;
reg S1,S2;
reg [12:0] fracsum;
reg [2:0] ebuf;
reg sbuf = 0;
reg ovf;

initial begin
state = 0;
next_state = 0;
F1 <= 0;
F2 <= 0;
end
always @(posedge clk)begin
    case(state)
    0:begin//getting sign,exp,frac from each op
    //state 0 works as it should
    F1[12:7] = {op1[7],1'b1,op1[3:0]};
    F2[12:7] = {op2[7],1'b1,op2[3:0]};
    E1 <= op1[6:4];
    E2 <= op2[6:4];
    S1 <= op1[7];
    S2 <= op2[7];
    next_state <= done? 0:1;
    end
    1:begin//checking if exps are equal or not and normalizing
    //this state is fine
    if(E1 == E2)begin
    ebuf <= E1;
    sbuf <= S1;
    next_state <= 2;
    end
    else if (E1 < E2)begin
     sbuf <= S2;
     F1[11:0] <= F1[11:0] >> (E2 - E1);
     ebuf <= E1 + (E2 - E1);
     end
    else if(E1 > E2)begin
    sbuf <= S1;
     F2[11:0] <= F2[11:0] >> (E1 - E2);
     ebuf <= E2 + (E1 - E2);
    end
       next_state = 2;
    end
    2:begin//adding fractions
    //this state is fine
    fracsum = F1 + F2;
    next_state = 4;//fractions do not sum to 0
   end
  
    4:begin//checking for overflow
    //this state is fine
    ovf = (~fracsum[12]&&F1[12]&&F2[12])||(fracsum[12]&&(~F1[12])&&(~F2[12]));
    if(ovf)begin
    fracsum <= fracsum >> 1;
    ebuf <= ebuf + 1;
    end
    next_state <= 5;
    end
    
    5: begin//check if fracsum normalized
    if(fracsum[11] != 1 && (fracsum != 0)) begin//not normalized
    fracsum[11:0] <= fracsum[11:0] << 1;
    ebuf <= ebuf - 1;
    next_state <= 5;
    end else begin
    res <= {sbuf, ebuf, fracsum[10:7]};
    done <= 1;
    next_state <= 0;
    end
    end
    
    
endcase    
end  

always @(negedge clk) begin
    state <= next_state;
    end
endmodule