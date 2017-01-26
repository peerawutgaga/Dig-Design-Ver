`timescale 1ns/1ns
module testClockDivider();
reg clock;
wire dclock;
clockDivider d(dclock,clock);
initial
begin
       $dumpfile("testCounter2.vcd");
       $dumpvars(1,d);
       clock=0;
       fork
       #5000 $finish;
       join
end
always
begin
       #10 clock=!clock;
end
endmodule