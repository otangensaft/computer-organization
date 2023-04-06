.text
.global main
main: 
	# program dictionary: 
	# r4 - Loop Counter
	# r5 - Loop Limit
	# r6 - base address of list (or array)
	# r7 - the current maximum value
	# r8 - value at current index

	# Push to stack
	SUB sp, sp, #24
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	STR r6, [sp, #12]
	STR r7, [sp, #16]
	STR r8, [sp, #20]

	# initialize
	MOV r4, #0
	LDR r5, =array_size
	LDR r5, [r5]
	LDR r6, =array
	MOV r7, #-1

	startMaxLoop:
		# Check Loop Ending Condition
		CMP r4, r5
		BGE endMaxLoop

		# Loop statement or block
		ADD r8, r6, r4, lsl #2
		LDR r8, [r8]
		CMP r8, r7
		MOVGT r7, r8

		# Get next
		ADD r4, r4, #1
		B startMaxLoop

	endMaxLoop:

	LDR r0, =statement
	MOV r1, r7
	BL printf


	# Push stack
	LDR lr, [sp, #0]
	LDR r4, [sp, #4]
	LDR r5, [sp, #8]
	LDR r6, [sp, #12]
	LDR r7, [sp, #16]
	LDR r8, [sp, #20]
	ADD sp, sp, #24
	MOV pc, lr

.data
	statement: .asciz "\nThe maximum value in list is %d\n"
	array: .word 5
		.word 12
		.word 8
		.word 27
	array_size: .word 4
