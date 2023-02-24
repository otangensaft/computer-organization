.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf

	// Get User Inputs
	LDR r0, =formatString
	LDR r1, =fahrenheit
	BL scanf

	// Subtract 32 and store in r4
	LDR r1, =fahrenheit
	LDR r1, [r1]
	SUB r4, r1, #32

	// Multiply by 5 and store in r4
	MOV r2, #5
	MUL r4, r4, r2

	// Divide by 9 and store celsius in r4
	MOV r0, r4
	MOV r1, #9
	BL __aeabi_idiv
	MOV r4, r0
	
	// Print out output prompt
	MOV r2, r4
	LDR r1, =fahrenheit
	LDR r1, [r1]
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "%d Fahrenheit = %d Celsius\n"
	prompt: .asciz "Enter Temp (F):"
	fahrenheit: .word 0
	formatString: .asciz "%d" 
	 
