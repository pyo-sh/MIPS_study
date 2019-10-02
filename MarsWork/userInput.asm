.data
	prompt:	.asciiz	"Enter your age: "
	message:	.asciiz	"\nYour age is "
.text
	main:
		#	Prompt the user to enter age.
		li	$v0,	4
		la	$a0,	prompt
		syscall
		
		#	Get the user's age
		li	$v0,	5
		syscall
		
		#	Store the result in $t0
		move	$t0,	$v0
		
		#	Display
		li	$v0,	4
		la	$a0,	message
		syscall
		#	Display age
		li	$v0,	1
		move	$a0,	$t0
		syscall
		
	#	This is the end of the Program
	li	$v0,	10
	syscall