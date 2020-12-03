`timescale 1ns / 1ps

module NextPCLogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
    input [63:0] CurrentPC, SignExtImm64; 
    input Branch, ALUZero, Uncondbranch; 
    output reg [63:0] NextPC; 
    reg [63:0] realImm64;

    always @(*) begin
    
        realImm64 = SignExtImm64 << 2; 

        if(Uncondbranch) //update pc to jump to our branched address
            NextPC  < = #2 CurrentPC + realImm64; 
        else if(Branch) //same thing as unconditionalBranch but only if ALUZero is 1
            if(ALUZero =  = 1)
                NextPC < = #2 CurrentPC + realImm64; 
            else
                NextPC < = #2 CurrentPC + 4; 
        else //in the case of a non branching instruction
            NextPC < = #2 CurrentPC + 4; 
    end

endmodule
