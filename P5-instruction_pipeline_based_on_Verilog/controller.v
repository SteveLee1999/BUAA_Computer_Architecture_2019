`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module controller(
    input [5:0] opcode,
    input [5:0] funct,
	 input Bgez,
	 output reg [1:0] RegDst,
	 output reg [2:0] PCOp,
	 output reg [2:0] ALUOp,
	 output reg [1:0] EXTOp,
	 output reg MemWrite,
	 output reg RegWrite,
	 output reg ALUSrc,
	 output reg [1:0] MemtoReg
    );
	 
	 always @(*)//不需要关心的也赋值为0
	 begin
	    if(opcode==6'b000000)
		 begin
		    case(funct)
			    6'b100001://addu
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=0;
					 MemtoReg=1;
				 end
				 
				 6'b100011://subu
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=1;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=0;
					 MemtoReg=1;
				 end
				 
				 6'b001000://jr
				 begin
				    RegDst=0;
					 PCOp=3;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrc=0;
					 MemtoReg=0;
				 end
				 
				 6'b000000://nop
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrc=0;
					 MemtoReg=0;
				 end
			 endcase
		 end
		 
		 else
		 begin
		    case(opcode)			 
				 6'b000100://beq
				 begin
				    RegDst=0;
					 PCOp=1;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrc=0;
					 MemtoReg=0;
				 end
				 
				 6'b000001://bgezal
				 begin
				    if(Bgez==1)
					 begin
				       RegDst=2;
					    PCOp=4;
					    ALUOp=0;
					    EXTOp=0;
					    MemWrite=0;
					    RegWrite=1;
					    ALUSrc=0;
					    MemtoReg=3;
				    end
					 
					 else
					 begin
					    RegDst=0;
					    PCOp=0;
					    ALUOp=0;
					    EXTOp=0;
					    MemWrite=0;
					    RegWrite=0;
					    ALUSrc=0;
					    MemtoReg=0;
					 end
				 end
				 
				 6'b000010://j
				 begin
				    RegDst=2;
					 PCOp=2;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrc=0;
					 MemtoReg=0;
				 end
				 
				 6'b000011://jal
				 begin
				    RegDst=2;
					 PCOp=2;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=0;
					 MemtoReg=3;
				 end
				 
				 6'b001101://ori
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=3;
					 EXTOp=1;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=1;
					 MemtoReg=1;
				 end
				 
				 6'b001111://lui
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=2;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=0;
					 MemtoReg=2;
				 end
				 
				 6'b100011://lw
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=1;
					 MemtoReg=0;
				 end
				 
				 6'b101011://sw
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=1;
					 RegWrite=0;
					 ALUSrc=1;
					 MemtoReg=0;
				 end	
             
             6'b011100://clz
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=6;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrc=0;
					 MemtoReg=1;
				 end				 
			 endcase
		 end
	 end

endmodule
