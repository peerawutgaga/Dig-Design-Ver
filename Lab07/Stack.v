`timescale 1ns/1ps
module Stack (seg,an,dp,clk,BtnL,BtnR,sw);
    input clk;
    input BtnL; //push
    input BtnR; //pop
    input [15:0] sw;
    output [6:0] seg;
    output an;
    output dp;
reg [15:0]q;
reg [7:0] mem [0:255];
reg [7:0] top;
wire pop;
wire push;
wire push_sig;
wire pop_sig;
wire [19:0] bcdout;
bin_to_decimal u1 (
   
   .B(q), 
   .bcdout(bcdout)
   );  
seg7decimal u7 (
   .x(bcdout),
   
   .clk(clk),
   .clr(BtnC),
   .a_to_g(seg),
   .an(an),
   .dp(dp)
   );
Debouncer d1(push_sig,clk,BtnL);
Debouncer d2(pop_sig,clk,BtnR);
singlePulser s1(push,push_sig,clk);
singlePulser s2(pop,pop_sig,clk);
initial
begin
  top = 8'b00000000;
end
always@(push or pop)
begin
    if(push && top < 8'b111111111)
    begin
        mem[top] = sw;
        top = top + 8'b00000001;
    end
    else if(pop && top>8'b00000000)
    begin
        q = mem[top-1];
        top = top - 8'b00000001;
    end
end
endmodule
