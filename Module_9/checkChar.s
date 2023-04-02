# Title: checkChar
# Description: Prompts User for a character input, checking whether it is a character or not
# Author: Danny Tang
# Date Written: April 2, 2023
# Class: Computer Organization by Miriam Lorbert 


.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	# Prompt for character
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =char
	BL scanf

	# Print out whether it is a character
	LDR r1, =char
	LDR r1, [r1]
	BL checkCharNoLogical

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt: .asciz "\nEnter a character: "
	format: .asciz "%c"
	char: .word 0

.text
# Check Character as a Logical Variable
checkCharLogical: 
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]
	
	# Check for uppercase, in which case r2=1
	MOV r2, #0
	CMP r1, #0x41
	ADDGE r2, #1

	MOV r3, #0
	CMP r1, #0x5A
	ADDLT r3, #1
	AND r2, r2, r3

	# Check for lowercase, in which case r3=1
	MOV r3, #0
	CMP r1, #0x61
	ADDGE r3, #1

	MOV r4, #0
	CMP r1, #0x7A
	ADDLT r4, #1
	AND r3, r3, r4

	# r0=1 if the character is valid (uppercase==true || lowercase==true)
	ORR r0, r2, r3

	CMP r0, #1

	# Output whether it is a character or not
	BNE notChar
		LDR r0, =isCharPrompt
		BL printf
		B End1
	notChar: 
		LDR r0, =notCharPrompt
		BL printf

	End1:


	LDR lr, [sp]
	LDR r4, [sp, #4]
	ADD sp, sp, #8

	BX lr


.data
	isCharPrompt: .asciz "Valid Character\n" 
	notCharPrompt: .asciz "Not Valid Character\n"


.text
# Check Character without Logical Variables, instead using if statements
checkCharNoLogical:
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]

	# if Character is less than 0x41, then branch to notChar
	CMP r1, #0x41
	BLT notChar2

	# if character is less than or equal to 0x5A, then branch to isChar
	CMP r1, #0x5A
	BLE isChar2

	# if character is less than 0x61, branch to notChar
	CMP r1, #0x61
	BLT notChar2

	# if character is greater than 0x7A, branch to notChar
	CMP r1, #0x7A
	BGT notChar2

	# Output whether it is a character or not
	isChar2:
		LDR r0, =isCharPrompt
		BL printf
		B End2
	notChar2: 
		LDR r0, =notCharPrompt
		BL printf
	End2:	


	

	LDR lr, [sp]
	LDR r4, [sp, #4]
	ADD sp, sp, #8

	BX lr


