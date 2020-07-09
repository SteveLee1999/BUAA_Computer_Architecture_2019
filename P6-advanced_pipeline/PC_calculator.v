`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC_calculator(
    input [31:0] PC4,//PC+4
    input [3:0] PCOp,
    input [25:0] instr_index,//j,jal:指令后26位
	 input [31:0] rs,//jr,取自寄存器的值
	 input [31:0] imm,//beq,来自扩展为32位后的立即数，要首先*4
    output reg [31:0] next_PC
    );
	 
	 always @(*)
	 begin
	    case(PCOp)
		    0://normal
			    next_PC<=PC4;
		    1://Branch跳转
			    next_PC<=PC4+imm*4;
			 2://Branch不跳转（由于延迟槽所以+8）
			    next_PC<=PC4+4;
			 3://j,jal
			    next_PC<={PC4[31:28],instr_index,2'b00};
			 4://jr,jalr
			    next_PC<=rs;
	    endcase
	 end
	 
endmodule

