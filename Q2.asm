.data
	newLine:		.asciiz	"\n"
	Space:		.asciiz	"\t"
	message:		.asciiz	"Inverse matrix doesn't exit."
	Array:		.word	1, 0, 5
			.word	1, 1, 0
			.word	3, 2, 6
	transp:		.space	36
	D:		.space	4
.text
	main:
		# t0, t1, t2 = Array[0][0], Array[0][1], Array[0][2] / t9 = result / t8 = i
		la	$t0,	Array
		addi	$t1,	$t0,	4
		addi	$t2,	$t0,	8
		li	$t8,	0
		la	$t9,	transp
		# (-) for even indexes
		li	$t3,	1
		li	$t4,	-1
		
		getTransp:
			beq	$t8,	3,	getTranspout	# i = 3 => loopout
			# use 6 registers
			lw	$s0,	0($t1)
			lw	$s1,	12($t1)
			lw	$s2,	24($t1)
			lw	$s3,	0($t2)
			lw	$s4,	12($t2)
			lw	$s5,	24($t2)
			
			mul	$s6,	$s1,	$s5
			mul	$s7,	$s4,	$s2
			sub	$s6,	$s6,	$s7
			# (-) for even indexes
			mul	$s6,	$s6,	$t3
			mul	$t3,	$t3,	$t4
			
			# $s6 -> $f4 -> float -> $f2
			mtc1	$s6,	$f4
			cvt.s.w	$f2,	$f4
			swc1	$f2,	0($t9)

			mul	$s6,	$s0,	$s5
			mul	$s7,	$s3,	$s2
			sub	$s6,	$s6,	$s7
			# (-) for even indexes
			mul	$s6,	$s6,	$t3
			mul	$t3,	$t3,	$t4
			
			# $s6 -> $f4 -> float -> $f2
			mtc1	$s6,	$f4
			cvt.s.w	$f2,	$f4
			swc1	$f2,	4($t9)
		
			mul	$s6,	$s0,	$s4
			mul	$s7,	$s1,	$s3
			sub	$s6,	$s6,	$s7
			# (-) for even indexes
			mul	$s6,	$s6,	$t3
			mul	$t3,	$t3,	$t4
			
			# $s6 -> $f4 -> float -> $f2
			mtc1	$s6,	$f4
			cvt.s.w	$f2,	$f4
			swc1	$f2,	8($t9)
			
			# set Array address
			addi	$t2,	$t1,	4
			la	$t1,	Array
			
			addi	$t8,	$t8,	1	# i = i + 1
			addi	$t9,	$t9,	12	# transp = transp + 12
			# loop
			j	getTransp
			
	getTranspout:
		# get det() / t9 = transp
		la	$t9,	transp
		lwc1	$f2,	0($t9)
		lwc1	$f4,	12($t9)
		lwc1	$f6,	24($t9)
		# a, b, c
		lwc1	$f9,	0($t0)
		lwc1	$f11,	4($t0)
		lwc1	$f13,	8($t0)
		# a, b, c -> float
		cvt.s.w	$f14,	$f13
		cvt.s.w	$f12,	$f11
		cvt.s.w	$f10,	$f9
		
		mul.s	$f2,	$f2,	$f10
		mul.s	$f4,	$f4,	$f12
		mul.s	$f6,	$f6,	$f14
		
		# get D -> f2 = D
		add.s	$f2,	$f2,	$f4
		add.s	$f2,	$f2,	$f6
		
		# store D / s0 = D
		la	$s0,	D
		swc1	$f2,	0($s0)
		
		# if D = 0 , noInverse
		c.eq.s	$f2,	$f0
		bc1t	noInverse
		
		# transp -> transp = result
		# t8 = i = 0 / t9 = transp / f2 = D
		li	$t8,	0
		la	$t9,	transp
		loop:
			beq	$t8,	9,	loopout
			
			lwc1	$f4,	0($t9)
			div.s	$f4,	$f4,	$f2
			swc1	$f4,	0($t9)
			
			li	$v0,	2
			add.s	$f12,	$f0,	$f4
			syscall
			
			# print set
			li	$t7,	3
			div	$t8,	$t7
			mfhi	$t7
			li	$v0,	4
			beq	$t7,	2,	b1
				la	$a0,	Space
				syscall
				j	bout
			b1:
				la	$a0,	newLine
				syscall
			bout:
			
			addi	$t8,	$t8,	1	# i = i + 1
			addi	$t9,	$t9,	4	# trasp = transp + 4
			j	loop
	loopout:
		
	# This is end of the Program
	li	$v0,	10
	syscall
	
	# if D = 0
	noInverse:
		li	$v0,	4
		la	$a0,	message
		syscall
		
		li	$v0,	10
		syscall