`timescale 1ns/1ns
module testSinglePulser();
reg clock,in;
wire out;
singlePulser s(out, clock, in);
initial
begin
	$dumpfile("testCounter.vcd");
    $dumpvars(0,s);
    clock = 0;
    in  = 0;
    fork
    #15 in = 1;
    #45 in = 0;
    #65 in = 1;
    #67 in = 0;
    #85 in = 1;
    #150 in = 0;
    #175 in = 1;
    #195 in = 0;
    #500 $finish;
    join
end
always
begin
	#10 clock = ~clock;
end
endmodule
       