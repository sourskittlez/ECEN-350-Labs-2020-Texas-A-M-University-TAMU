`timescale 1ns / 1ps
`include "NextPCLogic.v"

`define STRLEN 32
module NextPCLogicTest;

	initial //This initial block used to dump all wire/reg values to dump file
     begin
       $dumpfile("NextPCLogicTest.vcd");
       $dumpvars(0, NextPCLogicTest);
     end

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut =  = expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed =  = numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] CurrentPC;
	reg [63:0] SignExtImm64;
	reg Branch;
	reg ALUZero;
	reg Uncondbranch;
	reg [7:0] passed;//not part of original verilog module

	// Outputs
	wire [63:0] NextPC;

	// Instantiate the Unit Under Test (UUT)
	NextPCLogic dut (
		.CurrentPC(CurrentPC), 
		.SignExtImm64(SignExtImm64), 
		.Branch(Branch), 
		.ALUZero(ALUZero), 
		.Uncondbranch(Uncondbranch), 
		.NextPC(NextPC)
	);

	initial begin
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		passed = 0;
		
		#3;
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'b0, 1'b0, 1'b0, 1'b0};
		#10 passTest(NextPC, 64'h14, "PC+4", passed);
		$display (" CurrentPC: %d \n SignExtImm64: %b \n Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d \n", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h2, 1'b1, 1'b1, 1'b0};
		#10 passTest(NextPC, 64'h18, "Conditional with branching", passed);
		$display (" CurrentPC: %d \n SignExtImm64: %b \n Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d \n", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h3, 1'b1, 1'b0, 1'b0};
		#10 passTest(NextPC, 64'h14, "Conditional no branching", passed);
		$display (" CurrentPC: %d \n SignExtImm64: %b \n Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d \n", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h4, 1'b0, 1'b0, 1'b1};
		#10 passTest(NextPC, 64'h20, "Unconditional branching", passed);
		$display (" CurrentPC: %d \n SignExtImm64: %b \n Branch: %d \n ALUZero: %d \n Uncondbranch: %d \n NextPC: %d \n", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch, NextPC);

		allPassed(passed, 4);
	end
      
endmodule
