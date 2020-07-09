`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module MultDiv(
    input clk,
    input reset,
	 input start,//启动乘除，只保持一个周期
    input [31:0] D1,
    input [31:0] D2,
    input [2:0] MDOp,
//0:mult  1:multu  2:div  3:divu  4:mthi  5:mtlo
    output Busy,
    output [31:0] HI,
    output [31:0] LO
    );
	 reg [31:0] d1,d2,hi,lo;
    reg [2:0] mdop;
	 reg busy;
	 integer state;
	 
	 assign Busy=busy;
	 assign HI=hi;
	 assign LO=lo;
	 
	 initial 
	 begin
	    d1<=0;
		 d2<=0;
		 hi<=0;
		 lo<=0;
		 mdop<=0;
		 busy<=0;
		 state=0;
	 end
	 
	 always @(posedge clk)
	 begin
	    if(reset)
		 begin
	       d1<=0;
			 d2<=0;
			 hi<=0;
		    lo<=0;
		    mdop<=0;
			 busy<=0;
		    state=0;
	    end
		 
		 else if(start==1&&state==0&&MDOp<=3)//state==0说明不忙
		 begin
			 d1=D1;
			 d2=D2;
			 mdop=MDOp;
			 busy<=1;
				 
			 if(MDOp==0||MDOp==1) state=5;
			 else if(MDOp==2||MDOp==3) state=10;
		 end
		 
		 else if(start==1&&state==0&&MDOp==4)
		    hi<=D1;
		 
		 else if(start==1&&state==0&&MDOp==5)
		    lo<=D1;
			 
		 else if(state>1)
		     state=state-1;
			 
		 else if(state==1)
		 begin
		    state=0;
			 busy<=0;
			 case(mdop)//最初存下的mdop
			    0: {hi,lo}<={{32{d1[31]}},d1}*{{32{d2[31]}},d2};
				 1: {hi,lo}<={{32{1'b0}},d1}*{{32{1'b0}},d2};
				 2: 
				    begin
					    lo<=$signed(d1)/$signed(d2);
						 hi<=$signed(d1)%$signed(d2);
					 end
			    3: 
				    begin
					    lo<=$unsigned(d1)/$unsigned(d2);
						 hi<=$unsigned(d1)%$unsigned(d2);
					 end					 
			 endcase
		 end
	 end
	 
endmodule
