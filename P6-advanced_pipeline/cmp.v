`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module cmp(
    input [31:0] A,
    input [31:0] B,
	 output Equal,
	 output Larger,
	 output Less,
	 output Bez,
	 output Bgz,
	 output Blz
    );
	 
	 assign Equal=(A==B)?1:0;
	 assign Larger=(A>B)?1:0;
	 assign Less=(A<B)?1:0;
	 assign Bez=($signed(A)==0)?1:0;
	 assign Bgz=($signed(A)>0)?1:0;
	 assign Blz=($signed(A)<0)?1:0;

endmodule
