`timescale 1ns/1ns
module tester;
      reg a,b,cin;
      wire cout,s;
      fullAdder a1(cout,s,a,b,cin);
      fullAdderB a2(cout,s,a,b,cin);
initial
begin
      //$dumpfile("time.dump");
      $dumpfile("test.vcd");
      $dumpvars(2,a1,a2);
      $monitor("time %t: {%b %b} <- {%d %d %d}", $time,cout,s,a,b,cin);
      #0; a=0; b=0; cin=0;
      #10; a=0; b=0; cin=1;
      #10; a=0; b=1; cin=0;
      #10; a=0; b=1; cin=1;
      #10; a=1; b=0; cin=0;
      #10; a=1; b=0; cin=1;
      #10; a=1; b=1; cin=0;
      #10; a=1; b=1; cin=1;
$finish; end
endmodule