.data
	newLine:		.asciiz	"\n"
	Space:		.asciiz	"   "
	Array:		.word	1, 2, 3
			.word	4, 5, 6
			.word	7, 8, 9
	x:		.word	1, 
				2,
				3
.text
	main:
		la	$t0,	Array	# t0 = Array base address
		la	$t1,	x	# t1 = x base address
		la	$t2,	x	# t2 = x base address for print
		# result value loop
		loop:
			beq	$t9,	3	loopout	# t9 = i = 3  => loop out
			
			lw	$a1,	0($t0)
			lw	$a2,	4($t0)
			lw	$a3,	8($t0)
			jal	printArray			# Print Array
			
			jal	printSpace
			
			li	$v0,	1
			lw	$a0,	0($t2)
			syscall				# Print x
			
			jal	printSpace
			
			lw	$t5	0($t0)
			lw	$t6	0($t1)
			mul 	$a0,	$t5, 	$t6
			lw 	$t5 	4($t0)
			lw 	$t6 	4($t1)
			mul 	$t4, 	$t5, 	$t6
			add 	$a0, 	$a0,	 $t4
			lw 	$t5 	8($t0)
			lw 	$t6 	8($t1)
			mul 	$t4,	$t5, 	$t6
			add 	$a0, 	$a0, 	$t4

			li 	$v0, 	1
			syscall 				# Print result
			
			li	$v0,	4
			la	$a0,	newLine
			syscall
			
			addi	$t9,	$t9,	1	# i = i + 1
			addi	$t0,	$t0,	12	# Array address + 12
			addi	$t2,	$t2,	4	# x address + 12
			b	loop
			
		loopout:
	# This is end of the Program
	li	$v0,	10
	syscall
	
	printArray:
		# print 3 arguments( a1, a2, a3 )
		li	$v0,	1
		move	$a0,	$a1
		syscall
		
		li	$v0,	4
		la	$a0,	Space
		syscall
		
		li	$v0,	1
		move	$a0,	$a2
		syscall
		
		li	$v0,	4
		la	$a0,	Space
		syscall

		li	$v0,	1
		move	$a0,	$a3
		syscall
		
		jr	$ra

	printSpace:
		li	$v0,	4
		la	$a0,	Space
		syscall
		syscall
		
		jr	$ra