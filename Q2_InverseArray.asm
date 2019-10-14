.data
	message:	.asciiz	"InverseArray\n"
	newLine:	.asciiz	"\n"
	Tab:		.asciiz	"\t"
	noInverseMSG:	.asciiz	"Inverse matrix doesn't exist."
	Array:		.word	1, 0, 5
			.word	1, 1, 0
			.word	3, 2, 6
	transp:		.space	36
.text
	main:
		la	$t0,	Array		# t0 = Array[0][0]
		addi	$t1,	$t0,	4	# t1 = Array[0][1]
		addi	$t2,	$t1,	4	# t2 = Array[0][2]
		li	$t8,	0		# t8 = i
		la	$t9,	transp		# t9 = transp
		li	$t3,	1	# for mul (-) to even indexes
		# getTransp loop
		# for(t8 = 0; t8 != 3; t8++)
		getTransp:
			beq	$t8,	3,	getTranspout	# i = 3 => loopout
			
			# Array[][t1/4]
			lw	$s0,	0($t1)		# Array[0][t1/4]
			lw	$s1,	12($t1)		# Array[1][t1/4]
			lw	$s2,	24($t1)		# Array[2][t1/4]
			# Array[][t2/4]
			lw	$s3,	0($t2)		# Array[0][t2/4]
			lw	$s4,	12($t2)		# Array[1][t2/4]
			lw	$s5,	24($t2)		# Array[2][t2/4]
			
			# t3(1 or -1) * det(Array[0][t8])
			mul	$s6,	$s1,	$s5
			mul	$s7,	$s4,	$s2
			sub	$s6,	$s6,	$s7
			mul	$s6,	$s6,	$t3	# (-) to even indexes
			mul	$t3,	$t3,	-1	# -1 * t3
			# det(Array[0][t8]) -> $f4 -> float -> $f2
			mtc1	$s6,	$f4
			cvt.s.w	$f2,	$f4
			swc1	$f2,	0($t9)
			
			# t3(1 or -1) * det(Array[1][t8])
			mul	$s6,	$s0,	$s5
			mul	$s7,	$s3,	$s2
			sub	$s6,	$s6,	$s7
			mul	$s6,	$s6,	$t3	# (-) to even indexes
			mul	$t3,	$t3,	-1	# -1 * t3
			# det(Array[1][t8]) -> $f4 -> float -> $f2
			mtc1	$s6,	$f4
			cvt.s.w	$f2,	$f4
			swc1	$f2,	4($t9)
			
			# t3(1 or -1) * det(Array[2][t8])
			mul	$s6,	$s0,	$s4
			mul	$s7,	$s1,	$s3
			sub	$s6,	$s6,	$s7
			mul	$s6,	$s6,	$t3	# (-) to even indexes
			mul	$t3,	$t3,	-1	# -1 * t3
			# det(Array[2][t8]) -> $f4 -> float -> $f2
			mtc1	$s6,	$f4
			cvt.s.w	$f2,	$f4
			swc1	$f2,	8($t9)
			
			# set Array address
			addi	$t2,	$t1,	4	# t2 = t1 + 4
			la	$t1,	Array		# t1 = Array
			addi	$t9,	$t9,	12	# transp = transp + 12
			addi	$t8,	$t8,	1	# i = i + 1
		j	getTransp
		getTranspout:
		
		# det(Array) = Array[0]*transp[0] + Array[1]*transp[3] + Array[2]*transp[6]
		lwc1	$f2,	transp+0	# transp[0]
		lwc1	$f4,	transp+12	# transp[3]
		lwc1	$f6,	transp+24	# transp[6]
		lwc1	$f9,	Array+0		# Array[0]
		lwc1	$f11,	Array+4		# Array[1]
		lwc1	$f13,	Array+8		# Array[2]
		# Array[1, 2, 3] -> float
		cvt.s.w	$f14,	$f13
		cvt.s.w	$f12,	$f11
		cvt.s.w	$f10,	$f9
		# get det(Array)
		mul.s	$f2,	$f2,	$f10
		mul.s	$f4,	$f4,	$f12
		mul.s	$f6,	$f6,	$f14
		add.s	$f2,	$f2,	$f4
		add.s	$f2,	$f2,	$f6
		# if (det(Array) == 0)   /   noInverse
		c.eq.s	$f2,	$f0
		bc1t	noInverse
		
		li	$v0,	4
		la	$a0,	message		# Print message
		syscall
		# resultLoop (transp -> result)
		# for(t8 = 0; t8 != 9; t8++)   /   f2 = det(Array)
		li	$t8,	0		# t8 = i = 0 
		la	$t9,	transp		# t9 = transp
		resultLoop:
			beq	$t8,	9,	resultLoopout	# i = 9 => loopout
			
			# transp[t9/4] / det(Array) = result
			lwc1	$f4,	0($t9)
			div.s	$f4,	$f4,	$f2
			swc1	$f4,	0($t9)
			
			# print Result
			li	$v0,	2
			add.s	$f12,	$f0,	$f4
			syscall
			# if( t8 % 3 == 2 ), print New Line / else, print Tab
			li	$t7,	3
			div	$t8,	$t7
			mfhi	$t7
			li	$v0,	4
			beq	$t7,	2,	printNewLine
				la	$a0,	Tab
				syscall
				j	noNewLine
			printNewLine:
				la	$a0,	newLine
				syscall
			noNewLine:
			
			addi	$t8,	$t8,	1	# i = i + 1
			addi	$t9,	$t9,	4	# trasp = transp + 4
		j	resultLoop
		resultLoopout:
		
	# This is end of the Program
	li	$v0,	10
	syscall
# ---------------------------------------------------------------------------------
	noInverse:	# if D = 0, Can't get Inverse of Array
		li	$v0,	4
		la	$a0,	noInverseMSG
		syscall
	li	$v0,	10
	syscall