`timescale 1ns / 1ps
module top(
input clk,
input [7:0] a00, a01, a02, a10, a11, a12, a20, a21, a22,
input [7:0] b00, b01, b02, b10, b11, b12, b20, b21, b22,
output reg [7:0] c1,c2,c3,c4,c5,c6,c7,c8,c9//matrix to output
    );
    
    reg [2:0] state;
    reg [2:0] next_state; 
    
    reg [7:0] Rin [2:0];
    reg [7:0] Cin [2:0];
    wire [7:0] c12,c23,c45,c56,c78,c89,c14,c25,c36,c47,c58,c69;
    wire [7:0] c3x,c6x,c9x,cx7,cx8,cx9;
    
    initial begin
    Cin[2] <= 0;
    Cin[1] <= 0;
    Cin[0] <= 0;
    Rin[2] <= 0;
    Rin[1] <= 0;
    Rin[0] <= 0;
    state <= 0;
    next_state <= 0;
    c1 <= 0;
    c2 <= 0;
    c3 <= 0;
    c4 <= 0;
    c5 <= 0;
    c6 <= 0;
    c7 <= 0;
    c8 <= 0;
    c9 <= 0;
    end
    
//          [0] [1] [2]  Cin    
//  Rin
// [2]->    c1  c2  c3
// [1]->    c4  c5  c6
// [0]->    c7  c8  c9   

    MAC m1(.ain(Rin[0]), .bin(Cin[0]), .out(c1),.apass(c12),.bpass(c14));
    MAC m2(.ain(c12), .bin(Cin[1]), .out(c2),.apass(c23),.bpass(c25));
    MAC m3(.ain(c23), .bin(Cin[2]), .out(c3),.apass(c3x),.bpass(c36));
    MAC m4(.ain(Rin[1]), .bin(c14), .out(c4),.apass(c45),.bpass(c46));
    MAC m5(.ain(c45), .bin(c25), .out(c5),.apass(c56),.bpass(c58));
    MAC m6(.ain(c56), .bin(c36), .out(c6),.apass(c6x),.bpass(c69));
    MAC m7(.ain(Rin[2]), .bin(c47), .out(c7),.apass(cx7),.bpass(c78));
    MAC m8(.ain(c78), .bin(c58), .out(c8),.apass(cx8),.bpass(c89));
    MAC m9(.ain(c89), .bin(c69), .out(c9),.apass(cx9),.bpass(cx9));

    always @(state) begin
    case(state)
    1: begin
    Rin[0] = a01;
    Rin[1] = a10;
    Rin[2] = 0;
    Cin[0] = b10;
    Cin[1] = b01;
    Cin[2] = 0;
    next_state <= 2;
    end
    0: begin
    Rin[0] = a00;
    Rin[1] = 0;
    Rin[2] = 0;
    Cin[0] = b00;
    Cin[1] = 0;
    Cin[2] = 0;
    next_state <= 1;
    end
    2: begin
    Rin[0] = a02;
    Rin[1] = a11;
    Rin[2] = a20;
    Cin[0] = b20;
    Cin[1] = b11;
    Cin[2] = b02;
    next_state <= 3;
    end
    3: begin
    Rin[0] = 0;
    Rin[1] = a12;
    Rin[2] = a21;
    Cin[0] = 0;
    Cin[1] = b21;
    Cin[2] = b12;
    next_state <= 4;
    end
    4: begin
    Rin[0] = 0;
    Rin[1] = 0;
    Rin[2] = a22;
    Cin[0] = 0;
    Cin[1] = 0;
    Cin[2] = b22;
    next_state <= 5;
    end
    5: begin
    Rin[0] = 0;
    Rin[1] = 0;
    Rin[2] = 0;
    Cin[0] = 0;
    Cin[1] = 0;
    Cin[2] = 0;
    next_state <= 6;
    end
    6:begin
    Rin[0] = 0;
    Rin[1] = 0;
    Rin[2] = 0;
    Cin[0] = 0;
    Cin[1] = 0;
    Cin[2] = 0;
    next_state <= 6;
    end
    endcase
    end

    always @(posedge clk) begin
    state <= next_state;
    end
endmodule
