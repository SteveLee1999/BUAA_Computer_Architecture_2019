`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module dm(
    input clk,
    input reset,
    input MemWrite,
    input [9:0] Addr,//默认低两位为0
    input [31:0] WD,
	 input [31:0] PC,
    output [31:0] RD
    );
	 integer i=0;
	 reg [31:0] memory [0:1023];
	 initial
	 begin
	    for(i=0;i<1024;i=i+1)
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
		    $display("%d@%h: *%h <= %h", $time, PC, {{20{1'b0}},Addr,2'b00}, WD);
		    memory[Addr]<=WD;
		 end
	 end

endmodule
