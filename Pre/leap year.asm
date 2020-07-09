.data
   zero:.asciiz "0"
   one:.asciiz "1"
.text
   li $v0,5
   syscall
   move $t0,$v0          #read an integer and store it in the t0
   
   li $t1,4 
   li $t2,100
   li $t3,400
   
   div $t0,$t1
   mfhi $t1              #t1=t0%4
   div $t0,$t2
   mfhi $t2              #t2=t0%100
   div $t0,$t3
   mfhi $t3              #t3=t0%400
   
   beq $t3,$zero,yes
   nop
   bne $t1,$zero,no
   nop
   bne $t2,$zero,yes
   nop
   j no
   nop

yes:                     #it is a leap year
   la $a0,one
   li $v0,4
   syscall
   
   li $v0,10
   syscall
no:                      #it is not a leap year
   la $a0,zero
   li $v0,4
   syscall
   
   li $v0,10
   syscall
