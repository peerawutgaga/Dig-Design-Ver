`timescale 1ns/1ns
module testCounter();
reg clock;
reg nreset;
reg enable;
wire [3:0] q;
counter #(4) c1 (q,clock,nreset,enable);
initial
begin
       $display("Time\tQ\tnreset enable");
       $monitor("%4.0t\t%b\t  %d     %d",$time,q,nreset,enable);
       $dumpfile("testCounter2.vcd");
       $dumpvars(0,c1);
       clock=0;
       nreset=0;
       enable=0;
       //fork
       #0 clock =0;
       #5 nreset=1;
       #25 enable=1;
       #75 nreset =0;
       #100 enable=0;
       #135 enable =1;
       #165 nreset =1;
       #500 $finish;
       //join
end
always
begin
       #10 clock=!clock;
end
endmodule