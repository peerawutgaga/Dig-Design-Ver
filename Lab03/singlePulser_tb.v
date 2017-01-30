`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2017 06:48:04 PM
// Design Name: 
// Module Name: singlePulser_tb
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
module singlePulser_tb();
reg clock,in;
wire out;
singlePulser s(out,in,clock);
initial
begin
    $dumpfile("testCounter.vcd");
    $dumpvars(0,s);
    clock=0;
    in=0;
    fork
        #25 in=1;
        #80 in=0;
        #115 in=1;
        #135 in=0;
        #200 $finish;
    join
end
always
begin
    #10 clock = ~clock;
end
endmodule
