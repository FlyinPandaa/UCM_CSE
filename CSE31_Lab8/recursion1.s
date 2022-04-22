        .data

str1:    .asciiz "Please enter a number: "

        .text
main: 	
	addi $sp, $sp, -4
	#print out str1
        la $a0, str1
        li $v0, 4
        syscall
	#Read input	
        li $v0, 5
        syscall
        add $a0, $0, $v0
	#jump and link to recursion	
	jal rec
	#print out final result	
	add $a0, $0, $v0
        li $v0, 1
        syscall
	j end


rec:	
	addi $sp, $sp, -12
	#store 2 integers
        sw $ra, 0($sp)
        sw $v0, 4($sp)
	#if not equal to ten, branch to notTen
	bne $a0, 10, notTen
	#jump to end recursion	
        li $v0, 2
	j end_recur
			
notTen: #if not equal to eleven, branch to notEleven
	bne $a0, 11, notEleven
	#jump to end recursion
	li $v0, 1
	j end_recur

notEleven:	
	sw $a0, 8($sp)
	addi  $a0, $a0, 2
	add $v0, $a0, $0
		
	jal rec
		
        sw $v0, 4($sp)
		
	lw $a0, 8($sp)
	addi $a0, $a0, 1
		
	jal rec
	#load word and add numbers
	lw $t0, 8($sp)
	lw $t1, 4($sp)
        add $v0, $t0, $v0
        add $v0, $t1, $v0
		
	j end_recur
		
end_recur:
	#stops recursion
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	#jump to last address
	jr $ra

end:	#end program
	addi $sp, $sp 4
	li $v0, 10
	syscall