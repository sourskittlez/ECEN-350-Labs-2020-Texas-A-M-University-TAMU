`timescale 1ns / 1ps

module SignExtender(BusImm, Imm26, Ctrl, ShiftBits); 
  output reg [63:0] BusImm; 
  input [25:0] Imm26; 
  input [2:0]Ctrl; 
  input [1:0]ShiftBits;

  always @(*) begin
    if(Ctrl =  = 3'b00)                             // I type
        BusImm = {{52{1'b0}}, Imm26[21:10]};
    else if(Ctrl =  = 3'b001)                        // D type
        BusImm = {{55{Imm26[20]}}, Imm26[20:12]};
    else if(Ctrl =  = 3'b010)                        // B
        BusImm = {{38{Imm26[25]}}, Imm26};
    else if(Ctrl =  = 3'b011)                        // CB
        BusImm = {{45{Imm26[23]}}, Imm26[23:5]};
    else if(Ctrl =  = 3'b100)                        // MOVZ
        if(ShiftBits =  = 2'b00)      //no shift
            BusImm = {{48{1'b0}}, Imm26[20:5]};
        else if(ShiftBits =  = 2'b01) //16 bit shift
            BusImm = {{32{1'b0}}, Imm26[20:5], {16{1'b0}}};
        else if(ShiftBits =  = 2'b10) //32 bit shift
            BusImm = {{16{1'b0}}, Imm26[20:5], {32{1'b0}}};
        else if(ShiftBits =  = 2'b11) //48 bit shift
            BusImm = {Imm26[20:5], {48{1'b0}}};
  end

endmodule
