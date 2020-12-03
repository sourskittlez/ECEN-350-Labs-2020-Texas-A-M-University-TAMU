`timescale 1ns / 1ps

module SignExtender(BusImm, Imm26, Ctrl); 
  output reg [63:0] BusImm; 
  input [25:0] Imm26; 
  input [1:0]Ctrl; 

  wire extBit; 
  assign #1 extBit = (Ctrl ? 1'b0 : Imm26[25]); 
  
  always @(*) begin
    if(Ctrl =  = 2'b00)                            // I type
        BusImm = {{52{1'b0}}, Imm26[21:10]};
    else if(Ctrl =  = 2'b01)                       // D type
        BusImm = {{55{Imm26[20]}}, Imm26[20:12]};
    else if(Ctrl =  = 2'b10)                       // B
        BusImm = {{38{Imm26[25]}}, Imm26};
    else                                         // CB
        BusImm = {{45{Imm26[23]}}, Imm26[23:5]};
  end

endmodule
