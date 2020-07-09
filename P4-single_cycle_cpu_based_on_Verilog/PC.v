`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC(
    input clk,
    input reset,
    input [31:0] next_PC,
    output [31:0] PC
    );
	 
	 reg [31:0] pc;
	 
	 initial
	 begin
	    pc=32'h00003000;
	 end
	 
	 assign PC=pc;
	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
		    pc<=32'h00003000;
		 else
		    pc<=next_PC;
	 end

endmodule
