module twoBCD(qa,qb,clock,nreset,enable);
output [6:0] qa;
output [6:0] qb;
input clock,enable,nreset;
reg [6:0] qa = 7'b1111110;//for 1st 7 segment
reg [6:0] qb = 7'b1111110;//for 2nd 7 segment
wire [3:0] q1;//1st counter's output
reg [3:0] q2 = 0;//2nd counter's output
reg nre1;
counter #(4) c1(q1,clock,nre1,enable);
always @(posedge clock or nreset)
begin
	if(~nreset)
	begin
		nre1 = 0;
		q2 = 0;
	end
	else if(q1==9) nre1 = 0;
	else nre1 = 1;
end
always @(q1)
begin
	if(q2 == 9 && q1 == 0 ) q2 = 0;
	else if(q1 == 0) q2 = q2+1;
	
	
end
always @(q1 or q2)
	begin
	case(q1)
			4'd0 : qa = 7'b1111110; //0
			4'd1 : qa = 7'b0110000; //1
			4'd2 : qa = 7'b1101101; //2
			4'd3 : qa = 7'b1111001; //3
			4'd4 : qa = 7'b0110011; //4
			4'd5 : qa = 7'b1011011; //5
			4'd6 : qa = 7'b1011111; //6
			4'd7 : qa = 7'b1110000; //7
			4'd8 : qa = 7'b1111111; //8
			4'd9 : qa = 7'b1111011; //9
			default : qa = 7'b1111110; //dash
	endcase	
	case(q2)
			4'd0 : qb = 7'b1111110; //0
			4'd1 : qb = 7'b0110000; //1
			4'd2 : qb = 7'b1101101; //2
			4'd3 : qb = 7'b1111001; //3
			4'd4 : qb = 7'b0110011; //4
			4'd5 : qb = 7'b1011011; //5
			4'd6 : qb = 7'b1011111; //6
			4'd7 : qb = 7'b1110000; //7
			4'd8 : qb = 7'b1111111; //8
			4'd9 : qb = 7'b1111011; //9
			default : qb = 7'b1111110; //dash
			endcase
	end
endmodule
