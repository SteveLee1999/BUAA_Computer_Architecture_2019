`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );
	 
	 reg [2:0] out;
	 reg overflow;
	 
	 assign Overflow=overflow;
	 assign Output=out;
	 
	 initial
	 begin
	    out=3'b000;
		 overflow=0;
    end
	 
	 always @(posedge Clk)
	 begin
		 if(Reset==1) //Í¬²½¸´Î»
		 begin
		    out=3'b000;
		    overflow=0;
		 end
		 
		 else if(En==1) 
		 begin
		    case(out)
			    3'b000: out<=3'b001;
				 3'b001: out<=3'b011;
				 3'b011: out<=3'b010;
				 3'b010: out<=3'b110;
				 3'b110: out<=3'b111;
				 3'b111: out<=3'b101;
				 3'b101: out<=3'b100;
				 3'b100: 
				         begin
							out<=3'b000;
							overflow<=1;
							end
			 endcase
		 end
	 end

endmodule

