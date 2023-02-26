.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf

	LDR r0, =formatString
	LDR r1, =input_number
	BL scanf

	// Multiply the input by 8 using logical shift
	LDR r1, =input_number
	LDR r1, [r1]
	LSL r4, r1, #3

	// Add 2X of the input to the 8X to get a 10X multiplication
	ADD r5, r4, r1
	ADD r5, r5, r1

	// Print output
	MOV r2, r5
	LDR r1, =input_number
	LDR r1, [r1]
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "%d x 10 = %d\n"
	prompt: .asciz "Enter an integer:"
	input_number: .word 0
	formatString: .asciz "%d" 
	 
