module singlecycle(
    input resetl, 
    input [63:0] startpc, 
    output reg [63:0] currentpc, 
    output [63:0] dmemout, 
    input CLK
);
    //WIRES

    // Next PC connections
    wire [63:0] nextpc;       // The next PC, to be updated on clock cycle

    // Instruction Memory connections
    wire [31:0] instruction;  // The current instruction

    // Parts of instruction
    wire [4:0] rd;            // The destination register
    wire [4:0] rm;            // Operand 1
    wire [4:0] rn;            // Operand 2
    wire [10:0] opcode;

    // Control wires
    wire reg2loc;
    wire alusrc;
    wire mem2reg;
    wire regwrite;
    wire memread;
    wire memwrite;
    wire branch;
    wire uncond_branch;
    wire [3:0] aluctrl;
    wire [2:0] signop;

    // Register file connections
    wire [63:0] regoutA, regoutB, busw;     // Outputs A and B

    // ALU connections
    wire [63:0] signExtImm64, aluBusB, aluout;
    wire zero;

    // Sign Extender connections
    wire [63:0] extimm;

    // PC update logic
    always @(negedge CLK)
    begin
        if (resetl)
            currentpc < = nextpc;
        else
            currentpc < = startpc;
    end

    // Parts of instruction
    assign rd = instruction[4:0];
    assign rm = instruction[9:5];
    assign rn = reg2loc ? instruction[4:0] : instruction[20:16];
    assign opcode = instruction[31:21];


    //MODULES 
    SignExtender signextender(
        .BusImm(signExtImm64), 
        .Imm26(instruction[25:0]), 
        .Ctrl(signop), 
        .ShiftBits(opcode[1:0])
    );

    InstructionMemory imem(
        .Data(instruction), 
        .Address(currentpc)
    );

    NextPCLogic nextPCLogic(
        .NextPC(nextpc), 
        .CurrentPC(currentpc), 
        .SignExtImm64(signExtImm64), 
        .Branch(branch), 
        .ALUZero(zero), 
        .Uncondbranch(uncond_branch)
    ); 

    control control(
        .reg2loc(reg2loc), 
        .alusrc(alusrc), 
        .mem2reg(mem2reg), 
        .regwrite(regwrite), 
        .memread(memread), 
        .memwrite(memwrite), 
        .branch(branch), 
        .uncond_branch(uncond_branch), 
        .aluop(aluctrl), 
        .signop(signop), 
        .opcode(opcode)
    );

    RegisterFile regfile(
        .BusA(regoutA), 
        .BusB(regoutB), 
        .BusW(busw), 
        .RA(rm), 
        .RB(rn), 
        .RW(rd), 
        .RegWr(regwrite), 
        .Clk(CLK)
    );

    assign aluBusB = alusrc ? signExtImm64 : regoutB;

    ALU ALU(
        .BusW(aluout), 
        .BusA(regoutA), 
        .BusB(aluBusB), 
        .ALUCtrl(aluctrl), 
        .Zero(zero)
    );

    DataMemory dataMem(
        .ReadData(dmemout), 
        .Address(aluout), 
        .WriteData(regoutB), 
        .MemoryRead(memread), 
        .MemoryWrite(memwrite), 
        .Clock(CLK)
    );

    assign busw = mem2reg ? dmemout : aluout;


endmodule

