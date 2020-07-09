`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module controller(
    input [5:0] opcode,
    input [5:0] funct,
	 output reg [1:0] RegDst,
	 output reg [1:0] PCOp,
	 output reg [2:0] ALUOp,
	 output reg [1:0] EXTOp,
	 output reg MemWrite,
	 output reg RegWrite,
	 output reg ALUSrc,
	 output reg [1:0] MemtoReg
    );
	 
	 always @(*)
	 begin
	    if(opcode==6'b000000)
		 begin
		    case(funct)
			    6'b100001://addu
				 begin
				    RegDst=2'b01;
					 PCOp=2'b00;
					 ALUOp=3'b000;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=0;
					 MemtoReg=2'b01;
				 end
				 
				 6'b100011://subu
				 begin
				    RegDst=2'b01;
					 PCOp=2'b00;
					 ALUOp=3'b001;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=0;
					 MemtoReg=2'b01;
				 end
				 
				 6'b001000://jr
				 begin
					 PCOp=2'b11;
					 MemWrite=0;
					 RegWrite=0;
				 end
				 
				 6'b000000://nop
				 begin
				    PCOp=2'b00;
					 MemWrite=0;
					 RegWrite=0;
				 end
			 endcase
		 end
		 
		 else
		 begin
		    case(opcode)
			    6'b000100://beq
				 begin
				    RegDst=2'b00;
					 PCOp=2'b01;
					 EXTOp=2'b00;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrc=0;
				 end
				 
				 6'b001101://ori
				 begin
				    RegDst=2'b00;
					 PCOp=2'b00;
					 ALUOp=3'b011;
					 EXTOp=2'b01;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=1;
					 MemtoReg=2'b01;
				 end
				 
				 6'b100011://lw
				 begin
				    RegDst=2'b00;
					 PCOp=2'b00;
					 ALUOp=3'b000;
					 EXTOp=2'b00;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=1;
					 MemtoReg=2'b00;
				 end
				 
				 6'b101011://sw
				 begin
				    RegDst=2'b00;
					 PCOp=2'b00;
					 ALUOp=3'b000;
					 EXTOp=2'b00;
					 MemWrite=1;
					 RegWrite=0;
					 ALUSrc=1;
				 end
				 
				 6'b001111://lui
				 begin
				    RegDst=2'b00;
					 PCOp=2'b00;
					 EXTOp=2'b10;
					 MemWrite=0;
					 RegWrite=1;
					 MemtoReg=2'b10;
				 end
				 
				 6'b000011://jal
				 begin
				    RegDst=2'b10;
					 PCOp=2'b10;
					 MemWrite=0;
					 RegWrite=1;
					 MemtoReg=2'b11;
				 end
			 endcase
		 end
	 end

endmodule
