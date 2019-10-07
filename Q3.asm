.data
	message:	.asciiz	"Array is full.\n ----- finished ----- \n"
	Heap:	.space	40
   .eqv	DATA_SIZE	.word	40

.text
	main:
		# t8 = point = i (Now Array cursor) / t9 = Array Size
		li	$t8,	0
		la	$t9,	DATA_SIZE
		
		# Loop until Array becomes FullArray
		# t8 = 4i = 0 ; 4i < t9 (DATA_SIZE) ; 4i += 4
		ScanLoop:
			beq	$t8,	$t9,	ScanLoopout
			
			# Scan Heap[i]
			li	$v0,	5
			syscall
			sw	$v0,	Heap($t8)
			
			# Make Heap to minimum heap
			# a1 = left cursor of the heap
			li	$a1,	0
			# a2 = right cursor of the heap 
			# t8 = ( i * 4 ), a2 = (t8 / 8) = (i / 2)[to get quotien] * 4
			divu	$t8,	8
			mflo	$a2
			mul	$a2,	$a2,	4
			
			jal	heapify
			
			
			
			addi	$t8,	$t8,	4
			
		ScanLoopout:
		
		
	# This is end of the Program
	li	$v0,	10
	syscall

	# function that Makes Heap to minimum heap
	heapify:
		
		
		
		
		
		jr	$ra