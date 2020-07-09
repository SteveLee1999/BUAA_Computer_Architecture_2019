`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module string2(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
	 
	 integer state;
	 reg Out;
	 
	 initial 
	 begin
	    Out=0;
		 state=0;
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
					    if(in==48)
						 begin
						    state<=2;
							 Out<=1;
						 end
						 
						 else if(in>=49&&in<=57)
						 begin
						    state<=3;
							 Out<=1;
						 end
						 
						 else if(in==40)
						 begin
						    state<=6;
							 Out<=0;
						 end
						 
						 else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
		       1:
				    begin
					    state<=1;
						 Out<=0;
					 end
					 
				 2:
				    begin
					    if(in==42||in==43)
						 begin
						    state<=5;
							 Out<=0;
						 end
						 
						 else 
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
			    3:
				    begin
					    if(in>=48&&in<=57)
						 begin
						    state<=4;
							 Out<=1;
						 end
						 
						 else if(in==42||in==43)
						 begin
						    state<=5;
							 Out<=0;
						 end
						 
						 else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
			    4:
				    begin
					    if(in==42||in==43)
						 begin
						    state<=5;
					       Out<=0;
						 end
					 
					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
			    5:
				    begin
					    if(in==48)
						 begin
						    state<=2;
							 Out<=1;
						 end
						 
						 else if(in>=49&&in<=57)
						 begin
						    state<=3;
							 Out<=1;
						 end
						 
						 else if(in==40)
						 begin
						    state<=6;
							 Out<=0;
						 end
						 
					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
			    6:
				    begin
					    if(in==48)
						 begin
						    state<=7;
							 Out<=0;
						 end
						 
						 else if(in>=49&&in<=57)
						 begin
						    state<=8;
							 Out<=0;
						 end
					 
					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
		       7:
				    begin
					    if(in==42||in==43)
						 begin
						    state<=10;
							 Out<=0;
						 end
						 
						 else if(in==41)
						 begin
						    state<=11;
							 Out<=1;
						 end
						 
					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
				
			    8:
				    begin
					    if(in>=48&&in<=57)
						 begin
						    state<=9;
							 Out<=0;
						 end
						 
						 else if(in==42||in==43)
						 begin
						    state<=10;
							 Out<=0;
						 end
						 
						 else if(in==41)
						 begin
						    state<=11;
							 Out<=1;
						 end
						 
					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
			    9:
				    begin
					    if(in==42||in==43)
						 begin
						    state<=10;
							 Out<=0;
						 end
						 
						 else if(in==41)
						 begin
						    state<=11;
							 Out<=1;
						 end
						 
					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
			    10:
				    begin
					    if(in==48)
						 begin
						    state<=7;
							 Out<=0;
						 end
						 
						 else if(in>=49&&in<=57)
						 begin
						    state<=8;
							 Out<=0;
						 end

					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
					 
			    11:
				    begin
					    if(in==42||in==43)
						 begin
						    state<=5;
							 Out<=0;
						 end
					 
					    else
						 begin
						    state<=1;
							 Out<=0;
						 end
					 end
			 endcase
		 end
	 end


endmodule
