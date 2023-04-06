.text
.global main
main: 
	# program dictionary: 
	# r4 - Loop Counter
	# r5 - Loop Limit

	# Push to stack
	SUB sp, sp, #12
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]

	# initialize
	MOV r4, #0
	MOV r5, #5

	StartLoop:
		# Check the limit
		CMP r4, r5
		BGE EndLoop

		# Loop statement or block
		MOV r1, r4
		LDR r0, =statement
		BL printf

		# Get the next value
		ADD r4, r4, #1
		B StartLoop
	EndLoop:


	# Pop from the stack
	LDR lr, [sp, #0]
	LDR r4, [sp, #4]
	LDR r5, [sp, #8]
	ADD sp, sp, #12
	MOV pc, lr

.data
	statement: .asciz "\nThe loop index is %d \n"
