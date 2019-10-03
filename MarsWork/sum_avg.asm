.data
	array:	.word	10, 2, 9
	length:	.word	3
	sum:	.word	0
	average:.word	0
.text
	main:
		la	$t0,	array	# Base address
		li	$t1,	0	# i = 0
		lw	$t2,	length	# get length in t2
		li	$t3,	0	# t3 = sum
		
		sumLoop:
			lw	$t4,	($t0)		# t4 = array[i]
			add	$t3,	$t3,	$t4	# sum = sum + array[i]
			
			add	$t1,	$t1,	1	# i = i + 1
			add	$t0,	$t0,	4	# address + 4 
			blt	$t1,	$t2,	sumLoop	# i < length => loop
		
		sw	$t3,	sum
		
		# calculate the average.
		div	$t5,	$t3,	$t2
		sw	$t5,	average
		
		# Display average
		li	$v0,	1
		move	$a0,	$t5
		syscall
		
	# This is end of the Program
	li	$v0,	10
	syscall