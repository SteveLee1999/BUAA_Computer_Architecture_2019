`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext_imm
    );
	 
	 
	 reg [31:0] Ext_imm;
	 
	 assign ext_imm=Ext_imm;
	 
	 initial
	 begin
	    Ext_imm=32'b00000000000000000000000000000000;
	 end
	 
	 always @(*)
	 begin
	    case(EOp)
		    2'b00:
			    Ext_imm<={{16{imm[15]}},imm};
			 2'b01:
			    Ext_imm<={16'b0000000000000000,imm};
			 2'b10:
			    Ext_imm<={imm,16'b0000000000000000};
			 2'b11:
			    begin
				    Ext_imm<={{16{imm[15]}},imm};
					 Ext_imm<=Ext_imm<<2; 
				 end
		 endcase
	 end
	
endmodule
