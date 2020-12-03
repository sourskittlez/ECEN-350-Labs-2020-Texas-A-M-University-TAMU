module Mux21 (out, in, sel);
	input [1:0] in;
	input sel;
	output out;
	
	wire x1, x2, x3;
	
	not not1(x1, sel);
	and and1(x2, in[0], x1);
	and and2(x3, in[1], sel);
	or or1(out, x2, x3);
	
endmodule
