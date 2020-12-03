module HalfAdd (Cout, Sum, A, B);
	input A, B;
	output Cout, Sum;
	
	wire x1, x2, x3;
	
	nand nand1(x3, A, B);
	nand nand2(x1, A, x3);
	nand nand3(x2, x3, B);
	nand nand4(Sum, x1, x2);
	nand nand5(Cout, x3, x3);
	
endmodule
