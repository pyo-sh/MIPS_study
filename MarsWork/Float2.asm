.data
	number1:	.double	3.00
	number2:	.double	2.00
.text
	main:
		ldc1	$f2,	number1
		ldc1	$f4,	number2
		
		mul.d	$f12,	$f2,	$f4
		li	$v0,	3
		syscall
		
	#	This is end of the Prgoram
	li	$v0,	10
	syscall