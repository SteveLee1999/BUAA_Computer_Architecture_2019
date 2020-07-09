.data
      string: .word 0 : 100
      enter: .ascii "\n"
.text
      li $v0,5
      syscall
      move $t0,$v0         # t0 = n ;
      move $s0,$zero    
read:
      li $v0,12
      syscall
      move $s1,$v0      
      sll $s0,$s0,2
      sw $s1,string($s0)   
      srl $s0,$s0,2
      addi $s0,$s0,1
      bne $s0,$t0,read
      
      move $s0,$zero       #s0 = i; i = 0;
      subi $s1,$t0,1       #s1 = n - i - 1; 
examine:
      sll $s0,$s0,2
      sll $s1,$s1,2
      lw $s2,string($s0)   # s2 = string[i] ;
      lw $s3,string($s1)   # s3 = string[n-i-1] ;
      srl $s0,$s0,2
      srl $s1,$s1,2
      addi $s0,$s0,1
      subi $s1,$s1,1
      bne $s2,$s3,no
      blt $s0,$s1,examine

yes:  
      la $a0,enter
      li $v0,4
      syscall
      li $a0,1
      li $v0,1
      syscall
      li $v0,10
      syscall
no:
      la $a0,enter
      li $v0,4
      syscall
      li $a0,0
      li $v0,1
      syscall
      li $v0,10
      syscall
