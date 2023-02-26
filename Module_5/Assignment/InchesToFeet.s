.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf

	// Get Inches Input
	LDR r0, =formatString
	LDR r1, =inches_input
	BL scanf


	// Divide inches by 12 to get feet
	LDR r0, =inches_input
	LDR r0, [r0]
	MOV r1, #12
	BL __aeabi_idiv

	// Store Feet in Regsiter 5
	MOV r5, r0

	// Multiply feet by 12 to get feet in inches
	MOV r7, #12
	MUL r2, r5, r7

	// Subtract the feet in inches from the input_inches to get the remainder inches
	LDR r1, =inches_input
	LDR r1, [r1]
	SUB r6, r1, r2
	
	// Print out output prompt
	MOV r1, r5
	MOV r2, r6
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "Conversion is %d ft. %d in.\n"
	prompt: .asciz "Enter Inches: "
	inches_input: .word 0
	formatString: .asciz "%d" 
	 
