`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC_calculator(
    input [31:0] PC4,//PC+4
    input [2:0] PCOp,
	 input equal,//beq,两寄存器中值是否相等
	 input Bgez,
    input [25:0] instr_index,//j,jal:指令后26位
	 input [31:0] rs,//jr,取自寄存器的值
	 input [31:0] imm,//beq,来自扩展为32位后的立即数，要首先*4
    output reg [31:0] next_PC
    );
	 
	 always @(*)
	 begin
	    case(PCOp)
		    3'b000://R
			    next_PC<=PC4;
		    3'b001://beq
			    if(equal==1) next_PC<=PC4+imm*4;
				 else next_PC<=PC4+4;//PC+8!!(延迟槽）
			 3'b010://jal
			    next_PC<={PC4[31:28],instr_index,2'b00};
			 3'b011://jr
			    next_PC<=rs;
			 3'b100://bgezal
			    if(Bgez==1) next_PC<=PC4+imm*4;
				 else next_PC<=PC4+4;
	    endcase
	 end
	 
endmodule

