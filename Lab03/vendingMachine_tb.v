`timescale 1ns/1ns
module testVendingMachine();
reg tea,soda,juice,b10,b5,b2,b1,clock,reset;
wire tea_out,soda_out,juice_out;
wire [1:0] c10,c5,c2,c1;
vendingMachine vm(tea_out,soda_out,juice_out,c10,c5,c2,c1,
tea,soda,juice,b10,b5,b2,b1,clock,reset);
initial
begin
	$dumpfile("test.vcd");
    $dumpvars(0,vm);
	clock = 0;
	reset = 1;
	fork
		#5 reset = 0;
		#20 b10 = 1;
		#40 b10 = 0;
		#60 b10 = 1;
		#80 b10 = 0;
		#100 b10 = 1;
		#120 b10 = 0;
		#140 b10 = 1;
		#160 b10 = 0;
		#180 tea = 1;
		#200 tea = 0;
		#220 reset = 1;
		#230 reset = 0;
		#250 b10 = 1;
		#270 b10 = 0;
		#285 tea = 1;
		#300 tea = 0;
		#310 b10 = 1;
		#330 b10 = 0;
		#350 b2 = 1;
		#370 b2 = 0;
		#390 b2 = 1;
		#410 b2 = 0;
		#450 b10 = 1;
		#470 b10 = 0;
		#490 soda = 1;
		#550 soda = 0;
		#1000 $finish;
	join
end
always
	begin
		#10 clock = ~clock;
	end
endmodule
