`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module W_pipe_reg(
    input clk,
    input reset,
    input [31:0] PC4_M,
	 input [31:0] IR_M,
    input [31:0] ALUOut_M,
	 input [31:0] imm_M,
    input [31:0] RD,//DM¶Á³ö½á¹û
	 input [4:0] WA_M,
	 input [31:0] HI_M,
	 input [31:0] LO_M,
	 
	 input RegWrite_M,
	 input [2:0] MemtoReg_M,
	 
    output reg [31:0] PC4_W,
	 output reg [31:0] IR_W,
    output reg [31:0] ALUOut_W,
	 output reg [31:0] imm_W,
    output reg [31:0] DR_W,
	 output reg [4:0] WA_W,
	 output reg [31:0] HI_W,
	 output reg [31:0] LO_W,
	 
	 output reg RegWrite_W,
	 output reg [2:0] MemtoReg_W
    );
	 
	 initial
	 begin
		    IR_W=0;
			 PC4_W=32'h00003000;
			 ALUOut_W=0;
			 imm_W=0;
			 DR_W=0;
			 WA_W=0;
			 HI_W=0;
			 LO_W=0;
			 
			 RegWrite_W=0;
			 MemtoReg_W=0;
		 end
	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
		 begin
		    IR_W=0;
			 PC4_W=0;
			 ALUOut_W=0;
			 imm_W=0;
			 DR_W=0;
			 WA_W=0;
			 HI_W=0;
			 LO_W=0;
			 
			 RegWrite_W=0;
			 MemtoReg_W=0;
		 end
		 
		 else
		 begin
		    IR_W=IR_M;
			 PC4_W=PC4_M;
			 ALUOut_W=ALUOut_M;
			 imm_W=imm_M;
			 DR_W=RD;
			 WA_W=WA_M;
			 HI_W=HI_M;
			 LO_W=LO_M;
			 
			 RegWrite_W=RegWrite_M;
			 MemtoReg_W=MemtoReg_M;
		 end
	 end

endmodule
