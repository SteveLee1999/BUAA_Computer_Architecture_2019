`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module hazard(
    input [31:0] instr_D,
    input [31:0] instr_E,
    input [31:0] instr_M,
    input [31:0] instr_W,
	 output Stall,
	 output [2:0] ForwardRS_D,
	 output [2:0] ForwardRT_D,
	 output [2:0] ForwardRS_E,
	 output [2:0] ForwardRT_E,
	 output ForwardRT_M
    );
	 wire stall_cal_r,cal_r_D,cal_r_E,cal_r_M,cal_r_W;
	 wire stall_cal_i,cal_i_D,cal_i_E,cal_i_M,cal_i_W;
	 wire stall_lui,lui_E,lui_M,lui_W;
	 wire stall_load,load_D,load_E,load_M,load_W;
	 wire stall_store,store_D,store_E,store_M;
	 wire stall_beq,beq_D;
	 wire stall_jr,jr_D;
	 wire stall_jal,jal_E,jal_M,jal_W;
	 wire stall_clz,clz_D,clz_E,clz_M,clz_W;
	 wire stall_bgezal,bgezal_D,bgezal_E,bgezal_M,bgezal_W;
	 
	 `define op 31:26
	 `define funct 5:0
	 `define rs 25:21
	 `define rt 20:16
	 `define rd 15:11
	 
	 //D
    assign cal_r_D=(instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100001||
	                 instr_D[`op]==6'b000000&&instr_D[`funct]==6'b100011)?1:0;
	 assign cal_i_D=(instr_D[`op]==6'b001101)?1:0;
	 assign load_D=(instr_D[`op]==6'b100011)?1:0;
	 assign store_D=(instr_D[`op]==6'b101011)?1:0;
	 assign beq_D=(instr_D[`op]==6'b000100)?1:0;
	 assign jr_D=(instr_D[`op]==6'b000000&&instr_D[`funct]==6'b001000)?1:0;
	 assign clz_D=(instr_D[`op]==6'b011100&&instr_D[`funct]==6'b100000)?1:0;
	 assign bgezal_D=(instr_D[`op]==6'b000001&&instr_D[`rt]==6'b100001)?1:0;
	 
	 //E
	 assign cal_r_E=(instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100001||
	                 instr_E[`op]==6'b000000&&instr_E[`funct]==6'b100011)?1:0;
	 assign cal_i_E=(instr_E[`op]==6'b001101)?1:0;
	 assign load_E=(instr_E[`op]==6'b100011)?1:0;
	 assign store_E=(instr_E[`op]==6'b101011)?1:0;
	 assign jal_E=(instr_E[`op]==6'b000011)?1:0;
	 assign lui_E=(instr_E[`op]==6'b001111)?1:0;
	 assign clz_E=(instr_E[`op]==6'b011100&&instr_E[`funct]==6'b100000)?1:0;
	 assign bgezal_E=(instr_E[`op]==6'b000001&&instr_E[`rt]==6'b100001)?1:0;
	 
	 //M
	 assign cal_r_M=(instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100001||
	                 instr_M[`op]==6'b000000&&instr_M[`funct]==6'b100011)?1:0;
	 assign cal_i_M=(instr_M[`op]==6'b001101)?1:0;
	 assign load_M=(instr_M[`op]==6'b100011)?1:0;
	 assign store_M=(instr_M[`op]==6'b101011)?1:0;
	 assign jal_M=(instr_M[`op]==6'b000011)?1:0;
	 assign lui_M=(instr_M[`op]==6'b001111)?1:0;
	 assign clz_M=(instr_M[`op]==6'b011100&&instr_M[`funct]==6'b100000)?1:0;
	 assign bgezal_M=(instr_M[`op]==6'b000001&&instr_M[`rt]==6'b100001)?1:0;
	 
	 //W
	 assign cal_r_W=(instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100001||
	                 instr_W[`op]==6'b000000&&instr_W[`funct]==6'b100011)?1:0;
	 assign cal_i_W=(instr_W[`op]==6'b001101)?1:0;
	 assign load_W=(instr_W[`op]==6'b100011)?1:0;
	 assign jal_W=(instr_W[`op]==6'b000011)?1:0;
	 assign lui_W=(instr_W[`op]==6'b001111)?1:0;
	 assign clz_W=(instr_W[`op]==6'b011100&&instr_W[`funct]==6'b100000)?1:0;
	 assign bgezal_W=(instr_W[`op]==6'b000001&&instr_W[`rt]==6'b100001)?1:0;
	 
	 //stall
	 assign stall_cal_r=cal_r_D&load_E&(instr_D[`rs]==instr_E[`rt]||instr_D[`rt]==instr_E[`rt])&(instr_E[`rt]!=0);//小心！！！0不用转发
	 assign stall_cal_i=cal_i_D&load_E&(instr_D[`rs]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_clz=clz_D&load_E&(instr_D[`rs]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_load=load_D&load_E&(instr_D[`rs]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_store=store_D&load_E&(instr_D[`rs]==instr_E[`rt]||instr_D[`rt]==instr_E[`rt])&(instr_E[`rt]!=0);
	 assign stall_beq=beq_D&(cal_r_E|clz_E)&(instr_D[`rs]==instr_E[`rd]||instr_D[`rt]==instr_E[`rd])&(instr_E[`rd]!=0)|
	                  beq_D&(cal_i_E|load_E)&(instr_D[`rs]==instr_E[`rt]||instr_D[`rt]==instr_E[`rt])&(instr_E[`rt]!=0)|
							beq_D&load_M&(instr_D[`rs]==instr_M[`rt]||instr_D[`rt]==instr_M[`rt])&(instr_M[`rt]!=0);
												
	 assign stall_jr=jr_D&(cal_r_E|clz_E)&(instr_D[`rs]==instr_E[`rd])&(instr_D[`rs]!=0)|
	                 jr_D&(cal_i_E|load_E)&(instr_D[`rs]==instr_E[`rt])&(instr_D[`rs]!=0)|
						  jr_D&load_M&(instr_D[`rs]==instr_M[`rt])&(instr_D[`rs]!=0);
	 
	 assign stall_bgezal=bgezal_D&(cal_r_E|clz_E)&(instr_D[`rs]==instr_E[`rd])&(instr_D[`rs]!=0)|
	                     bgezal_D&(cal_i_E|load_E)&(instr_D[`rs]==instr_E[`rt])&(instr_D[`rs]!=0)|
							   bgezal_D&load_M&(instr_D[`rs]==instr_M[`rt])&(instr_D[`rs]!=0);
	 
	 assign Stall=stall_cal_r|stall_cal_i|stall_clz|stall_load|stall_store|stall_beq|stall_jr|stall_bgezal;


    //forward
	 assign ForwardRS_D=//0:RS_D  1:ALUOut_M  2:PC4_M+4  3:PC4_E+4  4:imm_M  5:imm_E
	 (beq_D|jr_D|bgezal_D)&(cal_r_M|clz_M)&instr_D[`rs]==instr_M[`rd]&(instr_D[`rs]!=0) ?1:
	 (beq_D|jr_D|bgezal_D)&cal_i_M&instr_D[`rs]==instr_M[`rt]&(instr_D[`rs]!=0)         ?1:
	 (beq_D|jr_D|bgezal_D)&(jal_M|bgezal_M)&instr_D[`rs]==5'b11111                      ?2:
	 (beq_D|jr_D|bgezal_D)&(jal_E|bgezal_E)&instr_D[`rs]==5'b11111                      ?3:
    (beq_D|jr_D|bgezal_D)&lui_M&instr_D[`rs]==instr_M[`rt]&(instr_D[`rs]!=0)           ?4:
	 (beq_D|jr_D|bgezal_D)&lui_E&instr_D[`rs]==instr_E[`rt]&(instr_D[`rs]!=0)           ?5:0;
	  
    assign ForwardRT_D=//0:RT_D  1:ALUOut_M  2:PC4_M+4  3:PC4_E+4  4:imm_M  5:imm_E
	 beq_D&(cal_r_M|clz_M)&instr_D[`rt]==instr_M[`rd]&(instr_D[`rt]!=0) ?1:
	 beq_D&cal_i_M&instr_D[`rt]==instr_M[`rt]&(instr_D[`rt]!=0)         ?1:
	 beq_D&(jal_M|bgezal_M)&instr_D[`rt]==5'b11111                      ?2:
	 beq_D&(jal_E|bgezal_E)&instr_D[`rt]==5'b11111						     ?3:
    beq_D&lui_M&instr_D[`rt]==instr_M[`rt]&(instr_D[`rt]!=0)           ?4:
	 beq_D&lui_E&instr_D[`rt]==instr_E[`rt]&(instr_D[`rt]!=0)	        ?5:0;
	 
    assign ForwardRS_E=//0:RS_E  1:ALUOut_M  2:PC4_M+4  3:imm_M  4:MUX(MemtoReg)
    (cal_r_E|clz_E|cal_i_E|load_E|store_E)&(cal_r_M|clz_M)&instr_E[`rs]==instr_M[`rd]&(instr_E[`rs]!=0)        ?1:
    (cal_r_E|clz_E|cal_i_E|load_E|store_E)&cal_i_M&instr_E[`rs]==instr_M[`rt]&(instr_E[`rs]!=0)                ?1:  
    (cal_r_E|clz_E|cal_i_E|load_E|store_E)&(jal_M|bgezal_M)&instr_E[`rs]==5'b11111                             ?2:
	 (cal_r_E|clz_E|cal_i_E|load_E|store_E)&lui_M&instr_E[`rs]==instr_M[`rt]&(instr_E[`rs]!=0)                  ?3:
    (cal_r_E|clz_E|cal_i_E|load_E|store_E)&(cal_r_W|clz_W)&instr_E[`rs]==instr_W[`rd]&(instr_E[`rs]!=0)        ?4:	 
	 (cal_r_E|clz_E|cal_i_E|load_E|store_E)&(cal_i_W|load_W|lui_W)&instr_E[`rs]==instr_W[`rt]&(instr_E[`rs]!=0) ?4:   
    (cal_r_E|clz_E|cal_i_E|load_E|store_E)&(jal_W|bgezal_W)&instr_E[`rs]==5'b11111                             ?4:0;
	 
    assign ForwardRT_E=//0:RT_E  1:ALUOut_M  2:PC4_M+4  3:imm_M  4:MUX(MemtoReg)
    cal_r_E&(cal_r_M|clz_M)&instr_E[`rt]==instr_M[`rd]&(instr_E[`rt]!=0)                  ?1:
	 cal_r_E&cal_i_M&instr_E[`rt]==instr_M[`rt]&(instr_E[`rt]!=0)                          ?1:  
    cal_r_E&(jal_M|bgezal_M)&instr_E[`rt]==5'b11111                                       ?2:
    cal_r_E&lui_M&instr_E[`rt]==instr_M[`rt]&(instr_E[`rt]!=0)                            ?3:
	 (cal_r_E|store_E)&(cal_r_W|clz_W)&instr_E[`rt]==instr_W[`rd]&(instr_E[`rt]!=0)        ?4:	 	 
	 (cal_r_E|store_E)&(cal_i_W|load_W|lui_W)&instr_E[`rt]==instr_W[`rt]&(instr_E[`rt]!=0) ?4:                     
    (cal_r_E|store_E)&(jal_W|bgezal_W)&instr_E[`rt]==5'b11111                             ?4:0;

    assign ForwardRT_M=//0:RT_M  1:MUX(MemtoReg)	 
    store_M&(cal_r_W|clz_W)&instr_M[`rt]==instr_W[`rd]&(instr_M[`rt]!=0)        ?1:
	 store_M&(cal_i_W|load_W|lui_W)&instr_M[`rt]==instr_W[`rt]&(instr_M[`rt]!=0) ?1:	 
	 store_M&(jal_W|bgezal_W)&instr_M[`rt]==5'b11111                             ?1:0;

endmodule
