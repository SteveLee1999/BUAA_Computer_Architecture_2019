`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC_calculator(
    input [31:0] PC4,//PC+4
    input [2:0] PCOp,
	 input equal,//beq,���Ĵ�����ֵ�Ƿ����
	 input Bgez,
    input [25:0] instr_index,//j,jal:ָ���26λ
	 input [31:0] rs,//jr,ȡ�ԼĴ�����ֵ
	 input [31:0] imm,//beq,������չΪ32λ�����������Ҫ����*4
    output reg [31:0] next_PC
    );
	 
	 always @(*)
	 begin
	    case(PCOp)
		    3'b000://R
			    next_PC<=PC4;
		    3'b001://beq
			    if(equal==1) next_PC<=PC4+imm*4;
				 else next_PC<=PC4+4;//PC+8!!(�ӳٲۣ�
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

