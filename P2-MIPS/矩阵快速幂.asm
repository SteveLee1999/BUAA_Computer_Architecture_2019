############################
# result = matrix(mXm) ^ n #
############################
.data
matrix: .word 0:1000
temp: .word 0:1000
space: .asciiz " "
enter: .asciiz "\n"
mark: .asciiz "again\n"
.text
      li $v0,5
      syscall              
      move $s0,$v0                  # $s0 = n
      li $v0,5
      syscall
      move $s1,$v0                  # $s1 = m
      mult $s1,$s1
      mflo $s2                      # $s2 = m^2
      
      move $t0,$zero
scanf:
      li $v0,5
      syscall
      sll $t0,$t0,2
      sw $v0,matrix($t0)
      srl $t0,$t0,2
      addi $t0,$t0,1
      bne $t0,$s2,scanf
      nop

      move $t0,$s0 
      li $t2,2                     # $t2 = 2
loop: 
      move $t3,$zero               # $t3 = i
      move $t4,$zero               # $t4 = j
      move $t5,$zero               # $t5 = k
      move $s3,$zero               # $s3 = temp[i][j]
      move $s6,$zero               # $s6 counts the address
multiply:
      mult $t3,$s1
      mflo $t6
      addu $t6,$t6,$t5
      sll $t6,$t6,2
      lw $s4,matrix($t6)             # $s4 = matrix[i][k]
      
      mult $t5,$s1
      mflo $t6
      addu $t6,$t6,$t4
      sll $t6,$t6,2
      lw $s5,matrix($t6)             # $s5 = matrix[k][j]
      
      mult $s4,$s5
      mflo $s4
      addu $s3,$s3,$s4
      
      addi $t5,$t5,1
      bne $t5,$s1,multiply
      nop 
      
      sll $s6,$s6,2
      sw $s3,temp($s6)       # store $s3 into temp[i][j]
      srl $s6,$s6,2
      addi $s6,$s6,1
                          
      move $s3,$zero
      move $t5,$zero
      addi $t4,$t4,1
      bne $t4,$s1,multiply
      nop
      
      move $t4,$zero
      addi $t3,$t3,1
      bne $t3,$s1,multiply
      nop
      
      move $t3,$zero
remove:
      sll $t3,$t3,2
      move $t4,$zero
      lw $t4,temp($t3)
      sw $t4,matrix($t3)
      srl $t3,$t3,2
      addi $t3,$t3,1
      bne $t3,$s2,remove
      nop
      
      subi $t0,$t0,1                                
      bnez $t0,loop
      
      
      move $t0,$zero
      move $t1,$zero
      move $t2,$zero
print:
      sll $t2,$t2,2
      lw $a0,matrix($t2)
     
      li $v0,1
      syscall
      la $a0,space
      li $v0,4
      syscall
      
      srl $t2,$t2,2
      addi $t2,$t2,1
      
      
      addi $t1,$t1,1
      bne $t1,$s1,print
      nop
      
      la $a0,enter
      li $v0,4
      syscall
      
      move $t1,$zero
      addi $t0,$t0,1
      bne $t0,$s1,print
      nop
