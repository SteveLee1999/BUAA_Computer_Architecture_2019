`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output [31:0] C
    );
	 
	 reg [31:0] c;
	 integer i,temp;
	 	 
	 initial
	 begin
	    c=0;
	 end
	 
	 assign C=c;//always,initial块中只能给寄存器赋值
	 
	 always @(*)//always语句的作用是使得ALUOp可以成为判断信号
	 begin
	    case(ALUOp)
	       3'b000: c=A+B;
		    3'b001: c=A-B;
		    3'b010: c=A&B;
		    3'b011: c=A|B;
		    3'b100: c=B>>{{27{1'b0}},A[4:0]};//注意！！这里顺序设置是由于移位指令格式较特殊，是rt>>rs
		    3'b101: c=$signed(B)>>>{{27{1'b0}},A[4:0]};
			 3'b110: 
			 begin
			    for(i=31,temp=32;i>=0;i=i-1)//没有break语句......
				 begin
				    if(A[i]==1&&temp==32)   temp=31-i;
				 end
				 c=temp;
			 end
			 default:c=c;
	    endcase
	 end
	 
endmodule
