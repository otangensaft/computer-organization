# Miles2Kilometers.s
# An assembly program to convert from miles to kilometers
# Author: Danny Tang
# Written: March 19, 2023 
	.text
	.global main

main: 
# Save return to os on stack
	sub sp, sp, #4
	str lr, [sp, #0]

# Prompt for an input 
	ldr r0, =prompt1
	bl printf

# Scanf
	ldr r0, =input1
	sub sp, sp, #4
	mov r1, sp
	bl scanf
	ldr r0, [sp, #0]
	add sp, sp, #4

# Convert
	bl Miles2Kilometers
	mov r1, r0

# Print 
	ldr r0, =format1
	BL printf

# Return to the OS
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

.data
	prompt1: .asciz "Miles: "
	format1: .asciz "\nKilometeres: %d\n"
	input1: .asciz "%d"
	num1: .word 0
