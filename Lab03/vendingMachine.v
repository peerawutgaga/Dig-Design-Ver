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
output tea_out,soda_out,juice_out;
output [1:0] c10,c5,c2,c1;
input tea,soda,juice,b10,b5,b2,b1,clock,reset;
reg [5:0] balance = 6'b00000;
wire ptea,psoda,pjuice,p10,p5,p2,p1;
reg tea_out,soda_out,juice_out;
reg [1:0] c10,c5,c2,c1;
reg [3:0] state = 4'b0000;
singlePulser sp_tea(ptea,tea,clock);
singlePulser sp_soda(psoda,soda,clock);
singlePulser sp_juice(pjuice,juice,clock);
singlePulser sp_b10(p10,b10,clock);
singlePulser sp_b5(p5,b5,clock);
singlePulser sp_b2(p2,b2,clock);
singlePulser sp_b1(p1,b1,clock);
always @(reset)
	begin
		if(reset)
			begin
				state <= 4'b000;
				balance <= 6'b000000;
					tea_out <= 6'b000000;
					soda_out <= 6'b000000;
					juice_out <= 6'b000000;
					c10 <= 2'b00;
					c5 <= 2'b00;
					c2 <= 2'b00;
					c1 <= 2'b00;
			end
	end
always @(posedge clock)
	begin
		if(p1 && balance <= 25) state = 4'b0001;
		else if(p2 && balance <= 25) state = 4'b0010;
		else if(p5 && balance <= 25) state = 4'b0011;
		else if(p10 && balance <= 25) state = 4'b0100;
		else if(psoda && balance>= 20) state = 4'b0101;
		else if(pjuice && balance >= 15) state = 4'b0110;
		else if(ptea && balance >= 25) state = 4'b0111;
		else if(state == 4'b1000)
			begin
				if(balance>=10) state = 4'b1001;
				else if(balance>=5) state = 4'b1010;
				else if(balance>=2) state = 4'b1011;
				else if(balance>=1) state = 4'b1100;
				else state = 0;
			end
		else if (state > 8 && state <=12) state = 8;
		else state = 0;
	end
always @(state)
	begin
		case (state)
			4'b0001 :
				begin
					balance = balance + 6'b000001;
				end
			4'b0010 :
				begin
					balance = balance + 6'b000010;
				end
			4'b0011 :
				begin
					balance = balance + 6'b000101;
				end
			4'b0100 :
				begin
					balance = balance + 6'b001010;
				end
			4'b0101 :
				begin
					balance = balance - 6'b010100;
					soda_out = 1;
					state =  4'b1000;
				end
			4'b0110 :
				begin
					balance = balance - 6'b001111;
					juice_out = 1;
					state =  4'b1000;
				end
			4'b0111 :
				begin
					balance = balance - 6'b011001;
					tea_out = 1;
					state =  4'b1000;
				end
			4'b1001 :
				begin
					balance = balance - 6'b001010;
					c10 = c10+ 2'b01;
				end
			4'b1010 :
				begin
					balance = balance - 6'b000101;
					c5 = c5+ 2'b01;
				end
			4'b1011 :
				begin
					balance = balance - 6'b000010;
					c2 = c2+ 2'b01;
				end
			4'b1100 :
				begin
					balance = balance - 6'b000001;
					c1 = c1+ 2'b01;
				end
			endcase
	end
endmodule
