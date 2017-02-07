`timescale 1ns/1ns
module fifo_tb();
reg rst,rd_en,wr_en,clk;
reg [7:0] data_in;
wire [7:0] data_out;
wire full,empty;
integer i;
fifo f(clk,rst,data_in,rd_en,wr_en,data_out,empty,full);
initial
	begin
		$dumpfile("test fifo.vcd");
		$dumpvars(0,f);
		clk = 0;
		rst = 1;
		rd_en = 0;
		wr_en = 1;
		data_in = 8'd0;
		//write data until full
		#5 rst = 0; wr_en = 0;
		for(i=1;i<260;i = i+1)
		begin
			#10 data_in = i;
		end
		#10 wr_en = 1;
		//read data until empty
		#10 rd_en = 1;
		#2600 rd_en = 0;
		//write and then read
		#10 data_in = 8'd1; wr_en = 0;
		#10 data_in = 8'd2;
		#10 wr_en = 1;
		#10 rd_en = 1;
		#10 rd_en = 0;
		#20 $finish;
	end
always
	begin
	#5 clk = ~clk;
	end
endmodule
