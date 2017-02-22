//`timescale 1ns/1ns
module cpuDriver();

reg CLK;
reg reset;
reg start;
initial begin
$dumpfile("cpu.vcd");
$dumpvars(0,cpu1);
reset=1;
start=0;
#20;
reset=0;
start=1;
#10;
start=0;
#1000 $finish;
end

   parameter PERIOD = 10;

   always begin
      CLK = 1'b0;
      #(PERIOD/2) CLK = 1'b1;
      #(PERIOD/2);
   end
cpu cpu1(.clock(CLK), .reset(reset), .start(start));
endmodule