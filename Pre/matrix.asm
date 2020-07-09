.data
   number:.space 3000     #store the number
   x:.space 3000          #store the x
   y:.space 3000          #store the y
   space:.asciiz " "
   enter:.asciiz "\n"
.text
   li $v0,5
   syscall
   move $t1,$v0          #t1=n;
   
   li $v0,5
   syscall
   move $t2,$v0          #t2=m;
   
   mult $t1,$t2
   mflo $t3              #t3=m*n;
   
   li $t4,0              #t4=i;
   li $t8,0              #t8 is the number of x!=0
   
for_begin:
   slt $t5,$t4,$t3        #if(t4>=t3) t5=0;
   beq $t5,$zero,for_end
   nop
   
   li $v0,5
   syscall
   move $t6,$v0          #read an integer and store it in t6  
   addi $t4,$t4,1        #i++;
   
   bne $t6,$zero,store   #if(t6!=0) store it.
   nop
  
   j for_begin
   nop
store:
   div $t4,$t2
   mflo $s4
   
   mfhi $s5
   beq $s5,$zero,remainder_0 #if t4==0(mod m)
   nop
   
   addi $s4,$s4,1 #if t4!=0(mod m), s4++;

go_on_store:
   li $t0,4
   mult $t8,$t0
   mflo $t0

   la $s1,number
   addu $s1,$s1,$t0
   sw $t6,0($s1)
   
   la $s2,x
   addu $s2,$s2,$t0
   sw $s4,0($s2)
   
   la $s3,y 
   addu $s3,$s3,$t0
   sw $s5,0($s3)
   
   addi $t8,$t8,1
   j for_begin
   nop
remainder_0: 
   move $s5,$t2 
   j go_on_store
   nop  

for_end:
   move $t4,$t8
   subi $t4,$t4,1
   
for_2_begin:
   blt $t4,$zero,for_2_end 
   nop
   
   li $t0,4
   mult $t4,$t0
   mflo $t0
   
   la $s1,number
   la $s2,x
   la $s3,y
   addu $s1,$s1,$t0
   addu $s2,$s2,$t0
   addu $s3,$s3,$t0
   
   lw $a0,0($s2)
   li $v0,1
   syscall
   
   la $a0,space
   li $v0,4
   syscall
   
   lw $a0,0($s3)
   li $v0,1
   syscall
   
   la $a0,space
   li $v0,4
   syscall
   
   lw $a0,0($s1)
   li $v0,1
   syscall
   
   la $a0,enter
   li $v0,4
   syscall
   
   subi $t4,$t4,1
   j for_2_begin
   nop

for_2_end:
   li $v0,10
   syscall



