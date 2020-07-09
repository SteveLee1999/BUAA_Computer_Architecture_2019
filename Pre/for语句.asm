.text
li $t1 100   #use t1 as n
li $t2 0     #use t2 as i
for_begin:
   slt $t3,$t2,$t1
   beq $t3,$zero,for_end
   nop
   
   #######################
   #       statment      #
   #######################
   
   addi $t2,$t2,1
   j for_begin
   nop

for_end:
