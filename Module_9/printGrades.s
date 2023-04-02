# Title: Print Grade
# Description: Prompts User for an input from 0-100, spitting out a resultant grade
# Author: Danny Tang
# Date Written: April 2, 2023
# Class: Computer Organization by Miriam Lorbert 


.text
.global main
main: 
	SUB sp, sp, #4
	STR lr, [sp]

	# Prompt for and read grade
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =grade
	BL scanf

	# Print Grade (grade in r0)
	LDR r0, =grade
	LDR r0, [r0]
	BL printGrades

	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

.data
	prompt: .asciz "\nEnter a grade between 0-100: "
	format: .asciz "%d"
	grade: .word 0

# END Main

.text
printGrades: 
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]
	
	# Store r0 in r4 for safety
	MOV r4, r0

	# Code for print grades function
	MOV r0, #0
	CMP r4, #0 

	# r0 is 1 if input > 0
	ADDGE r0, r0, #1
	MOV r1, #0

	# r1 is 1 if input < 100
	CMP r4, #100
	ADDLE r1, r1, #1

	# r0 is 1 if r0 and r1 are both 1 (grade is 0-100)
	AND r0, r0, r1
	CMP r0, #1

	# If r0 is not equal to 1, then spit out the error message
	BNE ErrorMsg
		# Otherwise, continue as per usual and print out statements if a certain grade is met

		# if grade is 0-70, print out F
		CMP r4, #70
		BGE C_Grade
		LDR r0, =grade_F
		BL printf
		B EndError
		
		# If grade is 70-80, print out C
		C_Grade: 
			CMP r4, #80
			BGE B_Grade
			LDR r0, =grade_C
			BL printf
			B EndError
		
		# If grade is 80-90, print out B
		B_Grade: 
			CMP r4, #90
			BGE A_Grade
		
			LDR r0, =grade_B
			BL printf
			B EndError

		# If grade is 90-100, print out A
		A_Grade:
			LDR r0, =grade_A
			BL printf
			
		B EndError
	ErrorMsg: 
		# Print if grade is invalid
		LDR r0, =error
		BL printf
	EndError:

	LDR lr, [sp]
	LDR r4, [sp, #4]
	ADD sp, sp, #8

.data
	error: .asciz "\nGrade must be 0-100\n"
	grade_A: .asciz "\nGrade is A\n"
	grade_B: .asciz "\nGrade is B\n" 
	grade_C: .asciz "\nGrade is C\n"
	grade_F: .asciz "\nGrade is F\n"
