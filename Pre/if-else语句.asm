.data
   s1:.asciiz "t2 is smaller than t1\n"
   s2:.asciiz "t1 is smaller than t2\n"
.text
   slt $t3,$t2,$t1
   beq $t3,$zero,if_else
   nop
   la $a0,s1
   li $v0,4
   syscall
   j if_end
   nop
   
   if_else:
      la $a0,s2
      li $v0,4
      syscall
   
   if_end: