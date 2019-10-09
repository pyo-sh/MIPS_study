.data
	message:	.asciiz	"Array is full.\n ----- finished ----- \n"
	scanmsg:	.asciiz	"Type the word : "
	printmsg:	.asciiz	"sorted Array : "
	newLine:	.asciiz	"\n"
	newTap:	.asciiz	"\t"
	Heap:	.space	40
   .eqv	DATA_SIZE	.word	40

.text
	main:
		# t8 = point = i (Now Array cursor) / t9 = Array Size
		li	$s0,	0
		li	$s1,	40
		
		# Loop until Array becomes FullArray
		# s0 = 4i = 0 ; 4i < s1 (DATA_SIZE) ; 4i += 4
		ScanLoop:
			beq	$s0,	$s1,	ScanLoopout
			
			# print scanmessage
			li	$v0,	4
			la	$a0,	scanmsg
			syscall
			
			# Scan Heap[i]
			li	$v0,	5
			syscall
			sw	$v0,	Heap($s0)
			
			# Make Heap to minimum heap
			# a1 = left cursor of the heap = 0
			li	$a1,	0
			# a2 = right cursor of the heap = 4i = s0
			move	$a2,	$s0
			# minimum heap
			jal	heapsort
			
			# SortLoop
			# for (int i = right; i > 0; i--)
			# t0 = i = right = s0
			
			# t2 -> s5
			add	$s3,	$zero,	$s0
			SortLoop:
				# i = 0 / jump
				beq	$s3,	$zero,	SortLoopout
			
				# heap[0] = s4 , heap[t0] = s5   / swap heap[0], heap[i]
				lw	$s4,	Heap($zero)
				lw	$s5,	Heap($s3)
				sw	$s4,	Heap($s3)
				sw	$s5,	Heap($zero)
				
				# Make Heap to minimum heap
				# a1 = left cursor of the heap = 0
				li	$a1,	0
				# a2 = right cursor of the heap = t0 - 4
				addi	$s3,	$s3,	-4
				add	$a2,	$zero,	$s3
				jal	heapsort
				
				j	SortLoop
				
			SortLoopout:
			
			# print printmessage
			li	$v0,	4
			la	$a0,	printmsg
			syscall
			# print Array
			move	$a1,	$s0
			jal printArray
			# print new Line
			li	$v0,	4
			la	$a0,	newLine
			syscall
			
			# t8 + 4 = i + 1
			addi	$s0,	$s0,	4
			
			j	ScanLoop
			
		ScanLoopout:
		# print message
		li	$v0,	4
		la	$a0,	message
		syscall
		
	# This is end of the Program
	li	$v0,	10
	syscall

# ---------------------------------------------------------------------------------

	# function that Makes Heap to minimum heap
	heapsort:	# t0 = a1 = left / t1 = a2 - 4 = right - 4
	
		# heaploop
		# for (int x = right / 2; x > 0; x--)
		add	$t0,	$a1,	$zero
		addi	$t1,	$a2,	-4
		# t3 = x = (right - 4) / 2 [parent of right]
		li	$t9,	8
		div	$t1,	$t9
		mflo	$t3
		mulu	$t3,	$t3,	4
		# t2 = t3 = parent of right
		add	$t2,	$zero,	$t3
		heaploop:
			# t3 = x = (right-4)/2   /   x > 0
			# t3 < 0
			slt	$t9,	$t3,	$t0
			beq	$t9,	1,	heaploopout
			
			# heapify
			# for (int parent = x; parent <= (right / 2); parent *= child)
			# t4 = parent = x(t3)
			add	$t4,	$t3,	$zero
			heapify:
				# t4  <=  $2  / parent <= (right / 2)
				beq	$t4,	$t2,	heapifyout
				
				# t5 = child1 = parent * 2; = t4 * 2
				# t6 = child2 = parent * 2 + 1 = t4 * 2 + 1 =t5 + 1
				mulu	$t5,	$t4,	2
				addi	$t6,	$t5,	4
				
				# if (child < right && a[child] > a[child + 1])
				# child 1 < right   / t5 < a2	t9 = true or false
				slt	$t9,	$t5,	$a2
				# true(1) = execute still, false(0) = jump
				beq	$t9,	0,	setchildout
				
					# a[child1] > a[child2]   / t7 > t8
					lw	$t7,	Heap($t5)
					lw	$t8,	Heap($t6)
					slt	$t9,	$t8,	$t7
					# true(1) = execute still, false(0) = jum
					beq	$t9,	0,	setchildout
						# true (1) = ++ child = ++ (t5, t7)
						add	$t5,	$zero,	$t6
						add	$t7,	$zero,	$t8	
				setchildout:
				# t4 = parent, t5 = child, t7 = heap[child], t8 = heap[parent] 
				lw	$t8,	Heap($t4)
				# if (a[parent] > a[child])
				# a[child] < a[parent]   / t7 < t8
				slt	$t9,	$t7,	$t8
				# true(1) = execute, false(0) = jump (no execute)
				beq	$t9,	0,	swapout
					# swap a[parent] and a[child]
					# parent = a[child]
					sw	$t7,	Heap($t4)
					# child = a[parent]
					sw	$t8,	Heap($t5)
				swapout:
				
				# parent = child / t4 = t5
				add	$t4,	$zero,	$t5
				
			heapifyout:
			
			# t3 = x = x - 4
			addi	$t3,	$t3,	-4
			j	heaploop
			
		heaploopout:
		
	jr	$ra
	
	# function that Prints sorted Array
	printArray:
		# a1 = right Array
		# t0 = i = 0
		move	$t0,	$zero
		# t1 = right Array + 4
		addi	$t1,	$a1,	4
		printLoop:
			beq	$t0,	$t1,	printLoopout
			
			# print tab
			li	$v0,	4
			la	$a0,	newTap
			syscall
			
			# print value
			li	$v0,	1
			lw	$a0,	Heap($t0)
			syscall
			
			# t0 + 4
			addi	$t0,	$t0,	4
			j	printLoop
		printLoopout:
		
	jr	$ra
		