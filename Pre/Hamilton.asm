.data
   x:.space 210
   y:.space 210
.text
   li $v0,5
   syscall
   move $t0,$v0               #t0=n;
   
   li $v0,5
   syscall
   move $t1,$v0               #t1=m;
   
   addu $t1,$t1,$t2           #t2=2*m;
   li $t3,0                   #t3=i;
   
for_1_begin:
   slt $t4,$t3,$t2
   beq $t4,$zero,for_2_end
   nop
   
   li $t5,4
   mult $t5,$t3
   mflo $t5
   
   li $v0,5
   syscall                         #read an integer
   
   la $t6,x
   addu $t6,$t6,$t5
   sw $v0,0($t6)
   
   li $v0,5                        #read another integer
   syscall
   
   la $t6,y
   addu $t6,$t6,$t5
   sw $v0,0($t6)
   
   addi $t3,$t3,1
   j for_1_begin
   nop
for_2_end:   
   li $a0,1
   li $v0,1
   syscall
   
   li $v0,10
   syscall