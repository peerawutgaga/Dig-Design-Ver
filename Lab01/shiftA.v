module shiftA(q,clock,d);
	output [1:0] q;
	input clock,d;
	reg [1:0] q;
always @(posedge clock)
begin
	q[0]=d;
    q[1]=q[0];
end
endmodule