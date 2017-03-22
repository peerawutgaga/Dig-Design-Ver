`timescale 1ns/1ps
module simpleCalc(seg,an,dp,sw,BtnD,BtnU,BtnL,BtnR,clk);
input [7:0] sw;
input BtnD; //mul
input BtnL; //sub
input BtnR; //div
input BtnU; //add
input clk;
output [6:0] seg;
output [3:0] an;
output dp;
wire add_sig,sub_sig,mul_sig,div_sig;
wire add,sub,mul,div;
Debouncer d1(add_sig,clk,BtnU);
Debouncer d2(sub_sig,clk,BtnL);
Debouncer d3(mul_sig,clk,BtnD);
Debouncer d4(div_sig,clk,BtnR);
singlePulser s1(add,add_sig,clk);
singlePulser s2(sub,sub_sig,clk);
singlePulser s3(mul,mul_sig,clk);
singlePulser s4(div,div_sig,clk);
wire [3:0] QU;
reg [7:0] q; 
wire [19:0] bcdout;
bin_to_decimal u1 (

.B(q), 
.bcdout(bcdout)
);

seg7decimal u7 (

.x(bcdout),
.clk(clk),
.clr(btnC),
.a_to_g(seg),
.an(an),
.dp(dp)
);
divider u13(

.clk(clk),
.div(sw[7:4]),
.dvr(sw[3:0]),
.quotient(QU),
.remainder(REM)
);
always @(*)
begin
  if(add)   q = sw[7:4] + sw[3:0];
  else if(sub) q = sw[7:4] - sw[3:0];
  else if(mul) q = sw[7:4] * sw[3:0];
  else if(div) q = QU;
  end
endmodule