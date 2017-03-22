module singlePulser(out,in,clock);
input in,clock;
output out;
reg [1:0] state = 2'b00;
reg out;
always @(posedge clock)
begin
    if(in)
    begin
        case(state)
        2'b00 : state = 2'b01;
        2'b01 : state = 2'b10;
        2'b10 : state = 2'b10;
        endcase
    end
    else
    begin
        state = 0;
    end
end
always @(state)
begin
    case (state)
    2'b00 : out = 0;
    2'b01 : out = 1;
    2'b10 : out = 0;
    endcase
end
endmodule