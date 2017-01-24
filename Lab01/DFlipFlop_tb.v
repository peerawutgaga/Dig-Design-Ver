module testDFlipFlop();
reg clock, nreset, d;
DFlipFlop D1(q,clock,nreset,d);
always
#10 clock=~clock;
initial
begin
      //$dumpfile("testDFlipFlop.dump");
      $dumpfile("test1.vcd");
      $dumpvars(1,D1);
      #0 d=0; clock=0; nreset=0;
      #30 d=0; nreset=1;
      #20 d=1; nreset=1;
      #20 d=1; nreset=0;
      #20 d=0; nreset=0;
      #20 d=1; nreset=0;
      #20 d=1; nreset=1;
      #20 $finish;
end
endmodule