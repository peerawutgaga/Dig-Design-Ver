`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2017 01:37:21 PM
// Design Name: 
// Module Name: synROM_tb
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
module synROM_tb();
reg clk;
reg [9:0] addr;
wire [4:0] d;
integer i;
synROM r(d,addr,clk);
initial
    begin
        $dumpfile("test.vcd");
        $dumpvars(0,r);
        clk = 0;
        #10 addr = 10'd1023;
        for(i=1023;i>0;i = i-1)
        begin
            #20 addr = addr - 10'd1;
        end
        #50 $finish;
     end
always
    begin
        #10 clk = ~clk;
    end
endmodule
