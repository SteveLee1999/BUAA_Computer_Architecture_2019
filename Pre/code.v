`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module code(
    input Clk,
    input Reset,
    input Slt,
    input En,
    output [63:0] Output0,
    output [63:0] Output1
    );
	 
	 integer i;//i统计Output1的有效时钟周期
	 reg [63:0] output0;
	 reg [63:0] output1;
	 
	 initial
	 begin
	    i=0;
	 end
	 
	 assign Output0=output0;
	 assign Output1=output1;
	 
	 always @(posedge Clk)
	 begin
	    if(Reset==1)
       begin
		    output0<=0;
			 output1<=0;
			 i<=0;
       end
		 
		 else if(En==1&&Slt==0)
		 begin
		    output0<=output0+1;
		 end
		 
		 else if(En==1&&Slt==1)
		 begin
		    i<=i+1;
			 if(i%4==3) output1<=output1+1;
		 end      		 
	 end

endmodule
