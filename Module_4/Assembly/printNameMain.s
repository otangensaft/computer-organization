#
# Program Name: printNameMain.s
# Author: Danny Tang

.text
.global main

main: 
	# save return to os on stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	# prompt for an input
	LDR r0, =prompt
	BL printf

	# Scanf
	LDR r0, =input
	LDR r1, =name
	BL scanf

	# Printing the message
	ldr r0, =format
	ldr r1, =name
	BL printf

	# Return to the OS
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr

.data
	# Prompt the user to enter their name
	prompt: .asciz "Enter your name: "
	# Format for input (read a string) 
	input: .asciz "%s"
	# Format of the program output
	format: .asciz "Hello %s, how are youo today? \n"
	# Reserves space in the memory for name
	name: .space 40
