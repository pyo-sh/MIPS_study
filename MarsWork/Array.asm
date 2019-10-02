.data
	#	Inteager = 4byte,  need 3 inteagers => 12bytes
	myArray:	.space	12
.text
	# Array is similar to Random Access Memory
	main:
		addi	$s0,	$zero,	4
		addi	$s1,	$zero,	10
		addi	$s2,	$zero,	12
		
		#	Index ( offset ) = $t0
		addi	$t0,	$zero,	0
		
		sw	$s0,	myArray($t0)
			addi	$t0,	$t0,	4
		sw	$s1,	myArray($t0)
			addi	$t0,	$t0,	4
		sw	$s2,	myArray($t0)
		
		#	give t registers myArray value
		lw	$t6	myArray($zero)
		lw	$t8	myArray($t0)
		
		#	print the Value
		li	$v0,	1
		addi	$a0,	$t6,	0
		syscall
		addi	$a0,	$t8,	0
		syscall
		
	#	This is end of the Program
	li	$v0,	10
	syscall
