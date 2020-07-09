`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module controller(
    input [5:0] opcode,
    input [5:0] funct,
	 input [4:0] rt,
	 input Equal,
	 input Larger,
	 input Less,
	 input Bez,
	 input Bgz,
	 input Blz,
	 output reg [1:0] RegDst,//选择寄存器写入地址
	 output reg [3:0] PCOp,//下一条PC
	 output reg [4:0] ALUOp,//ALU方式
	 output reg [2:0] MDOp,//乘法方式
	 output reg [1:0] EXTOp,//符号扩展方式
	 output reg MemWrite,//存储器写使能
	 output reg RegWrite,//寄存器写使能
	 output reg ALUSrcA,//选择ALU或乘法的第一个运算数
	 output reg ALUSrcB,//选择ALU或乘法的第二个运算数
	 output reg [2:0] MemtoReg,//选择寄存器写入数据
	 output reg startMD//乘法模块使能
    );
	 
	 always @(*)//不需要关心的也赋值为0
	 begin
	    if(opcode[5]===1'bx)
		 begin
		    RegDst=0;
			 PCOp=0;
			 ALUOp=0;
			 MDOp=0;
			 EXTOp=0;
			 MemWrite=0;
			 RegWrite=0;
			 ALUSrcA=0;
			 ALUSrcB=0;
			 MemtoReg=0;
			 startMD=0;
		 end
		 
	    else if(opcode==6'b000000)
		 begin
		    case(funct)				 
				 6'b100000://add
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=1;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
			    6'b100001://addu
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b100010://sub
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=3;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b100011://subu
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=2;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b100100://and
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=4;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b100101://or
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=5;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b100110://xor
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=6;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b100111://nor
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=7;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b000100://sllv
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=8;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b000110://srlv
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=9;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b000111://srav
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=10;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b000000://sll
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=8;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=1;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 			 
				 6'b000010://srl
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=9;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=1;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 				 
				 6'b000011://sra
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=10;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=1;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b011000://mult
				 begin
					 PCOp=0;
					 MDOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 startMD=1;
				 end
				 
				 6'b011001://multu
				 begin
				    PCOp=0;
					 MDOp=1;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 startMD=1;
				 end
				 
				 6'b011010://div
				 begin
				    PCOp=0;
					 MDOp=2;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 startMD=1;
				 end
				 
				 6'b011011://divu
				 begin
				    PCOp=0;
					 MDOp=3;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 startMD=1;
				 end
				 
				 6'b010001://mthi
				 begin
					 PCOp=0;
					 MDOp=4;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrcA=0;
					 startMD=1;
				 end
				 
				 6'b010011://mtlo
				 begin
				    PCOp=0;
					 MDOp=5;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrcA=0;
					 startMD=1;
				 end
				 
				 6'b010000://mfhi
				 begin
				    RegDst=1;
					 PCOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 MemtoReg=4;
					 startMD=0;//只要start=0,就不会随便在乘除器里面运算
				 end
				 
				 6'b010010://mflo
				 begin
				    RegDst=1;
					 PCOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 MemtoReg=5;
					 startMD=0;
				 end	
             
             6'b101010://slt
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=12;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b101011://sltu
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=13;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 				 
				 6'b001000://jr
				 begin
					 PCOp=4;
					 MemWrite=0;
					 RegWrite=0;
					 startMD=0;
				 end
				 
				 6'b001001://jalr
				 begin
				    RegDst=1;
					 PCOp=4;
					 MemWrite=0;
					 RegWrite=1;
					 MemtoReg=3;
					 startMD=0;
				 end
				 
				 default:
				 begin
					 PCOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 MemtoReg=0;
					 startMD=0;
				 end    
			 endcase
		 end
		 
		 else
		 begin
		    case(opcode)			 
				 6'b001000://addi
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=1;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b001001://addiu
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b001100://andi
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=4;
					 EXTOp=1;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=1;
					 startMD=0;
				 end
				 				 
				 6'b001101://ori
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=5;
					 EXTOp=1;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b001110://xori
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=6;
					 EXTOp=1;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b000100://beq
				 begin
				    if(Equal) PCOp=1;
					 else PCOp=2;//注意条件不跳转是PC+8
					 
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 startMD=0;
				 end
				 
				 6'b000101://bne
				 begin
				    if(!Equal) PCOp=1;
					 else PCOp=2;
					 
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 startMD=0;
				 end
				 
				 6'b000110://blez
				 begin
				    if(Blz||Bez) PCOp=1;
					 else PCOp=2;

					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 startMD=0;
				 end
				 
				 6'b000111://bgtz
				 begin
				    if(Bgz) PCOp=1;
					 else PCOp=2;

					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 startMD=0;
				 end
				 
				 6'b000001:
				 begin
				    if(rt==5'b10001)//bgezal
					 begin
					    if(Bgz||Bez)
						 begin
						    PCOp=1; 
                      RegWrite=1;							 
						 end
						 
						 else
						 begin
						    PCOp=2; 
                      RegWrite=0;							 
						 end
                    
                   RegDst=2;
						 EXTOp=0;
						 MemWrite=0;						 
						 MemtoReg=3;
						 startMD=0;						  				       
					 end
					 
					 else if(rt==5'b00000)//bltz
					 begin
				       if(Blz) PCOp=1;
					    else PCOp=2;

					    EXTOp=0;
						 MemWrite=0;
						 RegWrite=0;
						 startMD=0;
				    end
					 
					 else if(rt==5'b00001)//bgez
					 begin
				       if(Bgz||Bez) PCOp=1;
					    else PCOp=2;

					    EXTOp=0;
						 MemWrite=0;
						 RegWrite=0;
						 startMD=0;
				    end
				 end
				 
				 6'b000010://j
				 begin
					 PCOp=3;
					 MemWrite=0;
					 RegWrite=0;
					 startMD=0;
				 end
				 
				 6'b000011://jal
				 begin
				    RegDst=2;
					 PCOp=3;
					 MemWrite=0;
					 RegWrite=1;
					 MemtoReg=3;
					 startMD=0;
				 end
				 
				 6'b001111://lui
				 begin
				    RegDst=0;
					 PCOp=0;
					 EXTOp=2;
					 MemWrite=0;
					 RegWrite=1;
					 MemtoReg=2;
					 startMD=0;
				 end
				 //load,store类型指令在dm处还有一个专用译码器 
				 6'b100000://lb
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=0;
					 startMD=0;
				 end
             
				 6'b100001://lh
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=0;
					 startMD=0;
				 end
				 
				 6'b100011://lw
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=0;
					 startMD=0;
				 end
				 
				 6'b100100://lbu
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=0;
					 startMD=0;
				 end
				 
				 6'b100101://lhu
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=0;
					 startMD=0;
				 end
				 
				 6'b101000://sb
				 begin
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=1;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 startMD=0;
				 end
				 
				 6'b101001://sh
				 begin
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=1;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 startMD=0;
				 end
				 
				 6'b101011://sw
				 begin
					 PCOp=0;
					 ALUOp=0;
					 EXTOp=0;
					 MemWrite=1;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 startMD=0;
				 end	
             
             6'b011100://clz
				 begin
				    RegDst=1;
					 PCOp=0;
					 ALUOp=11;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b001010://slti
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=12;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=1;
					 startMD=0;
				 end
				 
				 6'b001011://sltiu
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=13;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=1;
					 ALUSrcA=0;
					 ALUSrcB=1;
					 MemtoReg=1;
					 startMD=0;
				 end  
				 
				 default:
				 begin
				    RegDst=0;
					 PCOp=0;
					 ALUOp=0;
					 MDOp=0;
					 EXTOp=0;
					 MemWrite=0;
					 RegWrite=0;
					 ALUSrcA=0;
					 ALUSrcB=0;
					 MemtoReg=0;
					 startMD=0;
				 end 
			 endcase
		 end
	 end

endmodule
