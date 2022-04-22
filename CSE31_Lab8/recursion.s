        .data

# TPS 2 #3 (input prompt to be displayed)
str1:	.asciiz "Please enter a number: "

        .text
main: 		# Moving stack pointer to make room for storing local variables (push the stack frame)
		addi $sp, $sp, -4	
		# TPS 2 #3 (display input prompt)
		la $a0 str1
		li $v0 4
		syscall
		
		# TPS 2 #4 (read user input)
		li $v0 5
		syscall
		addi $a0 $v0 0
		# Call recursion(x)
		jal recursion
		
		# TPS 2 #6 (print out returned value)
		addi $a0 $v0 0
		li $v0 1
		syscall
		# Jump to end of program
		j end		


# Implementing recursion
recursion:	# Push stack frame for local storage
		addi $sp, $sp, -12	

		# TPS 2 #7 
		sw $ra 0($sp)
		sw $v0 4($sp)
				
		addi $t0, $a0, 1
		bne $t0, $zero, not_minus_one
		
		# TPS 2 #8 (update returned value)
		li $v0 1
		j end_recur
			
not_minus_one:	bne $a0, $zero, not_zero

		# TPS 2 #9 (update returned value)
		li $v0 3
		j end_recur		

not_zero:	sw $a0, 8($sp) 	
		# TPS 2 #11 (Prepare new input argument, i.e. m - 2)
		addi $a0 $a0 -2
		# Call recursion(m - 2)
		jal recursion	
		
		# TPS 2 #12 
		sw $v0 4($sp)
		
		# TPS 2 #13 (Prepare new input argument, i.e. m - 1)
		lw $a0 8($sp)
		addi $a0 $a0 -1
		# Call recursion(m - 1)
		jal recursion	
		
		# TPS 2 #14 (update returned value)
		lw $t0 4($sp)
		add $v0 $t0 $v0
		
		j end_recur
		

# End of recursion function	
end_recur:	# TPS 2 #15 
		lw $ra 0($sp)
		# Pop stack frame 
		addi $sp, $sp, 12	
		jr $ra

# Terminating the program
end:	addi $sp, $sp 4	
	# Moving stack pointer back (pop the stack frame)
	li $v0, 10 
	syscall