.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt_1
	BL printf

	// Get Feet Input
	LDR r0, =formatString
	LDR r1, =feet_input
	BL scanf

	LDR r0, =prompt_2
	BL printf

	// Get Inches Input
	LDR r0, =formatString
	LDR r1, =inches_input
	BL scanf

	// Multiply feet by 12 inches
	LDR r4, =feet_input
	LDR r4, [r4]

	MOV r3, #12
	MUL r4, r4, r3

	// Add to input inches
	LDR r1, =inches_input
	LDR r1, [r1]
	ADD r1, r1, r4

	// Print out output prompt
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "Total Inches = %d\n"
	prompt_1: .asciz "Enter Feet: "
	prompt_2: .asciz "Enter Inches: "
	feet_input: .word 0
	inches_input: .word 0
	formatString: .asciz "%d" 
	 
