.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	// Load the number 42 in register 0
	MOV r0, #42

	// Load the number 800 in register 1
	MOV r1, #800

	// Swap the values in the registers (you can use XOR b/c it is reversible)
	EOR r1, r0, r1
	EOR r0, r0, r1
	EOR r1, r0, r1

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	 
