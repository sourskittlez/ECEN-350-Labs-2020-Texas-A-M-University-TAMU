`timescale 1ns/ 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];

    // start by setting 31 to 0
    initial begin
        registers[31] = 0;
    end

    //every two ticks, Buses A and B are updated
    assign #2 BusA = registers[RA];
    assign #2 BusB = registers[RB];
     
    //on the clocks negative edge, update the register at Rw
    always @ (negedge Clk) begin
        if(RegWr) 
            if(RW ! = 31)  // 31 must always be 0
               registers[RW] < = #3 BusW; 
    end
endmodule
