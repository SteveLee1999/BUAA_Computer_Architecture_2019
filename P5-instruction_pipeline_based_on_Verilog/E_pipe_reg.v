`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module E_pipe_reg(
    input clk,
    input reset,
	 input Stall,
	 input [31:0] PC4_D,
	 input [31:0] IR_D,
    input [31:0] RD1_D,
    input [31:0] RD2_D,
    input [31:0] imm_D,
	 
	 input [1:0] RegDst_D,
	 input [2:0] ALUOp_D,
	 input MemWrite_D,
	 input RegWrite_D,
	 input ALUSrc_D,
	 input [1:0] MemtoReg_D,
	 
    output reg [31:0] PC4_E,
	 output reg [31:0] IR_E,
    output reg [31:0] RS_E,
    output reg [31:0] RT_E,
    output reg [31:0] imm_E,
	 
	 output reg [1:0] RegDst_E,
	 output reg [2:0] ALUOp_E,
	 output reg MemWrite_E,
	 output reg RegWrite_E,
	 output reg ALUSrc_E,
	 output reg [1:0] MemtoReg_E
    );
	 
	 initial
	 begin
			 PC4_E=32'h00003000;
			 IR_E=0;
			 RS_E=0;
			 RT_E=0;
			 imm_E=0;
			 
			 RegDst_E=0;
	       ALUOp_E=0;
	       MemWrite_E=0;
	       RegWrite_E=0;
	       ALUSrc_E=0;
	       MemtoReg_E=0;
	 end
	 
	 always @(posedge clk)
	 begin
	    if(reset==1||Stall==1) 
		 begin
			 PC4_E=0;
			 IR_E=0;
			 RS_E=0;
			 RT_E=0;
			 imm_E=0;
			 
			 RegDst_E=0;
	       ALUOp_E=0;
	       MemWrite_E=0;
	       RegWrite_E=0;
	       ALUSrc_E=0;
	       MemtoReg_E=0;
		 end
		 
		 else
		 begin
			 PC4_E=PC4_D;
			 IR_E=IR_D;
			 RS_E=RD1_D;
			 RT_E=RD2_D;
			 imm_E=imm_D;
			 
			 RegDst_E=RegDst_D;
	       ALUOp_E=ALUOp_D;
	       MemWrite_E=MemWrite_D;
	       RegWrite_E=RegWrite_D;
	       ALUSrc_E=ALUSrc_D;
	       MemtoReg_E=MemtoReg_D;
		 end
	 end
	 


endmodule
