# KPH
# An assembly program to convert from miles and hours to kilometers per hour
# Author: Danny Tang
# Written: March 19, 2023 
	.text
	.global main

main: 
# Save return to os on stack
	sub sp, sp, #4
	str lr, [sp, #0]

# Prompt for Hours
	ldr r0, =prompt1
	bl printf

# Scanf
	ldr r0, =input1
	sub sp, sp, #4
	mov r1, sp
	bl scanf
	ldr r0, [sp, #0]
	add sp, sp, #4

	MOV r8, r0

# Prompt for Miles
	LDR r0, =prompt2
	bl printf

# Scanf
	ldr r0, =input1
	sub sp, sp, #4
	mov r1, sp
	bl scanf
	ldr r0, [sp, #0]
	add sp, sp, #4

# Convert
	MOV r1, r0
	MOV r0, r8

	bl KPH
	mov r1, r0

# Print 
	ldr r0, =format1
	BL printf

# Return to the OS
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

.data
	prompt1: .asciz "Hours: "
	prompt2: .asciz "Miles: "
	format1: .asciz "\nKPH: %d\n"
	input1: .asciz "%d"
	num1: .word 0
