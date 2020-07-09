`timescale 1ns / 1ps
module adder(
    input [3:0] A,
    input [3:0] B,
    input Clk,
    input En,
    output [3:0] Sum,
    output Overflow
    );
	 
	 reg [3:0] sum;
	 reg overflow;
	 
	 initial
	 begin
	    sum[0]=0;
		 sum[1]=0;
		 sum[2]=0;
		 sum[3]=0;
		 overflow=0;
	 end
    
	 assign Overflow=overflow;
	 assign Sum=sum;
	 
	 always @(posedge Clk)
	 begin
	    if(En)
		 begin
		    {overflow,sum}=A+B;
		 end
	 end
	 
endmodule

