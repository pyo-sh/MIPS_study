.data
	# random access memory를 안쓰기 위해 데이터 선언 안함
.text
	addi	$s0,	$zero,	10
	addi	$s1,	$zero,	4
	
	mul	$t0,	$s0,	$s1
	
	li	$v0,	1
	add	$a0,	$zero,	$t0
	syscall