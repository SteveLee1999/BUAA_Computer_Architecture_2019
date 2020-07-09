`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module dmout_ext(
    input [1:0] ALUOut,
    input [31:0] dmout,
    input [5:0] opcode,
    output reg [31:0] result
    );
	 
	 always @(*)
	 begin
	    case(opcode)
		    6'b100000://lb
			    case(ALUOut)
				 0: result={{24{dmout[7]}},dmout[7:0]};
				 1: result={{24{dmout[15]}},dmout[15:8]};
				 2: result={{24{dmout[23]}},dmout[23:16]};
				 3: result={{24{dmout[31]}},dmout[31:24]};
				 endcase
			 6'b100001://lh
			    case(ALUOut[1])
				 0: result={{16{dmout[15]}},dmout[15:0]};
				 1: result={{16{dmout[31]}},dmout[31:16]};
				 endcase
			 6'b100011://lw
			    result=dmout;
			 6'b100100://lbu
			    case(ALUOut)
				 0: result={24'b000000000000000000000000,dmout[7:0]};
				 1: result={24'b000000000000000000000000,dmout[15:8]};
				 2: result={24'b000000000000000000000000,dmout[23:16]};
				 3: result={24'b000000000000000000000000,dmout[31:24]};
				 endcase
			 6'b100101://lhu
			    case(ALUOut[1])
				 0: result={24'b000000000000000000000000,dmout[15:0]};
				 1: result={24'b000000000000000000000000,dmout[31:16]};
				 endcase
		 endcase
	 end


endmodule
