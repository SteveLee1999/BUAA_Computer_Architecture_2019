`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC(
    input clk,
    input reset,
    input [31:0] next_PC,
	 input Stall,//Stall=1‘ÚPCÕ£÷Õ
	 input MD_Stall,
    output reg [31:0] PC
    );
	 
	 initial
	 begin
	    PC=32'h00003000;
	 end
	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
		    PC<=32'h00003000;
		 else if(Stall!=1&&MD_Stall!=1)
		    PC<=next_PC;
	 end

endmodule
