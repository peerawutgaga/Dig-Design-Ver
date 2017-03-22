`timescale 1ns/1ps
module Stack_tb();
reg clk;
reg [15:0] sw;
reg BtnL;//push
reg BtnR;//pop
wire [6:0] seg;
wire an;
wire dp;
integer i;
Stack s(seg,an,dp,clk,BtnL,BtnR,sw);
initial
begin
  $dumpfile("stack.vcd");
  $dumpvars(1,s);
  #0 BtnL = 0; BtnR = 0; sw = 15'd11; clk = 0;
  #10 BtnL = 1;//push
  for(i=11;i<290;i=i+1)
  begin
    #60 BtnL = 0; sw = i; //set new value
    #20 BtnL = 1;
  end
  #60 BtnL = 0;
  #20 BtnR = 1;//pop
  #60 BtnR = 0;
  #20 BtnR = 1;//pop
  #60 BtnR = 0;
  #20 BtnR = 1;//pop
  #60 BtnR = 0;
  #100 $finish;
end
always #10 clk = ~clk;
endmodule