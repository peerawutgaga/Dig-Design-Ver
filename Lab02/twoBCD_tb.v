`timescale 1ns/1ns
module testTwoBCD();
reg clock,nreset,enable;
wire [6:0] qa;
wire [6:0] qb;
twoBCD bcd(qa,qb,clock,nreset,enable);
initial
begin
       $dumpfile("testCounter3.vcd");
       $dumpvars(0,bcd);
       clock=0;
       nreset=0;
       enable=0;
       fork
       #15 nreset = 1;
       #45 enable = 1;
       #4105 nreset = 0;
       #4135 enable = 0;
       #4155 enable = 1;
       #4185 nreset = 1;       
       #5000 $finish;
       join
end
always
begin
       #10 clock=!clock;
end
endmodule