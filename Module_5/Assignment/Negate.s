.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	LDR r0, =prompt
	BL printf

	LDR r0, =formatString
	LDR r1, =inputNum
	BL scanf

	// Perform One's Complement
	LDR r1, =inputNum
	LDR r1, [r1]
	MVN r0, r1

	// Add 1 to get the Two's Complement
	ADD r4, r0, #1
	
	// Print out output prompt
	MOV r1, r4
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "Negative Value is %d\n"
	prompt: .asciz "Enter your number: "
	inputNum: .word 0
	formatString: .asciz "%d" 
	 
