.data
	message:	.asciiz	"Hello, "
	userInput:	.space	20
.text
	main:
		#	Get Text from user
		li	$v0,	8
		la	$a0,	userInput
		li	$a1,	20
		syscall
		
		#	Display message
		li	$v0,	4
		la	$a0,	message
		syscall
		
		#	Display Text
		li	$v0,	4
		la	$a0,	userInput
		syscall
		
	#	This is end of the program
	li	$v0,	10
	syscall