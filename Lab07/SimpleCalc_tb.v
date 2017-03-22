`timescale 1ns/1ps
module simpleCalc_tb();
reg BtnD; //mul
reg BtnL; //sub
reg BtnR; //div
reg BtnU; //add
reg [7:0] sw;
reg clk;
wire [6:0] seg;
wire [3:0] an;
wire dp;
simpleCalc c(seg,an,dp,sw,BtnD,BtnU,BtnL,BtnR,clk);
initial
begin
$dumpfile("calc.vcd");
$dumpvars(1,c);
#0 clk = 0; BtnD = 0; BtnU = 0; BtnR = 0; BtnL = 0;
    sw[7:4] = 4'd6; sw[3:0] = 4'd2;
#10 BtnD = 1;
#40 BtnD = 0;
#40 BtnU = 1;
#40 BtnU = 0;
#40 BtnL = 1;
#40 BtnL = 0;
#40 BtnR = 1;
#40 BtnR = 0; sw[7:4] = 4'd10; sw[3:0] = 4'd3;
#40 BtnD = 1;
#40 BtnD = 0;
#40 BtnU = 1;
#40 BtnU = 0;
#40 BtnL = 1;
#40 BtnL = 0;
#40 BtnR = 1;
#100 $finish;
end
always 
#10 clk = ~clk;
endmodule