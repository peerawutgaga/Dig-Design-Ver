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


module Counter(q,clock,reset);
output [15:0] q;
input clock,reset;
reg [15:0] q;
always @(posedge clock or reset)
begin
    if(reset) q = 15'd0;
    else q = q + 15'd1;
end
endmodule
