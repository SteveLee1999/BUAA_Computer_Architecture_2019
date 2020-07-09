data:.word 0:256
.text
      li $t0,16           # $t0 = number of rows
      li $t1,16           # $t1 = number of columns
      move $s0,$zero      # $s0 = row counter
      move $s1,$zero      # $s1 = column counter
      move $t2,$zero      # $s2 = the value to be stored

loop: 
      mult $s0,$t1         
      mflo $s2            # $s2=$s0*$t1; 
      add $s2,$s2,$s1     # $s2+=$s1;
      sll $s2,$s2,2       # $s2*=4;
      sw $t2,data($s2)    # address = data + $s2
      addi $t2,$t2,1
      addi $s1,$s1,1
      bne $s1,$t1,loop
      
      move $s1,$zero
      addi $s0,$s0,1
      bne $s0,$t0,loop
      
      li $v0,10
      syscall  