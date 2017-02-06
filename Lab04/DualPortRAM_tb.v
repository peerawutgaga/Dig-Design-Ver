`timescale 1ns/1ns
module DualPortRAM_tb();
reg clk,we_0,we_1,oe_0,oe_1;
wire [7:0] data_0;
wire [7:0] data_1;
reg [7:0] address_0;
reg [7:0] address_1;
reg [7:0] d0;
reg [7:0] d1;
DualPortRAM dpr(clk,address_0,data_0, we_0, oe_0, address_1, data_1, we_1, oe_1);
assign data_0 = we_0 ? d0 : 8'bz;
assign data_1 = we_1 ? d1 : 8'bz;

initial
	begin
		$dumpfile("test2.vcd");
		$dumpvars(0,dpr);
		clk = 0;
		we_0 = 0;
		oe_0 = 0;
		we_1 = 0;
		oe_1 = 0;
		address_0 = 8'd0;
		address_1 = 8'd0;
		//test Port 0
		#10 we_0 = 1; d0 = 8'd16;				//write 16 to addr 0
		#20 address_0 = 8'd1; d0 = 8'd17;		//write 17 to addr 1
		#20 address_0 = 8'd2; d0 = 8'd18;		//write 18 to addr 2
		#20 we_0 = 0; address_0 = 8'd0;	oe_0 = 1;	//stop writing read addr0
		#20 address_0 = 8'd1;					//read addr 1
		#20 address_0 = 8'd2;					//read addr 2
		#20 oe_0 = 0; address_0 = 8'd0;			//stop reading
		#20 address_0 = 8'd1;					//read addr 1
		#20 address_0 = 8'd2;					//read addr 2
		//test port 1
		#20 we_1  = 1; d1 = 8'd1;				//write 1 to addr 0
		#20 address_1  = 8'd1; d1 = 8'd2;			//write 2 to addr 1
		#20 address_1  = 8'd2; d1 = 8'd3;			//write 3 to addr 2
		#20 address_1  = 8'd3; d1 = 8'd4;			//write 3 to addr 2
		#20 we_1 = 0; address_1 = 8'd0;	oe_1 = 1;	//stop writing read addr0
		#20 address_1 = 8'd1;					//read addr 1
		#20 address_1 = 8'd2;					//read addr 2
		#20 oe_1 = 0; address_1 = 8'd0;			//stop reading
		#20 address_1 = 8'd1;					//read addr 1
		#20 address_1 = 8'd2;					//read addr 2
		//read both port
		#20 oe_0 = 1; oe_1 = 1; address_0 = 8'd0; address_1 = 8'd0;
		#20 address_0 = 8'd1; address_1 = 8'd1;
		#20 address_0 = 8'd2; address_1 = 8'd2;
		//write both port
		#20 oe_0 = 0; oe_1 = 0; we_0 = 1; we_1 = 1; address_0 = 8'd0; address_1 = 8'd2; d0 = 8'd32; d1 = 8'd16;
		#20 address_0 = 8'd1; address_1 = 8'd3; d0 = 8'd33; d1 = 8'd17;
		#20 oe_0 = 1; oe_1 = 1; we_0 = 0; we_1 = 0; address_0 = 8'd0; address_1 = 8'd2;
		#20 address_0 = 8'd1; address_1 = 8'd3;
		//read both again
		#20 oe_0 = 0; oe_1 = 0; we_0 = 0; we_1 = 0; address_0 = 8'd0; address_1 = 8'd2;
		#20 address_0 = 8'd1; address_1 = 8'd3;
		#100 $finish;
	end
always
	begin
		#10 clk = ~clk;
	end
endmodule