		.data
x:		.word 2
y:		.word 3
z:		.word 4
p:		.word 0
q:		.word 0
text:  .asciiz "Enter a number: "

		.text
MAIN:
	# set x, y, and z into s0, s1, and s2 respectively
	la $t0 x
	lw $s0 0($t0)
	la $t0 y
	lw $s1 0($t0)
	la $t0 z
	lw $s2 0($t0)
	
	#set s0, s1, and s2 as input arguments
	add $a0 $zero $s0
	add $a1 $zero $s1
	add $a2 $zero $s2

	#jumps and links to main
	jal FOO
	
	
	add $t0, $s1, $s0
	add $t0, $t0, $s2
	add $s1, $t0, $v0
	addi $a0, $s1, 0 
	li $v0, 1		 
	syscall
	
	#jump to the end
	j END
	
FOO:
	#saves jump location and values so that the nested function can work correctly (even numbers)
	addi $sp $sp -24
	sw $ra, 20($sp)
	sw $a0, 16($sp)
	sw $a1, 12($sp)
	sw $a2, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	#load and write addresses for p and q
	la $t0, p
	lw $s0, 0($t0)		
	la $t0, q
	lw $s1, 0($t0)	
	
	#sets the input values for BAR (addition)
	add $t0, $a0, $a1
	add $t1, $a1, $a2
	add $t2, $a2, $a0
	
	#sets the input values for BAR (subtraction)
	sub $t3, $a0, $a2
	sub $t4, $a1, $a0
	mul $t5, $a1, 2
	
	#update a0 as new argument for SUB
	add $a0, $0, $t0
	add $a1, $0, $t1
	add $a2, $0, $t2
	jal BAR	
	add $s0, $0, $v0
	
	#jumps to BAR for q and places the link in $ra
	add $a0, $0, $t3
	add $a1, $0, $t4
	add $a2, $0, $t5
	jal BAR
	add $s1, $0, $v0
	add $v0, $s0, $s1
	
	#replaces the jump location and values so that the function leads to the right place and has previous values to work with
	lw $ra, 20($sp)
	lw $a0, 16($sp)
	lw $a1, 12($sp)
	lw $a2, 8($sp)
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 24
	jr $ra	

BAR:
	#bar function
	sub $t0, $a2, $a0
	sllv $v0, $t0, $a1
	jr $ra
	
END:
	li $v0, 10
	syscall
