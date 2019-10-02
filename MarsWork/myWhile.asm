.data
	message:	.asciiz	"\nAfter while loop is done."
	space:	.asciiz	", "
.text
#	Code will be like this.
#	int i = 0
#	while( i < 10 ){
#		i++	}
	main:
		# not needed, $t0 = i = 0
		addi	$t0,	$zero,	0
		
		while:
			bgt	$t0,	10,	exit
			jal	printNumber
			# i++
			addi	$t0,	$t0,	1
				
			j	while
			
		exit:
			li	$v0,	4
			la	$a0,	message
			syscall
		
	#	This is end of the Program
	li	$v0,	10
	syscall
	
	printNumber:
		li	$v0,	1
		add	$a0,	$t0,	$zero
		syscall
		
		li	$v0,	4
		la	$a0,	space
		syscall
		
		jr	$ra