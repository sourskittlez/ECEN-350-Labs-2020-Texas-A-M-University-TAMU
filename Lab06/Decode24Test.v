`timescale 1ns / 1ps

`define STRLEN 15
module Decode24Test_v;

	initial //This initial block used to dump all wire/reg values to dump file
     begin
       $dumpfile("Decode24Test_v.vcd");
       $dumpvars(0, Decode24Test_v);
     end

	task passTest;
		input [3:0] actualOut, expectedOut;
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
	reg [1:0] in;
	reg [7:0] passed;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	Decode24 uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		passed = 0;

		// Add stimulus here
		#90; in = 0; #10; passTest(out, 1, "Input 0", passed);
		#90; in = 1; #10; passTest(out, 2, "Input 1", passed);
		#90; in = 2; #10; passTest(out, 4, "Input 2", passed);
		#90; in = 3; #10; passTest(out, 8, "Input 3", passed);
		#90;
		
		allPassed(passed, 4);

	end
      
endmodule

