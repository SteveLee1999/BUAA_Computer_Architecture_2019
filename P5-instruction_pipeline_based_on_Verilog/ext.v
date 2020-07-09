`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ext(
    input [15:0] imm,
    input [1:0] EXTOp,
    output reg [31:0] Ext_imm
    );
	 
	 always @(*)
	 begin
	    case(EXTOp)
		    2'b00://符号扩展
			    Ext_imm<={{16{imm[15]}},imm};
			 2'b01://高位补0
			    Ext_imm<={16'b0000000000000000,imm};
			 2'b10://加载到高位，低位补0
			    Ext_imm<={imm,16'b0000000000000000};
			 2'b11:
			    begin
				    Ext_imm<={{16{imm[15]}},imm};
					 Ext_imm<=Ext_imm<<2; 
				 end
		 endcase
	 end
	
endmodule
