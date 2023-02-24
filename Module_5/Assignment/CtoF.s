.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf

	LDR r0, =formatString
	LDR r1, =celsius
	BL scanf

	// Multiply Celsius by 9 and store in r4
	LDR r0, =celsius
	LDR r0, [r0]
	MOV r1, #9
	MUL r0, r0, r1
	MOV r4, r0  // store product in r4

	// Divide by 5
	MOV r1, #5
	BL __aeabi_idiv

	// Add 32
	MOV r2, #32
	ADD r4, r0, r2  // Store sum in r4
	
	// Print out output prompt
	MOV r2, r4
	LDR r1, =celsius
	LDR r1, [r1]
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "%d Celsius = %d Fahrenheit\n"
	prompt: .asciz "Enter Temp (C):"
	celsius: .word 0
	formatString: .asciz "%d" 
	 
