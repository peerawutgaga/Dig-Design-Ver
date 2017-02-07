`timescale 1 ns/10 ps

module DualPortRAM_tb();

   parameter DATA_WIDTH = 8;
   parameter ADDR_WIDTH = 4;
   
   reg clk;
   reg we0, we1, oe0, oe1;

   reg [ADDR_WIDTH-1:0]  addr0;
   reg [ADDR_WIDTH-1:0]  addr1;

   reg [DATA_WIDTH-1:0]  wr_data0;
   reg [DATA_WIDTH-1:0]  wr_data1;
   
   wire [DATA_WIDTH-1:0]  ram_data0;
   wire [DATA_WIDTH-1:0]  ram_data1;


   integer 		  i;
   
   
   DualPortRAM #(
		 .data_0_WIDTH(DATA_WIDTH),
		 .ADDR_WIDTH(ADDR_WIDTH)
		 )  ram1( clk, 
			  addr0, ram_data0, we0, oe0,
			  addr1, ram_data1, we1, oe1);

   assign ram_data0 = we0?wr_data0:8'hZZ;
   assign ram_data1 = we1?wr_data1:8'hZZ;
   
   
   initial 
     begin
	$dumpfile("dualporttb.vcd");
	$dumpvars;
	oe0 = 0;
	oe1 = 0;
	we0 = 0;
	we1 = 0;

// Let's write something
	#10  addr0 = 4'h0;
	wr_data0 = 8'h21;
	we0 = 1;	
	// Let's read it
	#10  
	  addr0 = 4'h0;
	we0 = 0;
	oe0 = 1;
// Ok now let's write a lot of numbers
	#10  
	  begin
	     // Writing different address
	     addr0 = 4'h1;  	wr_data0 = 8'h19;	we0 = 1;  oe0 = 0;	
 	     addr1 = 4'h2;  	wr_data1 = 8'h12;	we1 = 1;  oe1 = 0;
	  end	
	#10  
	  begin
	     // Writing the same address
	     addr0 = 4'h3;  	wr_data0 = 8'h11;	we0 = 1;  oe0 = 0;	
 	     addr1 = 4'h3;  	wr_data1 = 8'hF8;	we1 = 1;  oe1 = 0;
	  end	
	#10  
	  begin
	     // Only the second one is writing
	     we0 = 0;	     
 	     addr1 = 4'h4;  	wr_data1 = 8'h15;	we1 = 1;  oe1 = 0;
	  end

	#10  
	  begin
	     // Replacing data
	     addr0 = 4'h0;  	wr_data0 = 8'h14;	we0 = 1;  oe0 = 0;	
 	     addr1 = 4'h3;  	wr_data1 = 8'hF8;	we1 = 1;  oe1 = 0;
	  end	

	for(i=4;i<16;i = i+2)  begin
	#10  
	  begin
	     // Replacing data
	     addr0 = i;  	wr_data0 = i+i+i;	we0 = 1;  oe0 = 0;	
 	     addr1 = i+1;  	wr_data1 = 5*i;	we1 = 1;  oe1 = 0;
	  end	
	end

	
	// Testing
	for(i=0;i<16;i = i+1) begin
	  #10   addr0 = i; oe0 = 1; we0 = 0;
	end
	
	//#10   addr0 = 4'h0; oe0 = 1; we0 = 0;
	

	
	#10 $finish;       	
     end  


   
always @(posedge clk)
  begin
     if (oe0 == 1) begin
	#1
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
