.data
	inte:	.word	4
	
.text
	lw	$s0,	inte
	sll 	$t0,	$s0,	2
	
	li	$v0,	1
	add	$a0, 	$zero,	$t0
	syscall