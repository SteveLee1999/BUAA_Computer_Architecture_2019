`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module E_pipe_reg(
    input clk,
    input reset,
	 input Stall,
	 input MD_Stall,
	 input [31:0] PC4_D,
	 input [31:0] IR_D,
    input [31:0] RD1_D,
    input [31:0] RD2_D,
    input [31:0] imm_D,
	 
	 input [1:0] RegDst_D,
	 input [4:0] ALUOp_D,
	 input [2:0] MDOp_D,
	 input MemWrite_D,
	 input RegWrite_D,
	 input ALUSrcA_D,
	 input ALUSrcB_D,
	 input [2:0] MemtoReg_D,
	 input startMD_D,
	 
    output reg [31:0] PC4_E,
	 output reg [31:0] IR_E,
    output reg [31:0] RS_E,
    output reg [31:0] RT_E,
    output reg [31:0] imm_E,
	 
	 output reg [1:0] RegDst_E,
	 output reg [4:0] ALUOp_E,
	 output reg [2:0] MDOp_E,
	 output reg MemWrite_E,
	 output reg RegWrite_E,
	 output reg ALUSrcA_E,
	 output reg ALUSrcB_E,
	 output reg [2:0] MemtoReg_E,
	 output reg startMD_E
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
		 MDOp_E=0;
	    MemWrite_E=0;
	    RegWrite_E=0;
	    ALUSrcA_E=0;
		 ALUSrcB_E=0;
	    MemtoReg_E=0;
		 startMD_E=0;
	 end
	 
	 always @(posedge clk)
	 begin
	    if(reset==1||Stall==1||MD_Stall==1) 
		 begin
			 PC4_E=0;
			 IR_E=0;
			 RS_E=0;
			 RT_E=0;
			 imm_E=0;
			 
			 RegDst_E=0;
	       ALUOp_E=0;
			 MDOp_E=0;
	       MemWrite_E=0;
	       RegWrite_E=0;
	       ALUSrcA_E=0;
		    ALUSrcB_E=0;
	       MemtoReg_E=0;
			 startMD_E=0;
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
			 MDOp_E=MDOp_D;
	       MemWrite_E=MemWrite_D;
	       RegWrite_E=RegWrite_D;
	       ALUSrcA_E=ALUSrcA_D;
		    ALUSrcB_E=ALUSrcB_D;
	       MemtoReg_E=MemtoReg_D;
			 startMD_E=startMD_D;
		 end
	 end
	 


endmodule
