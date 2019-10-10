.data
	message:	.asciiz	"Array is full.\n ----- finished ----- \n"
	scanmsg:	.asciiz	"Type the word : "
	printmsg:	.asciiz	"sorted Array : "
	newLine:	.asciiz	"\n"
	newTap:		.asciiz	"\t"
	Heap:		.space	40
   .eqv	DATA_SIZE		40

.text
	main:
		# s0 = index(address) = 4i (Now Array address) / s1 = Array Size
		li	$s0,	0
		li	$s1,	DATA_SIZE
		
		# Loop until Array becomes FullArray
		# for(s0 = 0 ; s0(4i) <  s1(DATA_SIZE); s0 += 4)
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
			
			# Make Heap to minimum heap   /   heapsort(first, last)
			# a1 = first of the heap = 0   /   a2 = last of the heap = s0 = 4i
			li	$a1,	0
			move	$a2,	$s0
			jal	heapsort
			
			# SortLoop
			# for ( s3 = s0(lastHeap); s3 != 0; s3 -= 4)
			move	$s3,	$s0
			SortLoop:
				# s3 = 0 / jump to SortLoopout
				beq	$s3,	0,	SortLoopout
				
				# swap heap[0], heap[s3]   /   heap[0] = s4 , heap[s3] = s5
				lw	$s4,	Heap($zero)
				lw	$s5,	Heap($s3)
				sw	$s4,	Heap($s3)
				sw	$s5,	Heap($zero)
				
				# Make Heap to minimum heap   /   heapsort(first, last - 4)
				# a1 = first of the heap = 0   /   a2 = last of the heap = s3 - 4
				li	$a1,	0
				addi	$s3,	$s3,	-4	# s3 -= 4
				move	$a2,	$s3
				jal	heapsort
			j	SortLoop
			SortLoopout:
			
			# print printmessage
			li	$v0,	4
			la	$a0,	printmsg
			syscall
			# printArray(last)   /   print heap[0]~heap[last]
			move	$a1,	$s0
			jal printArray
			# print new Line
			li	$v0,	4
			la	$a0,	newLine	
			syscall
			
			# s0(4i) += 4   /   == 4(i+1)
			addi	$s0,	$s0,	4
			j	ScanLoop
		ScanLoopout:
		# print message that Array is full
		li	$v0,	4
		la	$a0,	message
		syscall
	# This is end of the Program
	li	$v0,	10
	syscall
# ---------------------------------------------------------------------------------
	heapsort:	# function that Makes Heap to minimum heap
		# To derive parent of the Heap, ( ArrayIndex + 4 )   /   4(i + 1)
		# t0 = (first + 4) = a1 + 4   /   t1 = (last + 4 ) = a2 + 4
		addi	$t0,	$a1,	4
		addi	$t1,	$a2,	4
		
		# heaploop
		# for (t3 = parent of right; t3 > 0(first); t3 -= 4)
		# t3 = ((right + 4) / 8 ) * 4 = (t1 / 8) * 4   /   [parent of right]
		div	$t3,	$t1,	8
		mulu	$t3,	$t3,	4
		# t2 = t3 + 4    /  [line 108] parent <= (right / 2) -> parent < (right / 2) + 4
		addi	$t2,	$t3,	4
		heaploop:
			# 0(left) < t3   /   a1 < t3
			slt	$t9,	$a1,	$t3
			# true(1) = keep execute, false(0) = jump heaploopout
			beq	$t9,	0,	heaploopout
			
			# heapify
			# for (t4 = t3; t4 < t2; t4 = t5(child of t4))
			# t4 = parent = t3
			move	$t4,	$t3
			heapify:
				# t4(parent) <= parent of last   /   t4  <  t2(parent of last + 4)
				slt	$t9,	$t4,	$t2
				# true(1) = keep execute, false(0) = jump heapifyout
				beq	$t9,	0,	heapifyout
				
				# t5 = child1 = parent * 2; = t4 * 2 - 4	/   - 4 (get ArrayIndex)
				# t6 = child2 = parent * 2 + 4 = t4 * 2	+ 4 - 4	/   - 4 (access to address)
				mulu	$t6,	$t4,	2	# t6 = t4 * 2
				addi	$t5,	$t6,	-4
				
				# if (child1 < right)
				# child1 < right   /   t5 < a2
				slt	$t9,	$t5,	$a2
				# true(1) = execute still, false(0) = jump setChildout
				beq	$t9,	0,	setChildout
				
					lw	$t7,	Heap($t5)	# heap[child1/4]
					lw	$t8,	Heap($t6)	# heap[child2/4]
					
					#if(heap[child2/4] < heap[child1/4])
					# heap[child2/4] < heap[child1/4]   /   t8 < t7
					slt	$t9,	$t8,	$t7
					# true(1) = child2 -> child, false(0) = child1 -> child
					beq	$t9,	0,	setChildout
						# child address = t5   /   heap[child/4] = t7
						move	$t5,	$t6
						move	$t7,	$t8
				setChildout:
				
				# t4 = parent, t8 = heap[parent] 
				addi	$t4,	$t4,	-4	# (access to parent value)
				lw	$t8,	Heap($t4)
				# t5 = child, t7 = heap[child]
				lw	$t7,	Heap($t5)
				
				# if(heap[child] < heap[parent])   /   t8 < t7
				slt	$t9,	$t8,	$t7
				# true(1) = swap heap[parent], heap[child], false(0) = jump (no execute)
				beq	$t9,	1,	swapout
					# parent address = heap[child]
					sw	$t7,	Heap($t4)
					# child address = heap[parent]
					sw	$t8,	Heap($t5)
				swapout:
				# To derive parent of the Heap, ( ArrayIndex + 4 )   /   4(i + 1)
				addi	$t5,	$t5,	4
				# parent = child   /   t4 = t5
				move	$t4,	$t5
				
				j	heapify
			heapifyout:
			
			# t3 -= 4
			addi	$t3,	$t3,	-4
			j	heaploop
		heaploopout:
	jr	$ra
# ---------------------------------------------------------------------------------
	printArray:	# function that Prints sorted Array
		# t1 = last of Array + 4   /   a1 = last of Array
		addi	$t1,	$a1,	4
		#printLoop
		#for(t0 = 0; t0 != t1; t0 += 4)
		move	$t0,	$zero
		printLoop:
			beq	$t0,	$t1,	printLoopout
			
			# print tab
			li	$v0,	4
			la	$a0,	newTap
			syscall
			# print value(Heap[t0/4])
			li	$v0,	1
			lw	$a0,	Heap($t0)
			syscall
			
			# t0 += 4
			addi	$t0,	$t0,	4
			j	printLoop
		printLoopout:
	jr	$ra
