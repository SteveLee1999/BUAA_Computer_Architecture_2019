`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output [31:0] C,
	 output Equal//�ж�A��B�Ƿ����
    );
	 
	 reg [31:0] c;
	 reg equal;
	 
	 initial
	 begin
	    c=0;
		 equal=0;
	 end
	 
	 assign C=c;//always,initial����ֻ�ܸ��Ĵ�����ֵ
	 assign Equal=equal;
	 
	 always @(*)//always����������ʹ��ALUOp���Գ�Ϊ�ж��ź�
	 begin
	    if(A==B) equal=1;
		 else equal=0;
		 
	    case(ALUOp)
	       3'b000: c=A+B;
		    3'b001: c=A-B;
		    3'b010: c=A&B;
		    3'b011: c=A|B;
		    3'b100: c=A>>B;
		    3'b101: c=$signed(A)>>>B;
			 default:c=c;
	    endcase
	 end
	 
endmodule
