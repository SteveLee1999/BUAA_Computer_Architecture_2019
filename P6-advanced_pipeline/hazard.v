`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module hazard(
    input [31:0] instr_D,
    input [31:0] instr_E,
    input [31:0] instr_M,
    input [31:0] instr_W,
	 input RegWrite_D,
	 input RegWrite_E,
	 input RegWrite_M,
	 input RegWrite_W,
	 input startMD,
	 input Busy,
	 output Stall,
	 output MD_Stall,
	 output [2:0] ForwardRS_D,
	 output [2:0] ForwardRT_D,
	 output [2:0] ForwardRS_E,
	 output [2:0] ForwardRT_E,
	 output [2:0] ForwardRT_M
    );
	 wire stall_cal_r,cal_r_D,cal_r_E,cal_r_M,cal_r_W;
	 wire stall_cal_i,cal_i_D,cal_i_E,cal_i_M,cal_i_W;
	 wire stall_lui,lui_E,lui_M,lui_W;
	 wire stall_load,load_D,load_E,load_M,load_W;
	 wire stall_store,store_D,store_E,store_M;
	 wire stall_beq,beq_D;
	 wire stall_jr,jr_D;
	 wire stall_jal,jal_E,jal_M,jal_W;
	 wire stall_jalr,jalr_D,jalr_E,jalr_M,jalr_W;
	 wire stall_clz,clz_D,clz_E,clz_M,clz_W;
	 wire stall_bgezal,bgezal_D,bgezal_E,bgezal_M,bgezal_W;
	 wire stall_md,md_D,md_E,md_M,md_W;
	 wire stall_mt,mt_D,mt_E,mt_M,mt_W;
	 wire mfhi_D,mfhi_E,mfhi_M,mfhi_W;
	 wire mflo_D,mflo_E,mflo_M,mflo_W;
	 
	 `define op 31:26
	 `define funct 5:0
	 `define rs 25:21
	 `define rt 20:16
	 `define rd 15:11
	 
	 //D
    assign cal_r_D=(instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100000||//add
	                 instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100001||//addu
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100010||//sub
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100011||//subu
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100100||//and
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100101||//or
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100110||//xor
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100111||//nor
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b000000||//sll
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b000010||//srl
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b000011||//sra
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b000100||//sllv
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b000110||//srlv
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b000111||//srav	                 	                 
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b101010||//slt
						  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b101011)?1:0;//sltu                    						  
	 assign cal_i_D=(instr_D[`op]==6'b001000||//addi
	                 instr_D[`op]==6'b001001||//addiu
						  instr_D[`op]==6'b001100||//andi
						  instr_D[`op]==6'b001101||//ori
						  instr_D[`op]==6'b001110||//xori
						  instr_D[`op]==6'b001010||//slti
						  instr_D[`op]==6'b001011)?1:0;//sltiu
	 assign load_D= (instr_D[`op]==6'b100000||//lb
	                 instr_D[`op]==6'b100001||//lh
						  instr_D[`op]==6'b100011||//lw
						  instr_D[`op]==6'b100100||//lbu
						  instr_D[`op]==6'b100101)?1:0;//lhu	 
	 assign store_D=(instr_D[`op]==6'b101000||//sb
	                 instr_D[`op]==6'b101001||//sh
						  instr_D[`op]==6'b101011)?1:0;//sw
	 assign beq_D = (instr_D[`op]==6'b000100||//beq
	                 instr_D[`op]==6'b000101)?1:0;//bne
	 assign jr_D =  (instr_D[`op]==6'b000000&&instr_D[`funct]==6'b001000||//jr
	                 instr_D[`op]==6'b000110||//blez
					     instr_D[`op]==6'b000111||//bgtz
	                 instr_D[`op]==6'b000001&&instr_D[`rt]==5'b00000||//bltz
	                 instr_D[`op]==6'b000001&&instr_D[`rt]==5'b00001)?1:0;//bgtz
	 assign jalr_D= (instr_D[`op]==6'b000000&&instr_D[`funct]==6'b001001)?1:0;
	 assign clz_D = (instr_D[`op]==6'b011100&&instr_D[`funct]==6'b100000)?1:0;
	 assign bgezal_D=(instr_D[`op]==6'b000001&&instr_D[`rt]==5'b10001)?1:0;
	 assign md_D=(instr_D[`op]==6'b000000&&instr_D[`funct]==6'b011000||
	              instr_D[`op]==6'b000000&&instr_D[`funct]==6'b011001||
					  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b011010||
					  instr_D[`op]==6'b000000&&instr_D[`funct]==6'b011011)?1:0;
	 assign mt_D=(instr_D[`op]==6'b000000&&instr_D[`funct]==6'b010001||
	              instr_D[`op]==6'b000000&&instr_D[`funct]==6'b010011)?1:0;
	 assign mfhi_D=(instr_D[`op]==6'b000000&&instr_D[`funct]==6'b010000)?1:0;
	 assign mflo_D=(instr_D[`op]==6'b000000&&instr_D[`funct]==6'b010010)?1:0;
	 
	 //E
	 assign cal_r_E=(instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100000||
	                 instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100001||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100010||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100011||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100100||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100101||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100110||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100111||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b000100||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b000110||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b000111||
	                 instr_E[`op]==6'b000000&&instr_E[`funct]==6'b000000||
	                 instr_E[`op]==6'b000000&&instr_E[`funct]==6'b000010||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b000011||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b101010||
						  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b101011)?1:0;                						  
	 assign cal_i_E=(instr_E[`op]==6'b001000||
	                 instr_E[`op]==6'b001001||
						  instr_E[`op]==6'b001100||
						  instr_E[`op]==6'b001101||
						  instr_E[`op]==6'b001110||
						  instr_E[`op]==6'b001010||
						  instr_E[`op]==6'b001011)?1:0;
	 assign load_E= (instr_E[`op]==6'b100000||
	                 instr_E[`op]==6'b100001||
						  instr_E[`op]==6'b100011||
						  instr_E[`op]==6'b100100||
						  instr_E[`op]==6'b100101)?1:0;	 
	 assign store_E=(instr_E[`op]==6'b101000||
	                 instr_E[`op]==6'b101001||
						  instr_E[`op]==6'b101011)?1:0;
	 assign jal_E = (instr_E[`op]==6'b000011)?1:0;
	 assign jalr_E= (instr_E[`op]==6'b000000&&instr_E[`funct]==6'b001001)?1:0;
	 assign lui_E = (instr_E[`op]==6'b001111)?1:0;
	 assign clz_E = (instr_E[`op]==6'b011100&&instr_E[`funct]==6'b100000)?1:0;
	 assign bgezal_E=(instr_E[`op]==6'b000001&&instr_E[`rt]==5'b10001)?1:0;
	 assign md_E=(instr_E[`op]==6'b000000&&instr_E[`funct]==6'b011000||
	              instr_E[`op]==6'b000000&&instr_E[`funct]==6'b011001||
					  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b011010||
					  instr_E[`op]==6'b000000&&instr_E[`funct]==6'b011011)?1:0;
    assign mt_E=(instr_E[`op]==6'b000000&&instr_E[`funct]==6'b010001||
	              instr_E[`op]==6'b000000&&instr_E[`funct]==6'b010011)?1:0;
	 assign mfhi_E=(instr_E[`op]==6'b000000&&instr_E[`funct]==6'b010000)?1:0;
	 assign mflo_E=(instr_E[`op]==6'b000000&&instr_E[`funct]==6'b010010)?1:0;
	 
	 //M
	 assign cal_r_M=(instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100000||
	                 instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100001||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100010||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100011||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100100||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100101||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100110||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100111||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b000100||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b000110||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b000111||
	                 instr_M[`op]==6'b000000&&instr_M[`funct]==6'b000000||
	                 instr_M[`op]==6'b000000&&instr_M[`funct]==6'b000010||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b000011||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b101010||
						  instr_M[`op]==6'b000000&&instr_M[`funct]==6'b101011)?1:0;                						  
	 assign cal_i_M=(instr_M[`op]==6'b001000||
	                 instr_M[`op]==6'b001001||
						  instr_M[`op]==6'b001100||
						  instr_M[`op]==6'b001101||
						  instr_M[`op]==6'b001110||
						  instr_M[`op]==6'b001010||
						  instr_M[`op]==6'b001011)?1:0;
	 assign load_M= (instr_M[`op]==6'b100000||
	                 instr_M[`op]==6'b100001||
						  instr_M[`op]==6'b100011||
						  instr_M[`op]==6'b100100||
						  instr_M[`op]==6'b100101)?1:0;	 
	 assign store_M=(instr_M[`op]==6'b101000||
	                 instr_M[`op]==6'b101001||
						  instr_M[`op]==6'b101011)?1:0;
	 assign jal_M=(instr_M[`op]==6'b000011)?1:0;
	 assign jalr_M= (instr_M[`op]==6'b000000&&instr_M[`funct]==6'b001001)?1:0;
	 assign lui_M=(instr_M[`op]==6'b001111)?1:0;
	 assign clz_M=(instr_M[`op]==6'b011100&&instr_M[`funct]==6'b100000)?1:0;
	 assign bgezal_M=(instr_M[`op]==6'b000001&&instr_M[`rt]==5'b10001)?1:0;
	 assign mfhi_M=(instr_M[`op]==6'b000000&&instr_M[`funct]==6'b010000)?1:0;
	 assign mflo_M=(instr_M[`op]==6'b000000&&instr_M[`funct]==6'b010010)?1:0;
	 
	 //W
	 assign cal_r_W=(instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100000||
	                 instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100001||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100010||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100011||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100100||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100101||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100110||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100111||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b000100||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b000110||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b000111||
	                 instr_W[`op]==6'b000000&&instr_W[`funct]==6'b000000||
	                 instr_W[`op]==6'b000000&&instr_W[`funct]==6'b000010||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b000011||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b101010||
						  instr_W[`op]==6'b000000&&instr_W[`funct]==6'b101011)?1:0;                						  
	 assign cal_i_W=(instr_W[`op]==6'b001000||
	                 instr_W[`op]==6'b001001||
						  instr_W[`op]==6'b001100||
						  instr_W[`op]==6'b001101||
						  instr_W[`op]==6'b001110||
						  instr_W[`op]==6'b001010||
						  instr_W[`op]==6'b001011)?1:0;
	 assign load_W= (instr_W[`op]==6'b100000||
	                 instr_W[`op]==6'b100001||
						  instr_W[`op]==6'b100011||
						  instr_W[`op]==6'b100100||
						  instr_W[`op]==6'b100101)?1:0;	 
	 assign jal_W = (instr_W[`op]==6'b000011)?1:0;
	 assign jalr_W= (instr_W[`op]==6'b000000&&instr_W[`funct]==6'b001001)?1:0;
	 assign lui_W=(instr_W[`op]==6'b001111)?1:0;
	 assign clz_W=(instr_W[`op]==6'b011100&&instr_W[`funct]==6'b100000)?1:0;
	 assign bgezal_W=(instr_W[`op]==6'b000001&&instr_W[`rt]==5'b10001)?1:0;
	 assign mfhi_W=(instr_W[`op]==6'b000000&&instr_W[`funct]==6'b010000)?1:0;
	 assign mflo_W=(instr_W[`op]==6'b000000&&instr_W[`funct]==6'b010010)?1:0;
	 
	 //stall
	 assign stall_cal_r=cal_r_D&load_E&(instr_D[`rs]==instr_E[`rt]||instr_D[`rt]==instr_E[`rt])&(instr_E[`rt]!=0);//小心！！！0不用转发
	 assign stall_md=md_D&load_E&(instr_D[`rs]==instr_E[`rt]||instr_D[`rt]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_mt=mt_D&load_E&(instr_D[`rs]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_cal_i=cal_i_D&load_E&(instr_D[`rs]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_clz=clz_D&load_E&(instr_D[`rs]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_load=load_D&load_E&(instr_D[`rs]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_store=store_D&load_E&(instr_D[`rs]==instr_E[`rt]||instr_D[`rt]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_beq=beq_D&(cal_r_E|clz_E|mfhi_E|mflo_E)&(instr_D[`rs]==instr_E[`rd]||instr_D[`rt]==instr_E[`rd])&(instr_E[`rd]!=0)|
	                  beq_D&(cal_i_E|load_E)&(instr_D[`rs]==instr_E[`rt]||instr_D[`rt]==instr_E[`rt])&(instr_E[`rt]!=0)|
							beq_D&load_M&(instr_D[`rs]==instr_M[`rt]||instr_D[`rt]==instr_M[`rt])&(instr_M[`rt]!=0);
												
	 assign stall_jr=jr_D&(cal_r_E|clz_E|mfhi_E|mflo_E)&(instr_D[`rs]==instr_E[`rd])&(instr_D[`rs]!=0)|
	                 jr_D&(cal_i_E|load_E)&(instr_D[`rs]==instr_E[`rt])&(instr_D[`rs]!=0)|
						  jr_D&load_M&(instr_D[`rs]==instr_M[`rt])&(instr_D[`rs]!=0);
	 
	 assign stall_jalr=jalr_D&(cal_r_E|clz_E|mfhi_E|mflo_E)&(instr_D[`rs]==instr_E[`rd])&(instr_D[`rs]!=0)|
	                   jalr_D&(cal_i_E|load_E)&(instr_D[`rs]==instr_E[`rt])&(instr_D[`rs]!=0)|
						    jalr_D&load_M&(instr_D[`rs]==instr_M[`rt])&(instr_D[`rs]!=0);
	 
	 assign stall_bgezal=bgezal_D&(cal_r_E|clz_E|mfhi_E|mflo_E)&(instr_D[`rs]==instr_E[`rd])&(instr_D[`rs]!=0)|	                     
	                     bgezal_D&(cal_i_E|load_E)&(instr_D[`rs]==instr_E[`rt])&(instr_D[`rs]!=0)|									   
							   bgezal_D&load_M&(instr_D[`rs]==instr_M[`rt])&(instr_D[`rs]!=0);
	 
	 assign Stall=stall_cal_r|stall_md|stall_mt|stall_cal_i|stall_clz|stall_load|stall_store|stall_beq|stall_jr|stall_jalr|stall_bgezal;
    
	 assign MD_Stall=(startMD|Busy)&(md_D|mt_D|mfhi_D|mflo_D);

    //forward
	 assign ForwardRS_D=//0:RS_D  1:ALUOut_M  2:PC4_M+4  3:PC4_E+4  4:imm_M  5:imm_E  6:HI_M  7:LO_M
    (beq_D|jr_D|jalr_D|bgezal_D)&(cal_r_M|clz_M)&instr_D[`rs]==instr_M[`rd]&(instr_D[`rs]!=0) ?1:
	 (beq_D|jr_D|jalr_D|bgezal_D)&cal_i_M&instr_D[`rs]==instr_M[`rt]&(instr_D[`rs]!=0)         ?1:
	 (beq_D|jr_D|jalr_D|bgezal_D)&(jal_M|(bgezal_M&&RegWrite_M))&instr_D[`rs]==5'b11111        ?2:
	 (beq_D|jr_D|jalr_D|bgezal_D)&jalr_M&instr_D[`rs]==instr_M[`rd]&(instr_D[`rs]!=0)          ?2:
	 (beq_D|jr_D|jalr_D|bgezal_D)&(jal_E|(bgezal_E&&RegWrite_E))&instr_D[`rs]==5'b11111        ?3:
    (beq_D|jr_D|jalr_D|bgezal_D)&jalr_E&instr_D[`rs]==instr_E[`rd]&(instr_D[`rs]!=0)          ?3:
	 (beq_D|jr_D|jalr_D|bgezal_D)&lui_M&instr_D[`rs]==instr_M[`rt]&(instr_D[`rs]!=0)           ?4:
	 (beq_D|jr_D|jalr_D|bgezal_D)&lui_E&instr_D[`rs]==instr_E[`rt]&(instr_D[`rs]!=0)           ?5:
	 (beq_D|jr_D|jalr_D|bgezal_D)&mfhi_M&instr_D[`rs]==instr_M[`rd]&(instr_D[`rs]!=0)          ?6:
	 (beq_D|jr_D|jalr_D|bgezal_D)&mflo_M&instr_D[`rs]==instr_M[`rd]&(instr_D[`rs]!=0)          ?7:0;
	 
    assign ForwardRT_D=//0:RT_D  1:ALUOut_M  2:PC4_M+4  3:PC4_E+4  4:imm_M  5:imm_E  6:HI_M  7:LO_M
	 beq_D&(cal_r_M|clz_M)&instr_D[`rt]==instr_M[`rd]&(instr_D[`rt]!=0) ?1:
	 beq_D&cal_i_M&instr_D[`rt]==instr_M[`rt]&(instr_D[`rt]!=0)         ?1:
	 beq_D&(jal_M|(bgezal_M&&RegWrite_M))&instr_D[`rt]==5'b11111        ?2:
	 beq_D&jalr_M&instr_D[`rt]==instr_M[`rd]&(instr_D[`rt]!=0)          ?2:
	 beq_D&(jal_E|(bgezal_E&&RegWrite_E))&instr_D[`rt]==5'b11111		  ?3:
    beq_D&jalr_E&instr_D[`rt]==instr_E[`rd]&(instr_D[`rt]!=0)          ?3:
	 beq_D&lui_M&instr_D[`rt]==instr_M[`rt]&(instr_D[`rt]!=0)           ?4:
	 beq_D&lui_E&instr_D[`rt]==instr_E[`rt]&(instr_D[`rt]!=0)	        ?5:
	 beq_D&mfhi_M&instr_D[`rt]==instr_M[`rd]&(instr_D[`rt]!=0)          ?6:
	 beq_D&mflo_M&instr_D[`rt]==instr_M[`rd]&(instr_D[`rt]!=0)          ?7:0;
	 
    assign ForwardRS_E=//0:RS_E  1:ALUOut_M  2:PC4_M+4  3:imm_M  4:MUX(MemtoReg)  5:HI_M  6:LO_M
    (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&(cal_r_M|clz_M)&instr_E[`rs]==instr_M[`rd]&(instr_E[`rs]!=0)        					 ?1:
    (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&cal_i_M&instr_E[`rs]==instr_M[`rt]&(instr_E[`rs]!=0)                					 ?1:  
    (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&(jal_M|(bgezal_M&&RegWrite_M))&instr_E[`rs]==5'b11111                       		 ?2:
	 (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&jalr_M&instr_E[`rs]==instr_M[`rd]&(instr_E[`rs]!=0)     		               		 ?2:
	 (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&lui_M&instr_E[`rs]==instr_M[`rt]&(instr_E[`rs]!=0)                          		 ?3:
    (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&(cal_r_W|clz_W|mfhi_W|mflo_W|jalr_W)&instr_E[`rs]==instr_W[`rd]&(instr_E[`rs]!=0)  ?4:	 
	 (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&(cal_i_W|load_W|lui_W)&instr_E[`rs]==instr_W[`rt]&(instr_E[`rs]!=0) 					 ?4:   
    (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&(jal_W|(bgezal_W&&RegWrite_W))&instr_E[`rs]==5'b11111                       		 ?4:
	 (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&mfhi_M&instr_E[`rs]==instr_M[`rd]&(instr_E[`rs]!=0)                 					 ?5:
	 (cal_r_E|md_E|mt_E|clz_E|cal_i_E|load_E|store_E)&mflo_M&instr_E[`rs]==instr_M[`rd]&(instr_E[`rs]!=0)                 					 ?6:0;
	 
    assign ForwardRT_E=//0:RT_E  1:ALUOut_M  2:PC4_M+4  3:imm_M  4:MUX(MemtoReg)  5:HI_M  6:LO_M
    (cal_r_E|md_E)&(cal_r_M|clz_M)&instr_E[`rt]==instr_M[`rd]&(instr_E[`rt]!=0)                       		 ?1:
	 (cal_r_E|md_E)&cal_i_M&instr_E[`rt]==instr_M[`rt]&(instr_E[`rt]!=0)                               		 ?1:  
    (cal_r_E|md_E)&(jal_M|(bgezal_M&&RegWrite_M))&instr_E[`rt]==5'b11111                              		 ?2:
	 (cal_r_E|md_E)&jalr_M&instr_E[`rt]==instr_M[`rd]&(instr_E[`rt]!=0)                                		 ?2:
    (cal_r_E|md_E)&lui_M&instr_E[`rt]==instr_M[`rt]&(instr_E[`rt]!=0)                                 		 ?3:
	 (cal_r_E|md_E|store_E)&(cal_r_W|clz_W|mfhi_W|mflo_W|jalr_W)&instr_E[`rt]==instr_W[`rd]&(instr_E[`rt]!=0) ?4:	 	 
	 (cal_r_E|md_E|store_E)&(cal_i_W|load_W|lui_W)&instr_E[`rt]==instr_W[`rt]&(instr_E[`rt]!=0)        		 ?4:                     
    (cal_r_E|md_E|store_E)&(jal_W|(bgezal_W&&RegWrite_W))&instr_E[`rt]==5'b11111                      		 ?4:
	 (cal_r_E|md_E)&mfhi_M&instr_E[`rt]==instr_M[`rd]&(instr_E[`rt]!=0)                                		 ?5:
	 (cal_r_E|md_E)&mflo_M&instr_E[`rt]==instr_M[`rd]&(instr_E[`rt]!=0)                               		    ?6:0;

    assign ForwardRT_M=//0:RT_M  1:MUX(MemtoReg)  2:HI_M  3:LO_M	 
    store_M&(cal_r_W|clz_W|jalr_W)&instr_M[`rt]==instr_W[`rd]&(instr_M[`rt]!=0)        ?1:
	 store_M&(cal_i_W|load_W|lui_W)&instr_M[`rt]==instr_W[`rt]&(instr_M[`rt]!=0)        ?1:	 
	 store_M&(jal_W|(bgezal_W&&RegWrite_W))&instr_M[`rt]==5'b11111               			?1:
	 store_M&mfhi_W&instr_M[`rt]==instr_W[`rd]&(instr_M[`rt]!=0)                 			?2:
	 store_M&mflo_W&instr_M[`rt]==instr_W[`rd]&(instr_M[`rt]!=0)                 			?3:0; 

endmodule
