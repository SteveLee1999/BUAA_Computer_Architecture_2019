.data
matrix1:.word  0 : 100
matrix2:.word  0 : 100
product:.word  0 : 100
space:.asciiz " "
enter:.asciiz "\n"
.text
      li $v0,5
      syscall
      move $t0,$v0         # $t0 = n 
      mult $t0,$t0
      mflo $t4             # $t4 = n^2

# read the two matrix     
      move $s0,$zero
loop1:
      li $v0,5
      syscall
      sll $s0,$s0,2
      sw $v0,matrix1($s0)
      srl $s0,$s0,2
      addi $s0,$s0,1
      bne $s0,$t4,loop1
      
      move $s0,$zero
loop2:
      li $v0,5
      syscall
      sll $s0,$s0,2
      sw $v0,matrix2($s0)
      srl $s0,$s0,2
      addi $s0,$s0,1
      bne $s0,$t4,loop2
      
# now begin to multiply
      move $s0,$zero      # $s0 = i 
      move $s1,$zero      # $s1 = j 
      move $s2,$zero      # $s2 = k 
      move $s3,$zero      # $s3 counts the address
      move $t3,$zero      # $t3 stores the value
loop: 
      move $s4,$zero      # use $s4 repeatedly
      mult $s0,$t0      
      mflo $s4
      add $s4,$s4,$s2
      sll $s4,$s4,2
      lw $t1,matrix1($s4) # t1 = matrix1[i][k]
      
      move $s4,$zero
      mult $s2,$t0
      mflo $s4
      add $s4,$s4,$s1
      sll $s4,$s4,2
      lw $t2,matrix2($s4) # t2 = matrix2[k][j]
      
      mult $t1,$t2
      mflo $s4            
      add $t3,$t3,$s4
      
      addi $s2,$s2,1
      move $t1,$zero
      move $t2,$zero
      bne $s2,$t0,loop
      # store t3 to product
      sll $s3,$s3,2
      sw $t3,product($s3)
      srl $s3,$s3,2
      addi $s3,$s3,1
      move $t3,$zero
      
      move $s2,$zero
      addi $s1,$s1,1
      bne $s1,$t0,loop

      move $s1,$zero
      addi $s0,$s0,1
      bne $s0,$t0,loop
      
      move $s0,$zero
      move $s1,$zero
print:
      mult $s1,$t0
      mflo $s2
      add $s2,$s2,$s0
      sll $s2,$s2,2
      lw $a0,product($s2)
      li $v0,1
      syscall
      la $a0,space
      li $v0,4
      syscall 
      addi $s0,$s0,1
      bne $s0,$t0,print
      
      la $a0,enter
      li $v0,4
      syscall
      move $s0,$zero
      addi $s1,$s1,1
      bne $s1,$t0,print
      
      li $v0,10
      syscall