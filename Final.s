.text
.global main
main: 
	# program dictionary: 
	# r5 - 
	# r6 - number of attempts
	# r7 - total of all of the values
	# r8 - average of the values

	# Push to stack
	SUB sp, sp, #28
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	STR r6, [sp, #12]
	STR r7, [sp, #16]
	STR r8, [sp, #20]
	STR r9, [sp, #28]

	# intialize the loop
	LDR r0, =promptCont
	BL printf
	LDR r0, =decFormat
	LDR r1, =continue
	BL scanf

	# Intialize Variables
	MOV r6, #0
	MOV r7, #0
	MOV r8, #0

	startSentinelLoop:
		LDR r1, =continue
		LDR r1, [r1]
		CMP r1, #-1
		BEQ endSentinelLoop

		# Prompt for Number
		LDR r0, =promptNum
		BL printf
		LDR r0, =numFormat
		LDR r1, =num
		BL scanf

		# Increment Attempts
		ADD r6, r6, #1

		# Add Number to total
		LDR r0, =num
		LDR r0, [r0]
		ADD r7, r7, r0
	
		# Get the next value
		LDR r0, =promptCont
		BL printf
		LDR r0, =decFormat
		LDR r1, =continue
		BL scanf
		B startSentinelLoop
		



	endSentinelLoop:

	# Calculate Average
	MOV r0, r7
	MOV r1, r6
	BL __aeabi_idiv
	MOV r8, r0

	# Print the results
	LDR r0, =Output
	MOV r1, r6
	MOV r2, r7
	MOV r3, r8
	BL printf


	# Pop stack
	LDR lr, [sp, #0]
	LDR r4, [sp, #4]
	LDR r5, [sp, #8]
	LDR r6, [sp, #12]
	LDR r7, [sp, #16]
	LDR r8, [sp, #20]
	LDR r9, [sp, #28]
	ADD sp, sp, #28
	MOV pc, lr

.data
	promptCont: .asciz "\nEnter -1 to end the program, any other key to continue: "
	promptNum: .asciz "\nPlease enter a number: "
	numFormat: .asciz "%d"
	decFormat: .asciz "%d" 
	num: .word 0
	continue: .word 0
	Output: .asciz "\nValues Entered: %d, Total of All Values: %d, Average of All Values: %d\n"
