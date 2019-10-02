.data
	message:	.asciiz	"Enter the value of PI : "
	zeroAsFloat:	.float	0.0
.text
	main:
		lwc1	$f4,	zeroAsFloat
		
		#	Display message
		li	$v0,	4
		la	$a0,	message
		syscall
		
		#	read User's Input
		li	$v0,	6
		syscall
		
		#	Display value
		li	$v0,	2
		add.s	$f12,	$f0,	$f4
		syscall
	
	#	This is end of the Program
	li	$v0	10
	syscall