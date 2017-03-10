`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2017 07:32:15 PM
// Design Name: 
// Module Name: ClickCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ClickCounter(seg,an,dp,clock,BtnC,BtnL);
output [6:0] seg;
output [3:0] an;
output dp;
input BtnC;
input BtnL;
input clock;
reg [15:0] B;
wire[19:0] bcdout;
bin_to_decimal u1 ( 
   .B(B), 
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
wire sig;
reg q;
Debouncer d(sig,clock,BtnL);
singlePulser s(q,sig,clock);
always @(BtnC or q)
begin
  if(BtnC) B = 15'd0;
  else if(q) B = B+15'd1;
end
endmodule
