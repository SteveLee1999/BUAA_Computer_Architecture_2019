.data
str1: .word 0:100
str2: .word 0:100
string: .word 0:1000
result: .word 0:1000
.text
      li $v0,5
      syscall
      move $s0,$v0
      li $v0,5
      syscall
      move $s1,$v0
      li $v0,5
      syscall 
      move $s2,$v0
      
      move $t0,$zero
readstr1:
      li $v0,12
      syscall
      sll $t0,$t0,2
      sw $v0,str1($t0)
      srl $t0,$t0,2
      addi $t0,$t0,1
      bne $t0,$s0,readstr1
      nop
      
      move $t0,$zero
readstr2:
      li $v0,12
      syscall
      sll $t0,$t0,2
      sw $v0,str2($t0)
      srl $t0,$t0,2
      addi $t0,$t0,1
      bne $t0,$s1,readstr2
      nop
      
      move $t0,$zero
readstring:
      li $v0,12
      syscall
      sll $t0,$t0,2
      sw $v0,string($t0)
      srl $t0,$t0,2
      addi $t0,$t0,1
      bne $t0,$s2,readstring
      nop 
      
      move $t0,$zero
      move $t3,$zero # t3 counts the address of result
loop:
      move $t1,$zero # t1 counts str1
      move $t2,$zero # t2 counts string
compare:
      sll $t1,$t1,2
      sll $t2,$t2,2
      lw $s3,str1($t1)    # s3 = str1[i]
      lw $s4,string($t2)  # s4 = str2[j]
      srl $t1,$t1,2
      srl $t2,$t2,2
      
      addi $t1,$t1,1
      addi $t2,$t2,1
      beq $s3,$s4,compare
      nop
      subi $t1,$t1,1
      bne $t1,$s0,no
      nop
      
      # if (t1 == s0)
      move $t1,$zero
yes:  
      sll $t1,$t1,2
      sll $t3,$t3,2
      lw $s3,str2($t1)
      sw $s3,result($t3)
      srl $t1,$t1,2
      srl $t3,$t3,2
      
      addi $t3,$t3,1
      addi $t1,$t1,1
      bne $t1,$s1,yes
      nop
      addu $t0,$t0,$s0
      j continue
      nop
no:
      sll $t0,$t0,2
      sll $t3,$t3,2
      lw $s3,string($t0)
      sw $s3,result($t3)
      srl $t0,$t0,2
      srl $t3,$t3,2
      addi $t3,$t3,1
continue:
      addi $t0,$t0,1
      subu $t1,$s2,$s0
      addi $t1,$t1,1
      bne $t0,$t1,loop
      nop

print:    
      lw $a0,result
      li $v0,11
      syscall

      li $v0,10
      syscall