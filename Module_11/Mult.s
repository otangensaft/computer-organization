# Title: Mult.
# Description: This script recurively performs multiplication using successive addition
# Author: Danny Tang
# Class: Computer Organization
# Professor: Miriam Lorbert



.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]
	
	LDR r0, =prompt_m
	BL printf
	LDR r0, =format
	LDR r1, =m
	BL scanf

	LDR r0, =prompt_n
	BL printf
	LDR r0, =format
	LDR r1, =n
	BL scanf

	LDR r0, =m
	LDR r0, [r0]
	LDR r1, =n
	LDR r1, [r1]
	BL Mult
	MOV r1, r0

	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt_m: .asciz "\nEnter multiplicand (m): "
	prompt_n: .asciz "\nEnter what to multiply by (n): "
	output: .asciz "\n Your product is %d\n"
	format: .asciz "%d"
	m: .word 0
	n: .word 0

# End Main

.text
# inputs r0=m, r1=n, output r0=product
Mult: 
	# push the stack
	SUB sp, sp, #12
	STR lr, [sp]
	STR r4, [sp, #4]
	STR r5, [sp, #8]

	MOV r4, r0 // m
	MOV r5, r1 // n

	# if (n==1) return m
	CMP r5, #1
	BEQ Finish
	
	# Perform recursion if still stuff to multiply
	
		# Subtract 1 from n and perform recursion
		SUB r1, r5, #1
		BL Mult

		# Sum the result mult(m, n) = m + mult(m, n-1)
		ADD r0, r4, r0
		B Return
	Finish:
		# Return m
		MOV r0, r4
		B Return
	EndIf:


	# pop the stack
	Return: 
	LDR lr, [sp]
	LDR r5, [sp, #8]
	LDR r4, [sp, #4]
	ADD sp, sp, #12
	MOV pc, lr
.data


