# Title: findMaxOf3.s
# Description: This function returns the maximum values of three integer inputs.  This function is called by findMax.s
# Author: Danny Tang
# Written: April 2, 2023
# Class: Introduction to Computer Organization by Professor Miriam Lorbert


.global findMaxOf3 // findMaxOf3(int val1 [r1], int val2 [r2], int val3 [r3])

.text 
findMaxOf3: 
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]

	# Store in register 4, the register the largest value seen so far
	MOV r4, r1

	# Compare with register 2 and perform a swap as needed
	CMP r2, r4
	MOVGT r4, r2

	# Compare with register 3 and perform a swap as needed
	CMP r3, r4
	MOVGT r4, r3

	LDR r0, =prompt
	MOV r1, r4
	BL printf
	

	# pop stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
prompt: .asciz "Highest Value is: %d\n"
	
	
	
