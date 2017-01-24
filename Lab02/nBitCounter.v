// Module: counter
// n-bit counter with (asynchronous reset) and enable
module counter(q, clock, nreset, enable);
parameter bitSize=8;
output [bitSize-1:0] q;
input clock;
input nreset;
input enable;
reg [bitSize-1:0] q;
always @(posedge clock or nreset)
	begin
		// counter code
		if(~nreset)
			q = 0;
		else if(enable)
			q = q+1;		
	end
endmodule