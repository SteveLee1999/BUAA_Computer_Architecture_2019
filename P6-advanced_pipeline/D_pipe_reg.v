`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module D_pipe_reg(
    input clk,
    input reset,
	 input Stall,
	 input MD_Stall,
    input [31:0] IR_F,
    input [31:0] PC4_F, 
    output reg [31:0] IR_D,
    output reg [31:0] PC4_D
    );
	 
	 initial
	 begin
	    IR_D=0;
		 PC4_D=0;
	 end
	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
       begin
		    IR_D=0;
		    PC4_D=32'h00003000;
		 end
		 
		 else if(Stall!==1&&MD_Stall!==1)
		 begin
		    IR_D=IR_F;
		    PC4_D=PC4_F;
		 end
	 end

endmodule
