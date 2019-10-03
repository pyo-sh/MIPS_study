.data
	number1:	.float	3.14
	number2:	.float	2.71
.text
	main:
		lwc1	$f2,	number1
		lwc1	$f4,	number2
		
		add.s	$f12,	$f2,	$f4
		li	$v0,	2
		syscall
		
	#	This is end of the Prgoram
	li	$v0,	10
	syscall