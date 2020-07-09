`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module im(
    input [31:0] PC,
    output [31:0] instr
    );
	 wire [31:0] addr;
	 reg [31:0] instr_memory [4095:0];
	 
	 assign addr=PC-32'h00003000;
	 
	 initial
	 begin
	    $readmemh("code.txt",instr_memory);
	 end
	 
	 assign instr=instr_memory[addr[13:2]];
	 
endmodule
