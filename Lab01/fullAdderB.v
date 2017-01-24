module fullAdderB(cout, s, a, b, cin);
	output cout;
	output s;
	input a;
	input b;
	input cin;
	assign {cout,s} = a+b+cin;
	/*reg cout, s;
	always @(a,b,cin)
		begin
			{cout,s} = a+b+cin;
		end*/
endmodule