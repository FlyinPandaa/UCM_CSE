.data 

#Important: calcsum, dropping values, and calculating average doesn't work.

orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100

str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded up) with dropped scores removed: "

#added to complete printArray
space: .asciiz " "
newLine: .asciiz "\n"

.text 

# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for dropped scores).
# It then prints out average score with the specified number of (lowest) scores dropped from the calculation.
main: 
	addi $sp, $sp -4
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	move $s0, $v0	# $s0 = numScores
	move $t0, $0
	la $s1, orig	# $s1 = orig
	la $s2, sorted	# $s2 = sorted
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	# shift left logical (R-format) rd = rt << shamt
	#still 0 > $t0
	sll $t1, $t0, 2 # shift left logical by 2 with 0s
	# rd = rs + rt
	add $t1, $t1, $s1 # add address of array with the address of original array
	# s1 = address of array
	# t1 = original array address 
	li $v0, 5	# Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	move $a0, $s0
	jal selSort	# Call selSort to perform selection sort in original array
	
	li $v0, 4 
	la $a0, str2 
	syscall
	move $a0, $s1	# More efficient than la $a0, orig
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	# More efficient than la $a0, sorted
	jal printArray	# Print sorted scores
	
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	move $a1, $v0
	sub $a1, $s0, $a1	# numScores - drop
	move $a0, $s2
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	
	# Your code here to compute average and print it
	div $v1, $v1, $s0 #get average and put into v1
	
	li $v0, 1
	move $a0, $v1 #load average into a0 and print
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10 
	syscall
	
	
# printList takes in an array and its size as arguments. 
# It prints all the elements in one line with a newline at the end.
printArray:
	# Your implementation of printList here	
	# str2 prints before this "original score:"
	# $a0 and $a1 contain list address and list length
	# what are $t0 and $t1?
	addi $sp, $sp -4
	sw $ra, 0($sp)
	#move $a0, $t1
	
	#a0 = array address
	#a1 = array size
	move $t0, $a0 
	move $t1, $a1 
	
	printLoop:
		lw $a0, 0($t0)
		li $v0, 1
		syscall
	
		addi $t0, $t0, 4 
		addi $t1, $t1, -1
	
		beq $t1, $zero, printEnd 
		j printSpace

	printSpace: 
		la $t2, space
		move $a0, $t2
		li $v0, 4
		syscall
	
		j printLoop
	
	printEnd:
		la $t2, newLine
		move $a0, $t2
		li $v0, 4
		syscall	

		lw $ra, 0($sp) #restore $ra
		addi $sp, $sp 4	

	
	jr $ra
	
	
# selSort takes in the number of scores as argument. 
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	# Your implementation of selSort here
	
	#s1 = address of orginal
	#$s2 = sorted array address 
	#t1 = increments of integers // i++
	#$s0 = numScores
	#t0 = 	i
	#t5 = maxIndex
	#t6 = j
	#t7 = j++
	
 	# i = 0 = t0
       	add        $t0, $0, $0

        beginLoopSelSort1:

            		# i < len
            		slt           $t1, $t0, $a0
            		beq        $t1, $0, endLoopSelSort1

               		# Construct array offset
                       	sll            $t1, $t0, 2

                       # Construct array addresses; t2 = sorted[i], t1 = orig[i]
                       add        $t2, $s2, $t1
                       add        $t1, $s1, $t1

                       # sorted[i] = orig[i]
                       lw           $t1, 0($t1)
                       sw          $t1, 0($t2)

                       # i++
                       addi       $t0, $t0, 1
     			j beginLoopSelSort1

                endLoopSelSort1:

          			# i = 0 = t0
                		add        $t0, $0, $0

                beginLoopSelSort2:

                		# i < len - 1
                		addi       $t1, $a0, -1
                		slt           $t2, $t0, $t1
                		beq        $t2, $0, endLoopSelSort2

               

                               # maxIndex = i = t3
                               add $t3, $t0, $0
                               
				# j = i + 1 = t1
                               addi       $t1, $t0, 1

                               beginLoopSelSort2_1:

                              			# j < len
                                		slt           $t2, $t1, $a0
                                		beq        $t2, $0, endLoopSelSort2_1

     						# Compare sorted[j] = t4, sorted[maxIndex] = t5

                                               add        $t4, $t1, $0
                                               sll        $t4, $t4, 2
                                               add        $t4, $t4, $s2
                                               lw         $t4, 0($t4)
                                               add        $t5, $t3, $0
                                               sll        $t5, $t5, 2
                                               add        $t5, $t5, $s2
                                               lw         $t5, 0($t5)

                                                ifSelSort:

                                                	slt           $t4, $t5, $t4
                                                	beq        $t4, $0, endIfSelSort
                                                	
                                                      # update max
                                                      add        $t3, $t1, $0

                                      		endIfSelSort:
                       					 # j++

                                                	addi       $t1, $t1, 1
                                                	
							j beginLoopSelSort2_1

                                endLoopSelSort2_1:

    						# Swap [max = t3] = t1 and [i = t4] = t2

                                		sll            $t3, $t3, 2
                                		add        $t3, $t3, $s2

                                		add        $t4, $t0, $0
                                		sll        $t4, $t4, 2
                                		add        $t4, $t4, $s2

                                		lw           $t1, 0($t3)
                               			lw           $t2, 0($t4)
                                		sw          $t2, 0($t3)
                                		sw          $t1, 0($t4)

                                		# i++
                                		addi       $t0, $t0, 1

     		j beginLoopSelSort2

                endLoopSelSort2:

               	jr $ra
	
	
# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	#v1 = sum
	
	# Your implementation of calcSum here
	# str5 prints here
	
	li $v0, 4 
	la $a0, str5
	syscall 
	
	#s0 should be length -1 
	subi $s0, $s0, 1
	
	sumr:
		li	$t0, 1
     	 	bge	$s0, $t0, rec	# if (n > 1) then recurse
		lw	$t0,0($v0)		# Base case:
		move	$v1,$t0		# return s=A[0]
      		jr	$ra
	
	rec:
		sub	$sp,$sp,12		# push stack
		sw	$ra,0($sp)		# save $ra
		sw	$a0,4($sp)		# save argument registers
		sw	$a1,8($sp)

      		addi	$s2,$s2,4		# point to next element in array
		addi	$s0,$s0,-1		# n = n - 1
		jal	sumr			# recursively call sumr

		lw	$s2, 4($sp)		# restore $a0 to original address of A
		lw	$t0, 0($s2)		# load A[0]
		add	$v1,$s2,$s0		# s = s + sumr(A+4,n-1)

		lw	$ra, 0($sp)		# restore $ra
		lw	$a1, 8($sp)
		add	$sp, $sp, 12		# pop stack
		jr	$ra			# return to calling function
	
	
	
	jr $ra
	
