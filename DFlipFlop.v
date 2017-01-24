`timescale 1ns/1ns
module DFlipFlop(q,clock,nreset,d);
	output q;
	input clock,nreset,d;
	reg q;
always @(posedge clock or nreset)
begin
      if(nreset) q=0;
      else q=d;
end
endmodule