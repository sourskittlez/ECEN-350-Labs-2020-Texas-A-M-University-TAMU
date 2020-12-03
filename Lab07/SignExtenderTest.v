`timescale 1ns / 1ps

`define STRLEN 32
module SignExtenderTest;

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
	reg [25:0] Imm26; 
	reg [1:0]Ctrl; 
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusImm; 

	SignExtender uut (
		.BusImm(BusImm), 
		.Imm26(Imm26), 
		.Ctrl(Ctrl)
	);

	initial begin
		Imm26 = 0;
		passed = 0;

		// Add stimulus here
		#10; {Ctrl, Imm26} = {2'b00, 26'b01000000000011000001000000}; #10;
			passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000000000001100, "I Test 1", passed);
			
		#10; {Ctrl, Imm26} = {2'b00, 26'b01001111111111110000100001}; #10;
			passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000111111111111, "I Test 2", passed);
			
		#10; {Ctrl, Imm26} = {2'b01, 26'b00000100001111000010000001}; #10;
			passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111111111100001111, "D Test 1", passed);
			
		#10; {Ctrl, Imm26} = {2'b01, 26'b00010000101000000000110011}; #10;
			passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000000000101000, "D Test 2", passed);
			
		#10; {Ctrl, Imm26} = {2'b10, 26'b00000000000000000000000010}; #10;
			passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000000000000010, "B Test 1", passed);
			
		#10; {Ctrl, Imm26} = {2'b10, 26'b11111111111111111111111100}; #10;
			passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111111111111111100, "B Test 2", passed);
			
		#10; {Ctrl, Imm26} = {2'b11, 26'b00000000000000000001000001}; #10;
			passTest(BusImm, 64'b0000000000000000000000000000000000000000000000000000000000000010, "CBZ Test 1", passed);
			
		#10; {Ctrl, Imm26} = {2'b11, 26'b11111111111111111111000010}; #10;
			passTest(BusImm, 64'b1111111111111111111111111111111111111111111111111111111111111110, "CBZ Test 2", passed);
			
		#10;

		allPassed(passed, 8);

	end
      
endmodule
