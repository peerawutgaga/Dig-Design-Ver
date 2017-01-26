module clockDivider(dclock, clock);
parameter cycle = 50000000/(2*1000000);
output dclock;
input clock;
wire [4:0] d;
reg enable = 5'b00001;
reg nreset = 5'b00000;
reg dclock = 0;
counter #(5) c(d,clock,nreset,enable);
always @(posedge clock)
	begin
		if(d == cycle-1)
			begin
				nreset = 0 ;
				dclock = ~dclock;
			end
		else nreset =1;
		
	end
endmodule
