`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input clk,
    input reset
    );
	 wire [31:0] PC;
	 wire [31:0] next_PC;
	 wire [31:0] instr;
	 
	 wire [1:0] RegDst;
	 wire [1:0] PCOp;
	 wire [2:0] ALUOp;
	 wire [1:0] EXTOp;
	 wire MemWrite;
	 wire RegWrite;
	 wire ALUSrc;
	 wire [1:0] MemtoReg;
	 
	 wire Equal;//ALU输出
	 wire [31:0] imm;//扩展之后的立即数
	 wire [4:0] WA;//RegDst选择的结果
	 wire [31:0] WD;//MemtoReg选择的结果
	 wire [31:0] RD2;
	 wire [31:0] A;
	 wire [31:0] B;
	 wire [31:0] ALUOut;
	 wire [31:0] MemRD;
	 wire [31:0] PC_plus_four;
	 
	 PC M1(clk,reset,next_PC,PC);
	 im M2(PC[11:2],instr);
	 controller M3(instr[31:26],instr[5:0],RegDst,PCOp,ALUOp,EXTOp,MemWrite,RegWrite,ALUSrc,MemtoReg);
	 PC_calculator M4(PC,PCOp,Equal,instr[25:0],A,imm,PC_plus_four,next_PC);
	 ext M5(instr[15:0],EXTOp,imm);
	 mux5_4 M6(instr[20:16],instr[15:11],5'b11111,5'b00000,RegDst,WA);//不可能出现"11"情况
	 grf M7(clk,reset,RegWrite,instr[25:21],instr[20:16],WA,WD,PC,A,RD2);
	 mux32_2 M8(RD2,imm,ALUSrc,B);
	 alu M9(A,B,ALUOp,ALUOut,Equal);
	 dm M10(clk,reset,MemWrite,ALUOut[11:2],RD2,PC,MemRD);//取32位数的11-2
	 mux32_4 M12(MemRD,ALUOut,imm,PC_plus_four,MemtoReg,WD);
	 
endmodule
