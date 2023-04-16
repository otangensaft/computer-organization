.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]
	
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =number
	BL scanf

	LDR r0, =number
	LDR r0, [r0]
	BL Sum
	MOV r1, r0

	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt: .asciz "\nEnter a value to sum to: "
	output: .asciz "\n Your summation is %d\n"
	format: .asciz "%d"
	number: .word 0

# End Main

.text
Sum: 
	# push the stack
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]

	MOV r4, r0

	# if (n==0) return 0
	CMP r4, #0
	BNE Else
		MOV r0, #0
		B Return
	Else: 
		SUB r0, r4, #1
		BL Sum
		ADD r0, r4, r0
		B Return
	EndIf:


	# pop the stack
	Return: 
	LDR lr, [sp]
	LDR r4, [sp, #4]
	ADD sp, sp, #8
	MOV pc, lr
.data


