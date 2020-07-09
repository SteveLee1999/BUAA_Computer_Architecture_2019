`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module dm(
    input clk,
    input reset,
    input MemWrite,
	 input [5:0] opcode,
    input [11:0] Addr,
	 input [1:0] ALUOut,
    input [31:0] WD,
	 input [31:0] PC,
    output [31:0] RD
    );
	 
	 integer i=0;
	 reg [31:0] memory [0:4095];
	 initial
	 begin
	    for(i=0;i<4095;i=i+1)
		       memory[i]=0;
	 end
	 
	 assign RD=memory[Addr];
	 	 
	 always @(posedge clk)
	 begin
	    if(reset==1)
		    for(i=0;i<1024;i=i+1)
		       memory[i]=0;
		 		 
	    else if(MemWrite==1)
		 begin
		    case(opcode)
			    6'b101000://sb
			    begin
				    case(ALUOut)
					    0: memory[Addr][7:0]=WD[7:0];
						 1: memory[Addr][15:8]=WD[7:0];
						 2: memory[Addr][23:16]=WD[7:0];
						 3: memory[Addr][31:24]=WD[7:0];
					 endcase
				 end
				 
             6'b101001://sh
			    begin
				    case(ALUOut[1])
					    0: memory[Addr][15:0]=WD[15:0];
						 1: memory[Addr][31:16]=WD[15:0];
					 endcase
				 end
 			    
				 6'b101011://sw
			       memory[Addr]=WD;
			 endcase

			 $display("%d@%h: *%h <= %h", $time, PC, {{18{1'b0}},Addr,2'b00}, memory[Addr]);
		 end
	 end

endmodule
