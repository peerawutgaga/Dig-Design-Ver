`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2017 07:48:56 PM
// Design Name: 
// Module Name: Debouncer
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


module Debouncer(
output out,
input clock,
input in
    );
reg ;
reg out;
always @(posedge clock)
begin
if(in)
    begin
        i=i+1;
        if(i==24'd5000000)
        begin
            out = 1;
            hold = 1;
        end
        else
        begin
            out = 0;
        end
    end
    else
    begin
        out = 0;
        hold = 0;
        i = 0;
    end
end
endmodule
