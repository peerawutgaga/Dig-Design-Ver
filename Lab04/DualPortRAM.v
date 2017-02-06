module DualPortRAM(clk,address_0,data_0, we_0, oe_0, address_1, data_1, we_1, oe_1 );
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = 1<<ADDR_WIDTH;
input clk;
input [ADDR_WIDTH - 1:0] address_0;
input [ADDR_WIDTH - 1:0] address_1;
input we_0,oe_0,we_1,oe_1;
inout [DATA_WIDTH - 1:0] data_0;
inout [DATA_WIDTH - 1:0] data_1;
reg [DATA_WIDTH-1:0] ram[0:RAM_DEPTH-1];
assign data_0 = oe_0 ? ram[address_0] : 8'bZ;
assign data_1 = oe_1 ? ram[address_1] : 8'bZ;
always @(posedge clk)
	begin
		if(we_0 && we_1) 
			begin
				ram[address_0] = data_0;
			end
		else if(we_0 && ~we_1) 
			begin
				ram[address_0] = data_0;
			end
		else if(~we_0 && we_1) 
			begin
				ram[address_1] = data_1;
			end
		
		
	end
endmodule