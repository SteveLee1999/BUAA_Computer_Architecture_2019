`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module grf(
    input clk,
    input reset,	 
	 input RegWrite,//дʹ���ź�
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
	    for(i=0;i<32;i=i+1)//������дi++
		    Reg[i]=0;
	 end
	 assign RD1=((RA1==WA)&&(RA1!=0)&&(RegWrite==1))?WD:Reg[RA1];
	 assign RD2=((RA2==WA)&&(RA2!=0)&&(RegWrite==1))?WD:Reg[RA2];
	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
	       for(i=0;i<32;i=i+1)
		       Reg[i]=0;
		 
		 else if(RegWrite==1)
		 begin
		    $display("%d@%h: $%d <= %h", $time, WPC, WA, WD);
			 if(WA!=5'b00000) Reg[WA]<=WD;	    
		 end
	 end
	 
endmodule
