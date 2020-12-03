`timescale 1ns / 1ps

`define STRLEN 32
module RegisterFileTest2_v;

		initial
     begin
       $dumpfile("RegisterFileTest2_v.vcd");
       $dumpvars(0, RegisterFileTest2_v);
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
	reg [63:0] BusW;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW;
	reg RegWr;
	reg Clk;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusA;
	wire [63:0] BusB;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile dut (
		.BusA(BusA), 
		.BusB(BusB), 
		.BusW(BusW), 
		.RA(RA), 
		.RB(RB), 
		.RW(RW), 
		.RegWr(RegWr), 
		.Clk(Clk)
	);

	initial begin
		// Initialize Inputs
		BusW = 0;
		RA = 0;
		RB = 0;
		RW = 0;
		RegWr = 0;
		Clk = 1;
		passed = 0;
		
		#10;

		{RA, RB, RW, BusW, RegWr} = {5'd31, 5'd31, 5'd31, 64'h0, 1'b0};
		#10
		passTest(BusA, 64'd0, "Initial $0 Check 1", passed);
		passTest(BusB, 64'd0, "Initial $0 Check 2", passed);
		#10; Clk = 0; #10; Clk = 1;
		
		{RA, RB, RW, BusW, RegWr} = {5'd31, 5'd31, 5'd31, 64'h12345678, 1'b1};
		passTest(BusA, 64'd0, "Initial $0 Check 3", passed);
		passTest(BusB, 64'd0, "Initial $0 Check 4", passed);
		#10; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd0, "$0 Stays 0 Check 1", passed);
		passTest(BusB, 64'd0, "$0 Stays 0 Check 2", passed);
		
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 64'h0, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd1, 64'h1, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd2, 64'h2, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd3, 64'h3, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd4, 64'h4, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd5, 64'h5, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd6, 64'h6, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd7, 64'h7, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd8, 64'h8, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd9, 64'h9, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd10, 64'd10, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd11, 64'd11, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd12, 64'd12, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd13, 64'd13, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd14, 64'd14, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd15, 64'd15, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd16, 64'd16, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd17, 64'd17, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd18, 64'd18, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd19, 64'd19, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd20, 64'd20, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd21, 64'd21, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd22, 64'd22, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd23, 64'd23, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd24, 64'd24, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd25, 64'd25, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd26, 64'd26, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd27, 64'd27, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd28, 64'd28, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd29, 64'd29, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd30, 64'd30, 1'b1};#10; Clk = 0; #10; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd31, 64'd31, 1'b1};#10; Clk = 0; #10; Clk = 1;

		//Test 1
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd1, 5'h0, 64'h0, 1'b0};
		#4;
		passTest(BusA, 64'd0, "BusA reading X0", passed);
		passTest(BusB, 64'd1, "BusA reading X1", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd0, "BusA reading X0", passed);
		passTest(BusB, 64'd1, "BusA reading X1", passed);

		//Test 2
		{RA, RB, RW, BusW, RegWr} = {5'd2, 5'd3, 5'h1, 64'h1000, 1'b0};
		#4;
		passTest(BusA, 64'd2, "BusA reading X2", passed);
		passTest(BusB, 64'd3, "BusA reading X3", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd2, "BusA reading X2", passed);
		passTest(BusB, 64'd3, "BusA reading X3", passed);
		
		//Test 3
		{RA, RB, RW, BusW, RegWr} = {5'd4, 5'd5, 5'h0, 64'h1000, 1'b1};
		#4;
		passTest(BusA, 64'd4, "BusA reading X4", passed);
		passTest(BusB, 64'd5, "BusA reading X5", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd4, "BusA reading X4", passed);
		passTest(BusB, 64'd5, "BusA reading X5", passed);
		
		//Test 4
		{RA, RB, RW, BusW, RegWr} = {5'd6, 5'd7, 5'hA, 64'h1010, 1'b1};
		#4;
		passTest(BusA, 64'd6, "BusA reading X6", passed);
		passTest(BusB, 64'd7, "BusA reading X7", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd6, "BusA reading X6", passed);
		passTest(BusB, 64'd7, "BusA reading X7", passed);
		
		//Test 5
		{RA, RB, RW, BusW, RegWr} = {5'd8, 5'd9, 5'hB, 64'h103000, 1'b1};
		#4;
		passTest(BusA, 64'd8, "BusA reading X8", passed);
		passTest(BusB, 64'd9, "BusA reading X9", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd8, "BusA reading X8", passed);
		passTest(BusB, 64'd9, "BusA reading X9", passed);
		
		//Test 6
		{RA, RB, RW, BusW, RegWr} = {5'hA, 5'hB, 5'hC, 64'h0, 1'b0};
		#4;
		passTest(BusA, 64'h1010, "BusA reading X10", passed);
		passTest(BusB, 64'h103000, "BusA reading X11", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'h1010, "BusA reading X10", passed);
		passTest(BusB, 64'h103000, "BusA reading X11", passed);
		
		//Test 7
		{RA, RB, RW, BusW, RegWr} = {5'hC, 5'hD, 5'hD, 64'hABCD, 1'b1};
		#4;
		passTest(BusA, 64'd12, "BusA reading X12", passed);
		passTest(BusB, 64'd13, "BusA reading X13", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd12, "BusA reading X12", passed);
		passTest(BusB, 64'hABCD, "BusA reading X13", passed);
		
		//Test 8
		{RA, RB, RW, BusW, RegWr} = {5'hE, 5'hF, 5'hE, 64'h9080009, 1'b0};
		#4;
		passTest(BusA, 64'd14, "BusA reading X14", passed);
		passTest(BusB, 64'd15, "BusA reading X15", passed);
		#6; Clk = 0; #10; Clk = 1;
		passTest(BusA, 64'd14, "BusA reading X14", passed);
		passTest(BusB, 64'd15, "BusA reading X15", passed);

		allPassed(passed, 38);
	end
      
endmodule
