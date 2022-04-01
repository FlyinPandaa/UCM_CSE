.data
#declare variables
n:  .word 0
str: .asciiz "Please enter a number\n"
str1:	.asciiz "Sum of even numbers\n"
str2:	.asciiz "\nSum of odd numbers\n"

.text

main:
	lw $t0, n
	li $v0, 1

loop:
	beq $v0, $zero, end
	#load and print prompt
	li $v0, 4
	la $a0, str
	syscall
	#read integer
	li $v0, 5
	syscall
	#Checks whether remainder is 0 or 1
	add $s0, $v0, $0
	#checks if remainders is 0 or 1
	rem $t1, $s0, 2 
	#if remainder equals to 1 then it is even sums and jumps there
	beq $t1, $0, Even_sums
	#if remainder equals to 2 then it is odd and jumps there
	bne $t1, $0, Odd_sums
	#loop back to top if didn't branch
	
Even_sums:
	#Add evens
	add $t3, $t3, $s0
	j loop

Odd_sums:
	#Add odds
	add $t4, $t4, $s0
	j loop
	
end:
	#Output even nums
	li $v0, 4	
	la $a0, str1
	syscall
	li $v0, 1
	la $a0, ($t3)
	syscall
	
	#Output odd nums
	li $v0, 4
	la $a0, str2
	syscall
	li $v0, 1
	la $a0, ($t4)
	syscall
	
	#Exit
	li $v0, 10
	syscall