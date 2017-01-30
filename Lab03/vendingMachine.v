`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2017 07:25:05 PM
// Design Name: 
// Module Name: vendingMachine
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


module vendingMachine(tea_out,soda_out,juice_out,c10,c5,c2,c1,
tea,soda,juice,b10,b5,b2,b1,clock,reset);
output tea_out,soda_out,juice_out,c10,c5,c2,c1;
input tea,soda,juice,b10,b5,b2,b1,clock,reset;
wire ptea,psoda,pjuice,p10,p5,p2,p1;
singlePulser sp_tea(ptea,tea,clock);
singlePulser sp_soda(psoda,soda,clock);
singlePulser sp_juice(pjuice,juice,clock);
singlePulser sp_b10(p10,b10,clock);
singlePulser sp_b5(p5,b5,clock);
singlePulser sp_b2(p2,b2,clock);
singlePulser sp_b1(p1,b1,clock);
endmodule
