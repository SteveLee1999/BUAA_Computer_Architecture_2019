`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mux32_4(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
	 input [1:0] select,
	 output [31:0] out
    );
	 
	 reg [31:0] Out;
	 
	 initial
	 begin
	    Out<=0;
	 end
	 
	 assign out=Out;
	 
	 always @(*)
	 begin
	    case(select)
		    2'b00:
			    Out<=in0;
			 2'b01:
			    Out<=in1;
			 2'b10:
			    Out<=in2;
			 2'b11:
			    Out<=in3;
	    endcase
	 end
endmodule



module mux5_4(
    input [4:0] in0,
    input [4:0] in1,
    input [4:0] in2,
    input [4:0] in3,
	 input [1:0] select,
	 output [4:0] out
    );
	 
	 reg [4:0] Out;
	 
	 initial
	 begin
	    Out<=in0;
	 end
	 
	 assign out=Out;
	 
	 always @(*)
	 begin
	    case(select)
		    2'b00:
			    Out<=in0;
			 2'b01:
			    Out<=in1;
			 2'b10:
			    Out<=in2;
			 2'b11:
			    Out<=in3;
	    endcase
	 end
endmodule




module mux32_2(
    input [31:0] in0,
    input [31:0] in1,
	 input select,
	 output [31:0] out
    );
	 
	 reg [31:0] Out;
	 
	 initial
	 begin
	    Out<=in0;
	 end
	 
	 assign out=Out;
	 
	 always @(*)
	 begin
	    case(select)
		    0:
			    Out<=in0;
			 1:
			    Out<=in1;
	    endcase
	 end
endmodule
