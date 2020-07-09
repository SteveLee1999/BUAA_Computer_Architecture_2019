`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC_calculator(
    input [31:0] PC4,//PC+4
    input [3:0] PCOp,
    input [25:0] instr_index,//j,jal:ָ���26λ
	 input [31:0] rs,//jr,ȡ�ԼĴ�����ֵ
	 input [31:0] imm,//beq,������չΪ32λ�����������Ҫ����*4
    output reg [31:0] next_PC
    );
	 
	 always @(*)
	 begin
	    case(PCOp)
		    0://normal
			    next_PC<=PC4;
		    1://Branch��ת
			    next_PC<=PC4+imm*4;
			 2://Branch����ת�������ӳٲ�����+8��
			    next_PC<=PC4+4;
			 3://j,jal
			    next_PC<={PC4[31:28],instr_index,2'b00};
			 4://jr,jalr
			    next_PC<=rs;
	    endcase
	 end
	 
endmodule

