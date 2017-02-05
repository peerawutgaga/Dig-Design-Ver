`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2017 12:52:58 PM
// Design Name: 
// Module Name: synROM
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
module synROM(d,addr,clk);
output [4:0] d;
input [9:0] addr;
input clk;
reg [4:0] rom[0:9];
reg [4:0] d;
initial $readmemb("rom.data",rom);
always @(posedge clk)
    begin
        d = rom[addr];
    end
endmodule