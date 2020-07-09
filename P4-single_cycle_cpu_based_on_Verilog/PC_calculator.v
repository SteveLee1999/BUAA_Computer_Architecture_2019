`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC_calculator(
    input [31:0] PC,
    input [1:0] PCOp,
	 input equal,//beq,两寄存器中值是否相等
    input [25:0] instr_index,//jal,指令后26位
	 input [31:0] rs,//jr,取自寄存器的值
	 input [31:0] imm,//beq,来自扩展为32位后的立即数，要首先*4
	 output [31:0] PC_plus_four,
    output [31:0] next_PC
    );
	 reg [31:0] next_pc;
	 
	 assign next_PC=next_pc;
	 assign PC_plus_four=PC+4;
	 
	 always @(*)
	 begin
	    case(PCOp)
		    2'b00://R
			    next_pc<=PC+4;
		    2'b01://beq
			    if(equal==1) next_pc<=PC+4+imm*4;
				 else next_pc<=PC+4;
			 2'b10://jal
			    next_pc<={PC[31:28],instr_index,2'b00};
			 2'b11://jr
			    next_pc<=rs;
	    endcase
	 end
	 
endmodule

