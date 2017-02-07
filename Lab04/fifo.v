module fifo(clk,rst,data_in,rd_en,wr_en,data_out,empty,full);
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = 1<<ADDR_WIDTH;
input clk,rst,rd_en,wr_en;
input [DATA_WIDTH - 1:0] data_in;
output empty,full;
output [DATA_WIDTH - 1:0] data_out;
reg [ADDR_WIDTH-1:0] mem[0:RAM_DEPTH -1];
reg [ADDR_WIDTH :0] size = 8'd0;
reg [ADDR_WIDTH-1:0] head = 8'd0;
reg [ADDR_WIDTH-1:0] tail = 8'd0;
reg [ADDR_WIDTH-1:0] data_out = 8'd0;
wire [DATA_WIDTH - 1:0] data_ram;
DualPortRAM dpr(clk,tail,data_in,~wr_en,1'b0,head,data_ram,1'b0,rd_en);
assign full = (size==RAM_DEPTH-1);
assign empty = (size==9'd0);
always @(posedge clk or rst)
	begin
	if(rst)
		begin
			tail <= 8'd0;
		end
	else if(~wr_en)
		begin
			tail <= tail + 8'd1;
		end
	end
always @(posedge clk or rst)
	begin
	if(rst)
		begin
			head <= 8'd0;
		end
	else if(rd_en)
		begin
			head <= head + 8'd1;
		end
	end
always @(posedge clk or rst)
	begin
	if(rst)
		begin
			data_out <= 8'd0;
		end
	else if(rd_en)
		begin
			data_out <= data_ram;
		end
	end
always @(posedge clk or rst)
	begin
		if(rst)
			begin
				size <= 9'd0;
			end
		else if(rd_en && wr_en && size != 0)
			begin 
				size <= size - 9'd1;
			end
		else if(rd_en && wr_en && size != 0)
			begin 
				size <= size + 9'd1;
			end
	end
endmodule