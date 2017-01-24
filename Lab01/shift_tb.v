`timescale 1ns/1ns
module testShift();
	reg clock,d;
	wire [1:0] qa;
	wire [1:0] qb;
	shiftA a(qa,clock,d);
	shiftB b(qb,clock,d);
always #10 clock = ~clock;
initial
	begin
		//$dumpfile("testShift.dump");
		$dumpfile("test2.vcd");
		$dumpvars(2,a,b);
		#0 d=0; clock=0;
		#10 d=1;
		#20 d=0;
		#20 d=1;
		#20 d=1;
		#20 d=0;
		#20 d=0;
		#20 $finish;
	end
endmodule
	