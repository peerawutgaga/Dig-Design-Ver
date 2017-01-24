module clockDivider(dclock, clock);
output dclock;
input clock;
wire [3:0] d;
reg enable = 1'b1;
reg nreset = 1'b1;
counter #(4) c(d,clock,nreset,enable);
always(posedge clock)
	begin
		dclock = d[3];
	end
endmodule