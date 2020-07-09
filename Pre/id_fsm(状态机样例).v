`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module id_fsm(
    input [7:0] char,
    input clk,
    output reg out = 0
    );
	 
	 integer state = 0;
	 /*state�������ܹ���ȷ��ʾ��ǰ�ۼƶ���ĺ������ǰ׺�ĳ���,�൱�ڱ�ǵ�ǰ״̬��*/
	 
	 always @(posedge clk) 
	 begin
		case (state)
		0:
			begin
				if((char>=65&&char<=90)||(char>=97&&char<=122))
				begin
				   state<=1;
					out<=0;
            end				
				
				else
				begin
				   state<=0;
					out<=0;
            end						
			end
		1:
			begin
				if((char>=65&&char<=90)||(char>=97&&char<=122))
				begin
				   state<=1;
					out<=0;
				end
				
				else if(char>=48&&char<=57)
				begin
				   state<=2;
					out<=1;
				end
				
				else
				begin
				   state<=0;
				   out<=0;
				end
			end	
		2:
			begin
				if((char>=65&&char<=90)||(char>=97&&char<=122))
				begin
				   state<=1;
					out<=0;
				end
				
				else if(char>=48&&char<=57)
				begin
				   state<=2;
					out<=1;
				end
				
				else
				begin
				   state<=0;
				   out<=0;
				end
			end		
			
		endcase
	 end

endmodule
