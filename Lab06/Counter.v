`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2017 07:18:55 PM
// Design Name: 
// Module Name: Counter
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


module Counter(seg,an,dp,clock,BtnC);
output [6:0] seg;
output [3:0] an;
output dp;
input clock,BtnC;
reg [15:0] q;
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
always @(posedge clock or BtnC)
begin
    if(BtnC) q = 15'd0;
    else q = q + 15'd1;
end
endmodule
