.data
	myArray:	.space	12
	newLine:	.asciiz	"\n"
	message:	.asciiz	"This is end of the Program"
.text
	main:
		addi	$s0,	$zero,	4
		addi	$s1,	$zero,	10
		addi	$s2,	$zero,	12
		
		#	Index = $t0
		addi	$t0,	$zero,	0
		#	Store data in Array
		sw	$s0,	myArray($t0)
			addi	$t0,	$t0,	4
		sw	$s1,	myArray($t0)
			addi	$t0,	$t0,	4
		sw	$s2,	myArray($t0)
		
		#	Clear $t0 for index
		addi $t0,	$zero,	 0
		
		while:
			beq	$t0,	12,	exit
			
			li	$v0,	1
			lw	$a0,	myArray($t0)
			syscall
			
			#	Print a new Line
			li	$v0,	4
			la	$a0,	newLine
			syscall
			
			addi	$t0,	$t0,	4
			
			j	while
		
		exit:
			li	$v0,	4
			la	$a0,	message
			syscall
		
	#	This is end of the Program
	li	$v0,	10
	syscall