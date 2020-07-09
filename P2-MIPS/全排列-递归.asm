.data
array:.word 0:200            # array stores a sequence uf 1 - n
symbol:.word 0:200 
mark:.asciiz "arrival!"   
enter:.asciiz "\n"
space:.asciiz " "
.text     
      li $v0,5
      syscall
      move $a1,$v0            # a1 = n
      move $s0,$zero
initialize:
      sll $s0,$s0,2
      sw $zero,symbol($s0)
      sw $zero,array($s0)
      srl $s0,$s0,2
      addi $s0,$s0,1
      bne $s0,$a1,initialize
      
      move $a2,$zero
      j first_time
      nop
full_array:                   # full_array(index) 
      subi $sp,$sp,4
      sw $ra,0($sp) 
first_time:
      move $s0,$zero          # i = 0
      move $s3,$a2
      bne $a1,$s3,for  
      # if(index==n)       
print:
      sll $s0,$s0,2
      lw $a0,array($s0)
      li $v0,1
      syscall
      la $a0,space
      li $v0,4
      syscall
      srl $s0,$s0,2
      addi $s0,$s0,1
      bne $s0,$a1,print
      
      la $a0,enter
      li $v0,4
      syscall
      lw $ra,0($sp)
      addi $sp,$sp,4
      jr $ra
      nop
for:
      sll $s0,$s0,2               # $s0 = i
      lw $s1,symbol($s0)
      srl $s0,$s0,2
      bne $s1,$zero,continue
      #if(symbol[i]==0)
      addi $t0,$s0,1              # $t0 = i+1
      sll $s3,$s3,2
      sw $t0,array($s3)           # array[index] = i+1
      srl $s3,$s3,2 
      
      sll $s0,$s0,2
      li $t1,1
      sw $t1,symbol($s0)          # symbol[i] = 1
      srl $s0,$s0,2
   
      addi $a2,$s3,1
      subi $sp,$sp,8             # use the stack
      sw $s3,4($sp)
      sw $s0,0($sp)
      jal full_array                # full_array(index+1)
      nop
      
      lw $s0,0($sp)
      lw $s3,4($sp)
      addi $sp,$sp,8
      sll $s0,$s0,2
      sw $zero,symbol($s0)          # symbol[i] = 0
      srl $s0,$s0,2
continue:
      addi $s0,$s0,1
      bne $s0,$a1,for
      
      beq $s3,$zero,end
      lw $ra,0($sp)
      addi $sp,$sp,4
      jr $ra
      nop
end:
      li $v0,10
      syscall
