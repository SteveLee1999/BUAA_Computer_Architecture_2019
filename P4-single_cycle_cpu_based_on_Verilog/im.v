`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module im(
    input [9:0] addr,
    output [31:0] instr
    );
	 
	 reg [31:0] instr_memory [0:1023];
	 initial
	 begin
	    $readmemh("code.txt",instr_memory);
	 end
	 
	 assign instr=instr_memory[addr];
	 
endmodule
