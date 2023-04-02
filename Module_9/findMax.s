# Title: checkChar
# Description: Prompts User for three integers, calling function findMaxOf3(int val1 [r1], int val2 [r2], int val3 [r3]) to return the largest value
# Author: Danny Tang
# Date Written: April 2, 2023
# Class: Computer Organization by Miriam Lorbert 


.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	# Prompt user for input
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =int1
	BL scanf

	# Prompt user for input
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =int2
	BL scanf
	
	# Prompt user for input
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =int3
	BL scanf

	# Print out whether it is a character
	LDR r1, =int1
	LDR r1, [r1]
	LDR r2, =int2
	LDR r2, [r2]
	LDR r3, =int3
	LDR r3, [r3]
	BL findMaxOf3

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt: .asciz "\nEnter integer: "
	format: .asciz "%d"
	int1: .word 0
	int2: .word 0
	int3: .word 0

