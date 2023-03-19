.text
.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]

	// As the user for Y
	LDR r0, =prompt
	BL printf
	LDR r0, =formatString
	LDR r1, =Y
	BL scanf

	// Do Math
	LDR r0, =Y
	LDR r0, [r0]
	MOV r1, #9
	MUL r0, r0, r1
	MOV r1, #5
	BL __aeabi_idiv
	MOV r1, #7
	ADD r0, r0, r1

	MOV r1, r0
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	output: .asciz "\nThe value of X is %d\n" 
	prompt: .asciz "Enter the value for Y: "
	Y: .word 0
	formatString: .asciz "%d"
