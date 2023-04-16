# Title: Fibonnaci.s
# Description: This script provides the user requested fibonnaci number using recursion
# Author: Danny Tang
# Class: Computer Organization
# Professor: Miriam Lorbert


.global main
main:
	SUB sp, sp, #4
	STR lr, [sp]
	
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =n // n is the nth integer in the fibonacci sequence
	BL scanf

	LDR r0, =n
	LDR r0, [r0]
	SUB r0, r0, #1 // subtract 1 to fix the fibonnaci offset by 1 (1, 1, 2, 3, 5, etc.)
	BL Fibo
	MOV r2, r0

	# Load the value of register 1
	LDR r1, =n
	LDR r1, [r1]
	
	# Print out the result
	LDR r0, =output
	BL printf

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt: .asciz "\nEnter integer n for nth fibonnaci number: "
	output: .asciz "\n The %dth fibonnaci number is %d\n"
	format: .asciz "%d"
	n: .word 0

# End Main

.text
# Fibonacci Function
Fibo: 
	# push the stack
	SUB sp, sp, #12
	STR lr, [sp]
	STR r4, [sp, #4]
	STR r5, [sp, #8]

	MOV r4, r0

	# if (n == 0 or n==1), return 1
	CMP r4, #1
	BEQ Finish
	CMP r4, #0
	BEQ Finish
	
	# Perform recursion if still stuff to fibonacci
	SUB r0, r4, #1
	BL Fibo
	MOV r5, r0 // store the result fib(n-1) in r5

	SUB r0, r4, #2 // calculate the result fib(n-1)
	BL Fibo
	
	# Perform the addition fib(n) = fib(n-1) + fib(n-2)
	ADD r0, r5, r0
	B Return

	Finish:
		# Return 1 if n == 0 or n == 1
		MOV r0, #1
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


