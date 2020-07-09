.data
matrix:.word 0:1000
core:.word 0:1000
result:.word 0:1000
space:.asciiz " "
enter:.asciiz "\n"
.text
      li $v0,5
      syscall
      move $t0,$v0          # $t0 = m1
      li $v0,5          
      syscall
      move $t1,$v0          # $t1 = n1
      li $v0,5
      syscall
      move $t2,$v0          # $t2 = m2
      li $v0,5
      syscall
      move $t3,$v0          # $t3 = n2
# read the matrix and core   
      mult $t0,$t1
      mflo $t4            
      move $s0,$zero
loop1:
      li $v0,5
      syscall
      sll $s0,$s0,2
      sw $v0,matrix($s0)
      srl $s0,$s0,2
      addi $s0,$s0,1
      bne $s0,$t4,loop1
      
      mult $t2,$t3
      mflo $t4
      move $s0,$zero
loop2:
      li $v0,5
      syscall
      sll $s0,$s0,2
      sw $v0,core($s0)
      srl $s0,$s0,2
      addi $s0,$s0,1
      bne $s0,$t4,loop2
# now begin to calculate
      sub $t4,$t0,$t2       
      addi $t4,$t4,1        # $t4 = m1 - m2 + 1
      sub $t5,$t1,$t3       
      addi $t5,$t5,1        # $t5 = n1 - n2 + 1
      move $s0,$zero        # $s0 = i 
      move $s1,$zero        # $s1 = j 
      move $s2,$zero        # $s2 = k 
      move $s3,$zero        # $s3 = s
      move $s5,$zero        # $s5 counts the address
      move $t6,$zero        # $t6 stores the value
loop: 
      move $s4,$zero        # use $s4 repeatedly
      add $s4,$s0,$s2
      mult $s4,$t1
      mflo $s4
      add $s4,$s4,$s1
      add $s4,$s4,$s3
      sll $s4,$s4,2
      lw $t7,matrix($s4)    # $t7 = matrix[i+k][j+s]
      
      move $s4,$zero
      mult $s2,$t3
      mflo $s4
      add $s4,$s4,$s3
      sll $s4,$s4,2
      lw $t8,core($s4)      # $t8 = core[k][s]
      
      mult $t7,$t8
      mflo $s4
      add $t6,$t6,$s4
      
      addi $s3,$s3,1
      bne $s3,$t3,loop
 
      move $s3,$zero
      addi $s2,$s2,1
      bne $s2,$t2,loop
# stores a value
      sll $s5,$s5,2
      sw $t6,result($s5)
      srl $s5,$s5,2
      addi $s5,$s5,1
      move $t6,$zero
      
      move $s2,$zero
      addi $s1,$s1,1
      bne $s1,$t5,loop

      move $s1,$zero
      addi $s0,$s0,1
      bne $s0,$t4,loop
      
      move $s0,$zero            # $s0 = i
      move $s1,$zero            # $s1 = j
print:
      move $s4,$zero
      mult $s0,$t5
      mflo $s4
      add $s4,$s4,$s1
      sll $s4,$s4,2
      lw $a0,result($s4)
      li $v0,1
      syscall
      la $a0,space
      li $v0,4
      syscall
      
      addi $s1,$s1,1
      bne $s1,$t5,print
      
      la $a0,enter
      li $v0,4
      syscall
      
      move $s1,$zero
      addi $s0,$s0,1
      bne $s0,$t4,print
      
      li $v0,10
      syscall
