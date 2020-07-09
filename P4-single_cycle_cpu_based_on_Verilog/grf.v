`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module grf(
    input clk,
    input reset,	 
	 input RegWrite,//写使能信号
    input [4:0] RA1,
    input [4:0] RA2,
    input [4:0] WA,
    input [31:0] WD,
	 input [31:0] WPC,
    output [31:0] RD1,
    output [31:0] RD2
    );
	 
	 reg [31:0] Reg [0:31];
	 integer i=0;
	 
	 initial
	 begin
	    for(i=0;i<32;i=i+1)//不可以写i++
		    Reg[i]=0;
	 end
	 assign RD1=Reg[RA1];
	 assign RD2=Reg[RA2];
	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
	       for(i=0;i<32;i=i+1)
		       Reg[i]=0;
		 
		 else if(RegWrite==1)
		 begin
		    $display("@%h: $%d <= %h", WPC, WA, WD);
			 if(WA!=5'b00000) Reg[WA]<=WD;	    
		 end
	 end
	 
endmodule
