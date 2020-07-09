.data
   array:.space 400
   message_input_n:.asciz "Please input an integer as the length of the sequence:\n"
   message_input_array:.asciz "Please input an integer followed with a line break:\n"
   message_output_array:.asciz "The sorted sequence is:\n"
   space:.asciiz " "
   stack:.space 100
.text
input:
   la $a0,message_input_n        #write a string
   li $v0,4
   syscall
   
   li $v0,5                      #read an integer and store it in t0
   syscall
   move $t0,$v0                  #use t0 as n
   
   li $t1,0                      #use t1 as i
for_begin:
   slt $t2,$t1,$t0
   beq $t2,$zero,for_end
   nop
   
   la $t2,array
   li $t3,4
   mult $t1,$t3
   mflo $t3
   addu $t2,$t2,$t3              #find the address 
   
   la $a0,message_input_array
   li $v0,4
   syscall
   
   li $v0,5
   syscall
   
   sw $v0,0($t2)
         
   addi $t1,$t1,1
   j for_begin
   nop

for_end:   


   
   
