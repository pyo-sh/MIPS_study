.data
	newLine:	.asciiz	"\n"
	Tab:		.asciiz	"\t"
	Line:		.asciiz "\t|\t"
	Line2:		.asciiz	"|\t"
	Equals:		.asciiz	"\t|\t=\t"
	Array:		.word	1, 2, 3
			.word	4, 5, 6
			.word	7, 8, 9
	x:		.word	1, 
				2,
				3
.text
	main:
		la	$t0,	Array	# t0 = Array base address
		la	$t1,	x	# t1 = x base address for print
		lw	$s0	0($t1)	# s0 = x[0]
		lw	$s1	4($t1)	# s1 = x[1]
		lw	$s2	8($t1)	# s2 = x[2]
		# Loop
		# for(t2 = 0; t2 != 3; t2++)
		move	$t2,	$zero
		Loop:
			# t2 == 3 => Loopout
			beq	$t2,	3,	Loopout
			# Print Array[t0][0], Array[t0][1], Array[t0][2]
			lw	$a1,	0($t0)	# a1 = Array[t0][0]
			lw	$a2,	4($t0)	# a2 = Array[t0][1]
			lw	$a3,	8($t0)	# a3 = Array[t0][2]
			jal	printArray
			# Print Line
			li	$v0,	4
			la	$a0,	Line
			syscall
			la	$a0,	Line2
			syscall
			# Print x
			li	$v0,	1
			lw	$a0,	0($t1)
			syscall	
			# Print Tab
			li	$v0,	4
			la	$a0,	Equals
			syscall
			# Print result
			mul 	$a0,	$a1, 	$s0	# x[0] * Array[t0][0]
			mul 	$t9, 	$a2, 	$s1	# x[1] * Array[t0][1]
			add 	$a0, 	$a0,	$t9
			mul 	$t9,	$a3, 	$s2	# x[2] * Array[t0][2]
			add 	$a0, 	$a0, 	$t9	# total Add
			li 	$v0, 	1
			syscall
			# Print newLine
			li	$v0,	4
			la	$a0,	newLine
			syscall
			
			addi	$t2,	$t2,	1	# t2++
			addi	$t0,	$t0,	12	# Array address + 12
			addi	$t1,	$t1,	4	# x address + 4
			j	Loop
		Loopout:
		
	# This is end of the Program
	li	$v0,	10
	syscall
# ---------------------------------------------------------------------------------
	printArray:	# printArray( a1, a2, a3 )   /   print 3 arguments
		li	$v0,	4
		la	$a0,	Line
		syscall
		li	$v0,	1
		move	$a0,	$a1
		syscall
		li	$v0,	4
		la	$a0,	Tab
		syscall
		li	$v0,	1
		move	$a0,	$a2
		syscall
		li	$v0,	4
		la	$a0,	Tab
		syscall
		li	$v0,	1
		move	$a0,	$a3
		syscall
	jr	$ra