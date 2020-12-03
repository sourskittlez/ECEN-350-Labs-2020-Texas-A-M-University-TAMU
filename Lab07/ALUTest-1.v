`timescale 1ns / 1ps

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut =  = expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed =  = numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234, 0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
		
		//Add
		{BusA, BusB, ALUCtrl} = {64'h20, 64'h4500, 4'h2}; #40; passTest({Zero, BusW}, 65'h4520, "ADD 1", passed);
		{BusA, BusB, ALUCtrl} = {64'h5143, 64'h34642, 4'h2}; #40; passTest({Zero, BusW}, 65'h39785, "ADD 2", passed);
				
		//AND
		{BusA, BusB, ALUCtrl} = {64'h20, 64'h4500, 4'h0}; #40; passTest({Zero, BusW}, 65'h0, "AND 1", passed);
		{BusA, BusB, ALUCtrl} = {64'h5143, 64'h34642, 4'h0}; #40; passTest({Zero, BusW}, 65'h4042, "AND 2", passed);
		
		//ORR
		{BusA, BusB, ALUCtrl} = {64'h5143, 64'h34642, 4'h1}; #40; passTest({Zero, BusW}, 65'h035743, "ORR 1", passed);
		{BusA, BusB, ALUCtrl} = {64'hB45D, 64'hDF346, 4'h1}; #40; passTest({Zero, BusW}, 65'hDF75F, "ORR 2", passed);
		
		//SUB
		{BusA, BusB, ALUCtrl} = {64'hDF346, 64'hB45D, 4'h6}; #40; passTest({Zero, BusW}, 65'hD3EE9, "SUB 1", passed);
		{BusA, BusB, ALUCtrl} = {64'h4500, 64'h4500, 4'h6}; #40; passTest({Zero, BusW}, 65'h0, "SUB 2", passed);
		
		//Pass
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h7}; #40; passTest({Zero, BusW}, 65'hABCD0000, "PASS 1", passed);
		{BusA, BusB, ALUCtrl} = {64'hDF346, 64'hB45D, 4'h7}; #40; passTest({Zero, BusW}, 65'hB45D, "PASS 2", passed);

		allPassed(passed, 11);
	end
      
endmodule

