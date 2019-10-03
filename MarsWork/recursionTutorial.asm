.data
	promptMessage:	.asciiz	"Enter a number to find its factorial: "
	resultMessage:	.asciiz	"\nThe factorial of the number is "
	theNumber:	.word	0
	theAnswer:	.word	0
.text
	.globl main
	main:
		# Read the number from the user
		li	$v0,	4
		la	$a0,	promptMessage
		syscall
		
		li	$v0,	5
		syscall
		
		sw	$v0,	theNumber
		
		# Call the Factorial Function
		lw	$a0,	theNumber
		jal	findFactorial
		sw	$v0,	theAnswer
		
		# Display the results
		li	$v0,	4
		la	$a0,	resultMessage
		syscall
		
		li	$v0,	1
		lw	$a0,	theAnswer
		syscall
		
	#	This is end of the Program
	li	$v0,	10
	syscall
	
#------------------------------------------------------
#	findFactoral function
.globl findFactorial
findFactorial:
	#	Store in Stack, return address and local variables
	subu	$sp,	$sp,	8
	sw	$ra,	0($sp)
	sw	$s0,	4($sp)
	
	# Base case
	li	$v0,	1
	beq	$a0,	$zero,	factorialDone
	
	# findFactorial(theNumber - 1)
	move	$s0,	$a0
	sub	$a0,	$a0,	1
	jal	findFactorial
	
	mul	$v0,	$s0,	$v0
	
	factorialDone:
		lw	$ra,	($sp)
		lw	$s0,	4($sp)
		addu	$sp,	$sp,	8
		jr	$ra
	
