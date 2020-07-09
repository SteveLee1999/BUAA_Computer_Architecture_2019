module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext
    );
	 
	 reg [31:0] Ext;
	 
	 assign ext=Ext;
	 
	 initial
	 begin
	    Ext=32'b00000000000000000000000000000000;
	 end
	 
	 always @(*)
	 begin
	    case(EOp)
		    2'b00:
			    Ext<={{16{imm[15]}},imm};
			 2'b01:
			    Ext<={16'b0000000000000000,imm};
			 2'b10:
			    Ext<={imm,16'b0000000000000000};
			 2'b11:
			    begin
				    Ext<={{16{imm[15]}},imm};
					 Ext<=Ext<<2; 
				 end
		 endcase
	 end
	 
endmodule
