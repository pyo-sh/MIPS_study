.data
	message:	.asciiz	"The numbers are equal."
	message2:	.asciiz	"Noting happened."
.text
	main:
		addi	$t0,	$zero,	5
		addi	$t1,	$zero,	20
		
		b numbersEqual
		
	li	$v0,	10
	syscall
	
	numbersEqual:
		li	$v0,	4
		la	$a0,	message
		syscall
		
		li	$v0,	10
		syscall