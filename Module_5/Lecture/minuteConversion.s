.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf

	LDR r0, =formatString
	LDR r1, =totalMinutes
	BL scanf

	// Calculate the number of hours and store in r4
	LDR r0, =totalMinutes
	LDR r0, [r0]
	MOV r1, #60
	BL __aeabi_idiv
	MOV r4, r0 

	// Calculate the number of minutes the hours take up
	MOV r1, #60
	MOV r0, r4
	MUL r0, r0, r4

	// Subtract total minutes from total minutes
	LDR r1, =totalMinutes
	LDR r1, [r1]
	SUB r1, r1, r0

	// Print out output prompt
	MOV r2, r1
	MOV r1, r0
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "\n%d Hours and %d minutes" 
	prompt: .asciz "Enter total minutes: "
	totalMinutes: .word 0
	formatString: .asciz "%d" 
	 
