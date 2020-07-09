`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
	 
	 reg Out;
	 integer state=0;
	 
	 initial 
	 begin
	    Out=0;
	 end
	 
	 assign out=Out;
	 
	 always @(posedge clk or posedge clr)
	 begin
	    
		 if(clr==1) 
		 begin
		    state<=0;
			 Out<=0;
		 end
		 
		 else
		 begin
		    case(state)
		       0:
			       begin
				       if(in>=48&&in<=57)
						 begin
						    state<=1;
						    Out<=1;
						 end
						 
						 else 
						 begin
						    state<=3;
							 Out<=0;
						 end
				    end
		       
             1:
			       begin
				       if(in==42||in==43)
						 begin
						    state<=2;
						    Out<=0;
						 end
						 
						 else 
						 begin
						    state<=3;
							 Out<=0;
						 end
				    end		
       
             2:
			       begin
				       if(in>=48&&in<=57)
						 begin
						    state<=1;
						    Out<=1;
						 end
						 
						 else 
						 begin
						    state<=3;
							 Out<=0;
						 end
				    end	
             
				 default:
             begin
					 state<=3;
					 Out<=0;	
             end				 
		    endcase
		 end
	 end


endmodule