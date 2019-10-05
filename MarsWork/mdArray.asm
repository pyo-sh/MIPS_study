.data
	mdArray:	.word	2, 5	# 1st row
			.word	3, 7	# 2rd row
	size:		.word	2	# 2x2 matrix
	.eqv	DATA_SIZE	4
.text
	main:
		la	$a0,	mdArray	# a0 = parameter of argument / base address
		lw	$a1,	size	# 
		jal	sumDiagonal
		
		move	$a0,	$v0	# v0 = result value / store a0 for display
		li	$v0,	1
		syscall
		
	#	This is end of the Program
	li	$v0,	10
	syscall
	
	sumDiagonal:
		li	$v0,	0	# sum = 0
		li	$t0,	0	# t0 = index
		
		sumLoop:
			mul	$t1,	$t0,	$a1	# t1 = rowIndex * colSize
			add	$t1,	$t1,	$t0	# 	 		+ colIndex
			mul	$t1,	$t1,	DATA_SIZE	# 		* DATA_SIZE
			add	$t1,	$t1,	$a0	# + baseaddress
			
			lw	$t2,	0($t1)
			add	$v0,	$v0,	$t2	# sum = sum + mdArray[i][i]
			
			addi	$t0,	$t0,	1	# i = i + 1
			blt	$t0,	$a1,	sumLoop	# i < size => loop
			
		jr	$ra
