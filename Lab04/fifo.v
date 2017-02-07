module fifo(clk,rst,data_in,rd_en,wr_en,data_out,empty,full);
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = 1<<ADDR_WIDTH;
input clk,rst,rd_en,wr_en;
input [DATA_WIDTH - 1:0] data_in;
output empty,full;
output [DATA_WIDTH - 1:0] data_out;
reg [ADDR_WIDTH :0] size;
reg [ADDR_WIDTH-1:0] head;
reg [ADDR_WIDTH-1:0] tail;
reg [ADDR_WIDTH-1:0] mem [0:RAM_DEPTH-1];
integer i;
assign full = (size == RAM_DEPTH);
assign empty = (size == 9'd0);
assign data_out = mem[head];
always @(posedge clk or rst)
	begin
		if(rst)
			begin
				head = 0;
				tail = 0;
				size = 0;
				for(i=0;i<RAM_DEPTH;i = i+1)
				begin
					mem[i] = 8'bz;
				end
			end
		else
			begin
				if(rd_en && ~empty)
					begin
						head = head + 1;
						size = size - 1;
					end
				else if(~wr_en && ~full)
					begin
						mem[tail] = data_in;
						tail = tail + 1;
						size = size + 1;
					end
			end
	end
endmodule
