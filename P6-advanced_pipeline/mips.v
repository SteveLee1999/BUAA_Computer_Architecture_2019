`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input clk,
    input reset,
	 
	 output Stall,//数据冲突阻塞
	 output MD_Stall,//乘除法阻塞
	 
	 //F级	 
	 output [31:0] PC_F,
	 output [31:0] PC4_F,
	 output [31:0] next_PC_F,
	 output [31:0] instr_F,

	 
	 //D级 
	 output [31:0] PC4_D,
	 output [31:0] instr_D,
	 output [31:0] imm_D,
	 output [31:0] RS_D,
	 output [31:0] RT_D,
	 output [31:0] next_PC_D,
	 
	 output [3:0] PCOp_D,
	 output [1:0] EXTOp_D,
	 output [1:0] RegDst_D,
	 output [4:0] ALUOp_D,
	 output [2:0] MDOp_D,
	 output ALUSrcA_D,
	 output ALUSrcB_D,
	 output MemWrite_D,
	 output RegWrite_D,
	 output [2:0] MemtoReg_D,
	 output startMD_D,
	 
	 output [31:0] RD1,
	 output [31:0] RD2,
	 output Equal,
	 output Larger,
	 output Less,
	 output Bez,
	 output Bgz,
	 output Blz,
	 
	 
	 //E级
	 output [31:0] PC4_E,
	 output [31:0] imm_E,
	 output [31:0] instr_E,
	 output [31:0] RS_E,
	 output [31:0] RT_E,
	 output [31:0] ALUOut_E,
	 output [4:0] WA_E,
	 output [31:0] HI_E,
	 output [31:0] LO_E,
	 
	 output [1:0] RegDst_E,
	 output [4:0] ALUOp_E,
	 output [2:0] MDOp_E,
	 output ALUSrcA_E,
	 output ALUSrcB_E,
	 output MemWrite_E,
	 output RegWrite_E,
	 output [2:0] MemtoReg_E,
	 output startMD_E,
	 
	 output [31:0] a,
	 output [31:0] b,
	 output [31:0] A,
	 output [31:0] B,
	 output Busy,
	 
	 
	 //M级
	 output [31:0] PC4_M,
	 output [31:0] instr_M,
	 output [31:0] RT_M,
	 output [31:0] ALUOut_M,
	 output [31:0] imm_M,
	 output [31:0] WD_M,
	 output [31:0] RD_M,//存储器读出：RD
	 output [4:0] WA_M,
	 output [31:0] HI_M,
	 output [31:0] LO_M,
	 
	 output MemWrite_M,
	 output RegWrite_M,
	 output [2:0] MemtoReg_M,
	 output [31:0] RD,
	
	
	 //W级
	 output [31:0] PC4_W,
	 output [31:0] instr_W,
	 output [31:0] ALUOut_W,
	 output [31:0] imm_W,
	 output [31:0] RD_W,
	 output [31:0] WD_W,
	 output [4:0] WA_W,
	 output [31:0] HI_W,
	 output [31:0] LO_W,
	 
	 output RegWrite_W,
	 output [2:0] MemtoReg_W,
	 
	 
	 //Forward
	 output [2:0] ForwardRS_D,
	 output [2:0] ForwardRT_D,
	 output [2:0] ForwardRS_E,
	 output [2:0] ForwardRT_E,
	 output [2:0] ForwardRT_M
    );
    	 
	 
	 //F级	 
	 PC M1(clk,reset,next_PC_F,Stall,MD_Stall,PC_F);
	 im M2(PC_F,instr_F);
	 assign PC4_F=PC_F+4;
	 assign next_PC_F=(PCOp_D===1||PCOp_D===2||PCOp_D===3||PCOp_D===4)?next_PC_D:PC4_F;//跳转指令记得在这里加一下！！！
	 
	 //D级
	 D_pipe_reg MD(clk,reset,Stall,MD_Stall,
	               instr_F,PC4_F,
						instr_D,PC4_D);
	 controller M3(instr_D[31:26],instr_D[5:0],instr_D[20:16],
	               Equal,Larger,Less,Bez,Bgz,Blz,
						RegDst_D,PCOp_D,ALUOp_D,MDOp_D,EXTOp_D,MemWrite_D,RegWrite_D,ALUSrcA_D,ALUSrcB_D,MemtoReg_D,startMD_D);
	 ext M4(instr_D[15:0],EXTOp_D,imm_D);
	 grf M5(clk,reset,RegWrite_W,instr_D[25:21],instr_D[20:16],WA_W,WD_W,PC4_W-4,RD1,RD2);
	 mux32_8 MF_RS_D(RD1,ALUOut_M,PC4_M+4,PC4_E+4,imm_M,imm_E,HI_M,LO_M,ForwardRS_D,RS_D);
	 mux32_8 MF_RT_D(RD2,ALUOut_M,PC4_M+4,PC4_E+4,imm_M,imm_E,HI_M,LO_M,ForwardRT_D,RT_D);
	 cmp M6(RS_D,RT_D,Equal,Larger,Less,Bez,Bgz,Blz);
	 PC_calculator M7(PC4_D,PCOp_D,instr_D[25:0],RS_D,imm_D,next_PC_D);
	 
	 //E级
	 E_pipe_reg ME(clk,reset,Stall,MD_Stall,
	               PC4_D,instr_D,RS_D,RT_D,imm_D,
						RegDst_D,ALUOp_D,MDOp_D,MemWrite_D,RegWrite_D,ALUSrcA_D,ALUSrcB_D,MemtoReg_D,startMD_D,
						PC4_E,instr_E,RS_E,RT_E,imm_E,
						RegDst_E,ALUOp_E,MDOp_E,MemWrite_E,RegWrite_E,ALUSrcA_E,ALUSrcB_E,MemtoReg_E,startMD_E);
	 mux5_4 M8(instr_E[20:16],instr_E[15:11],5'b11111,5'b00000,RegDst_E,WA_E);
	 mux32_8 MF_RS_E(RS_E,ALUOut_M,PC4_M+4,imm_M,WD_W,HI_M,LO_M,0,ForwardRS_E,a);
	 mux32_8 MF_RT_E(RT_E,ALUOut_M,PC4_M+4,imm_M,WD_W,HI_M,LO_M,0,ForwardRT_E,b);
	 mux32_2 M9(a,{{27'b0},instr_E[10:6]},ALUSrcA_E,A);//sll
	 mux32_2 M10(b,imm_E,ALUSrcB_E,B);
	 alu M11(A,B,ALUOp_E,ALUOut_E);
	 MultDiv M12(clk,reset,startMD_E,A,B,MDOp_E,Busy,HI_E,LO_E);
	 
	 //M级
	 M_pipe_reg MM(clk,reset,
	               PC4_E,instr_E,b,ALUOut_E,imm_E,WA_E,HI_E,LO_E,//这里应该是b，而非RT_E
						MemWrite_E,RegWrite_E,MemtoReg_E,
						PC4_M,instr_M,RT_M,ALUOut_M,imm_M,WA_M,HI_M,LO_M,
						MemWrite_M,RegWrite_M,MemtoReg_M);
	 mux32_8 MF_RT_M(RT_M,WD_W,HI_W,LO_W,0,0,0,0,ForwardRT_M,WD_M);
	 dm M14(clk,reset,MemWrite_M,instr_M[31:26],ALUOut_M[13:2],ALUOut_M[1:0],WD_M,PC4_M-4,RD_M);	 
	 
	 //W级
	 W_pipe_reg MW(clk,reset,
	               PC4_M,instr_M,ALUOut_M,imm_M,RD_M,WA_M,HI_M,LO_M,
						RegWrite_M,MemtoReg_M,
						PC4_W,instr_W,ALUOut_W,imm_W,RD_W,WA_W,HI_W,LO_W,
						RegWrite_W,MemtoReg_W);
	 dmout_ext M15(ALUOut_W[1:0],RD_W,instr_W[31:26],RD);
	 mux32_8 M16(RD,ALUOut_W,imm_W,PC4_W+4,HI_W,LO_W,0,0,MemtoReg_W,WD_W);//由于延迟槽,应该是PC+8！
	 
	 hazard M17(instr_D,instr_E,instr_M,instr_W,
	            RegWrite_D,RegWrite_E,RegWrite_M,RegWrite_W,
					startMD_E,Busy,
	            Stall,MD_Stall,
					ForwardRS_D,ForwardRT_D,ForwardRS_E,ForwardRT_E,ForwardRT_M);

	  	 
endmodule
