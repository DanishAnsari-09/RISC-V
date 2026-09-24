module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

    input [31:0]A,B;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [31:0]Result;

    wire Cout;
    wire [31:0]Sum;

    assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign Result = (ALUControl == 3'b000) ? Sum :
                    (ALUControl == 3'b001) ? Sum :
                    (ALUControl == 3'b010) ? A & B :
                    (ALUControl == 3'b011) ? A | B :
                    (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}};
    
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule


/*module alu(A, B, ALU_Sel, ALU_Out, Zero, Negative, Carry, Overflow);
  input [31:0] A, B;
  input [2:0] ALU_Sel;
  output reg [31:0] ALU_Out;
  output Zero;
  output Negative;
  output Carry;
  output Overflow;

  always @(*)
  begin
    case (ALU_Sel)
      3'b000: ALU_Out = A & B; // AND
      3'b001: ALU_Out = A | B; // OR
        3'b010: {Carry,ALU_Out} = A + B; // ADD
      3'b011: ALU_Out = A - B; // SUBTRACT
      3'b100: ALU_Out = (A < B) ? 32'b1 : 32'b0; // SLT
      default: ALU_Out = 32'b0;
    endcase
  end

  assign Zero = (ALU_Out == 32'b0) ? 1'b1 : 1'b0;
  assign Negative = ALU_Out[31];
  assign Carry = 1'b0; // Placeholder - actual implementation depends on the specific operation
  assign Overflow = 1'b0; // Placeholder - actual implementation depends on the specific operation

endmodule;
*/
