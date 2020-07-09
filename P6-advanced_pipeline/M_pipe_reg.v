`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module M_pipe_reg(
    input clk,
    input reset,
    input [31:0] PC4_E,
	 input [31:0] IR_E,
    input [31:0] RT_E,
	 input [31:0] ALUOut_E,
	 input [31:0] imm_E,
	 input [4:0] WA_E,
	 input [31:0] HI_E,
	 input [31:0] LO_E,
	 
	 input MemWrite_E,
	 input RegWrite_E,
	 input [2:0] MemtoReg_E,
	 
	 output reg [31:0] PC4_M,
	 output reg [31:0] IR_M,
	 output reg [31:0] RT_M,
	 output reg [31:0] ALUOut_M,
	 output reg [31:0] imm_M,
	 output reg [4:0] WA_M,
	 output reg [31:0] HI_M,
	 output reg [31:0] LO_M,
	 
	 output reg MemWrite_M,
	 output reg RegWrite_M,
	 output reg [2:0] MemtoReg_M
    );
	 
	 initial
	 begin
			 PC4_M=32'h00003000;
			 IR_M=0;
			 RT_M=0;
			 ALUOut_M=0;
			 imm_M=0;
			 WA_M=0;
			 HI_M=0;
			 LO_M=0;
			 
			 MemWrite_M=0;
	       RegWrite_M=0;
	       MemtoReg_M=0;
		 end
	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
		 begin
			 PC4_M=0;
			 IR_M=0;
			 RT_M=0;
			 ALUOut_M=0;
			 imm_M=0;
			 WA_M=0;
			 HI_M=0;
			 LO_M=0;
			 
			 MemWrite_M=0;
	       RegWrite_M=0;
	       MemtoReg_M=0;
		 end
		 
		 else
		 begin
			 PC4_M=PC4_E;
			 IR_M=IR_E;
			 RT_M=RT_E;
			 ALUOut_M=ALUOut_E;
			 imm_M=imm_E;
			 WA_M=WA_E;
			 HI_M=HI_E;
			 LO_M=LO_E;
			 
			 MemWrite_M=MemWrite_E;
	       RegWrite_M=RegWrite_E;
	       MemtoReg_M=MemtoReg_E;
		 end
	 end

endmodule
