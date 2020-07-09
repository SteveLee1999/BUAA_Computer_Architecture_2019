`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module alu(
    input [31:0] A,
    input [31:0] B,
    input [4:0] ALUOp,
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
	       0: c=A+B;
			 1: c=$signed(A)+$signed(B);
		    2: c=A-B;
			 3: c=$signed(A)-$signed(B);
		    4: c=A&B;
		    5: c=A|B;
			 6: c=(A&~B)|(~A&B);//xor
			 7: c=~A&~B;//nor
		    8: c=B<<{{27{1'b0}},A[4:0]};//sll,sllv
		    9: c=B>>{{27{1'b0}},A[4:0]};//srl,srlv
			10: c=$signed(B)>>>{{27{1'b0}},A[4:0]};//sra,srav
			11://clz
			    begin
			       for(i=31,temp=32;i>=0;i=i-1)//没有break语句......
				    begin
				       if(A[i]==1&&temp==32)   temp=31-i;
				    end
				    c=temp;
			    end
		   12://slt,slti 
             begin
				    if($signed(A)<$signed(B)) c=1;
					 else c=0;
             end
         13://sltu,sltiu
             begin
				    if(A<B) c=1;
					 else c=0;
             end	
         default:c=c;				 
	    endcase
	 end
	 
endmodule
