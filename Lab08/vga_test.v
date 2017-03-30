module vga_test
	(
		input wire clk, reset,
		input wire [11:0] sw,
		input btnU,btnL,btnR,
		output wire hsync, vsync,
		output wire [11:0] rgb
	);
	
	// register for Basys 2 8-bit RGB DAC 
	reg [11:0] rgb_reg;
	reg [11:0] mem [1:0];
	wire fbtnL,fbtnR,fbtnU;
	wire lbtnL,lbtnR,lbtnU;
	reg state;
	Debouncer d1 (fbtnU,clk,btnU);
	Debouncer d2 (fbtnL,clk,btnL);
	Debouncer d3 (fbtnR,clk,btnR);
	singlePulser s1 (lbtnU,fbtnU,clk);
	singlePulser s2 (lbtnL,fbtnL,clk);
	singlePulser s3 (lbtnR,fbtnR,clk);
	
	// video status output from vga_sync to tell when to route out rgb signal to DAC
	wire video_on;
	wire [9:0] x,y;

        // instantiate vga_sync
        vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                                .video_on(video_on), .p_tick(), .x(x), .y(y));
        // rgb buffer
        always @(posedge clk, posedge reset)
        if (reset) begin
            rgb_reg <= 0;
            mem[0] <= 0;
            mem[1] <= 0;
            state <= 0;
        end else begin
            if(lbtnL) begin
                mem[0] <= sw;
            end
            if(lbtnR) begin
                mem[1] <= sw;
            end
            if(lbtnU) begin
                state <= !state;
            end
            
            if(state) begin
                rgb_reg[3:0] <= ((mem[0][3:0]*y) + (mem[1][3:0]*(480-y))) / 480;
                rgb_reg[7:4] <= ((mem[0][7:4]*y) + (mem[1][7:4]*(480-y))) / 480;
                rgb_reg[11:8] <= ((mem[0][11:8]*y) + (mem[1][11:8]*(480-y))) / 480;
            end else begin
                rgb_reg[3:0] <= ((mem[0][3:0]*x) + (mem[1][3:0]*(640-x))) / 640;
                rgb_reg[7:4] <= ((mem[0][7:4]*x) + (mem[1][7:4]*(640-x))) / 640;
                rgb_reg[11:8] <= ((mem[0][11:8]*x) + (mem[1][11:8]*(640-x))) / 640;
            end
        end
        
        // output
        assign rgb = (video_on) ? rgb_reg : 12'b0;
endmodule