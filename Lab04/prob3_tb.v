`timescale 1 ns/10 ps

module DualPortRAM_tb();

   parameter DATA_WIDTH = 8;
   parameter ADDR_WIDTH = 4;
   
   reg clk;
   reg we0, oe0;
   
   reg [ADDR_WIDTH-1:0]  addr0;
   reg [DATA_WIDTH-1:0]  wr_data0;
   wire [DATA_WIDTH-1:0]  ram_data0;
   
   wire [ADDR_WIDTH-1:0]  addr1;
   wire we1, oe1;
   wire [DATA_WIDTH-1:0] ram_data1;

   reg 			 start = 0;
   wire 		 finish;
   
   integer               seed = 100;
   
   integer 		  i;
     
   DualPortRAM #(
		 .data_0_WIDTH(DATA_WIDTH),
		 .ADDR_WIDTH(ADDR_WIDTH)
		 )  ram1( clk, 
			  addr0, ram_data0, we0, oe0,
			  addr1, ram_data1, we1, oe1);

   Sorting #( .DATA_WIDTH(DATA_WIDTH),
	      .ADDR_WIDTH(ADDR_WIDTH))  u1(clk, addr1, ram_data1, we1, oe1, start, finish);
   
   assign ram_data0 = we0?wr_data0:8'hZZ;
//   assign ram_data1 = we1?wr_data1:8'hZZ; 
   
   initial 
     begin
	$dumpfile("prob3_tb.vcd");
	$dumpvars;
	oe0 = 0;
	we0 = 0;

	start = 0;

// Let's write something
	for(i=0;i<16;i=i+1) begin
	   #10 addr0 = i;
	   wr_data0 = ($random(seed) % 256)+1;
	   we0 = 1;
	   oe0 = 0;
	end
	#100 we0 = 0;
	#10 start = 1;
	
     end  

always @(posedge clk) begin
   if (finish == 1) begin
     #10 begin 
	oe0 = 1;
	addr0 = 0;
     end
      
	for(i=0;i<16;i = i+1) begin
	  #10   addr0 = i; oe0 = 1; we0 = 0;
	end
      #5 $finish;
      
   end

end
   
always @(posedge clk)
  begin
     if (oe0 == 1) begin
	$display("Reading addr %h: %h", addr0, ram_data0);	   
     end     
  end


   // Clock ticking
   initial
     begin
	clk = 1'b0;
	forever
	  #5 clk=~clk;	
     end
endmodule
