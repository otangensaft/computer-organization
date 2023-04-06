.text
.global main
main: 
	# program dictionary: 
	# r4 - counter for grade loop
	# r5 - limit for grade loop
	# r6 - total student score
	# r7 - average student score
	# r8 - student letter grade
	# r9 - student name
	# Note: sentinal loop input (to -1) is kept in register r0 as its value is short lived

	# Push to stack
	SUB sp, sp, #28
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	STR r6, [sp, #12]
	STR r7, [sp, #16]
	STR r8, [sp, #20]
	STR r9, [sp, #28]

	# intialize the loop
	LDR r0, =promptCont
	BL printf
	LDR r0, =decFormat
	LDR r1, =continue
	BL scanf

	startSentinelLoop:
		LDR r1, =continue
		LDR r1, [r1]
		CMP r1, #-1
		BEQ endSentinelLoop
	
		# Get name
		LDR r0, =promptName
		BL printf
		LDR r0, =nameFormat
		LDR r1, =name
		BL scanf

		# intialize the grade loop
		MOV r4, #0
		MOV r5, #5
		MOV r6, #0

		startGradeLoop:
			CMP r4, r5
			BGE endGradeLoop

			# Prompt and read grade
			LDR r0, =promptGrade
			BL printf
			LDR r0, =scoreFormat
			LDR r1, =grade
			BL scanf
			LDR r0, =grade
			LDR r0, [r0]

			MOV r1, #0
			CMP r0, #0
			ADDGE r1, r1, #1
			MOV r2, #0
			CMP r0, #100
			ADDLE r2, r2, #1
			AND r1, r1, r2

			CMP r1, #0
			BEQ errorGrade
				ADD r6, r6, r0
				B endError

			errorGrade:
				LDR r0, =error
				BL printf
				SUB r4, r4, #1
			endError: 

			ADD r4, r4, #1
			B startGradeLoop

		endGradeLoop:

		# Calculate Average
		MOV r0, r6
		MOV r1, #5
		BL __aeabi_idiv
		MOV r7, r0
		
		# if test for Grade
		CMP r7, #90
		BLT gradeB
			LDR r8, =A
			B endGetGrade
		gradeB:
		CMP r7, #80
		BLT gradeC
			LDR r8, =B
			B endGetGrade
		gradeC: 
		CMP r7, #70
		BLT gradeF
			LDR r8, =C
			B endGetGrade
		gradeF:
			LDR r8, =F
			B endGetGrade
		endGetGrade: 

		# Print the results
		LDR r0, =GradeOutput
		LDR r1, =name
		MOV r2, r7
		MOV r3, r8
		BL printf


		# Get the next value
		LDR r0, =promptCont
		BL printf
		LDR r0, =decFormat
		LDR r1, =continue
		BL scanf
		B startSentinelLoop
		


	endSentinelLoop:



	# Pop stack
	LDR lr, [sp, #0]
	LDR r4, [sp, #4]
	LDR r5, [sp, #8]
	LDR r6, [sp, #12]
	LDR r7, [sp, #16]
	LDR r8, [sp, #20]
	LDR r9, [sp, #28]
	ADD sp, sp, #28
	MOV pc, lr

.data
	promptCont: .asciz "\nEnter -1 to end the program, any other key to continue: "
	promptName: .asciz "\nPlease enter the student's name: "
	promptGrade: .asciz "\nPlease enter a score for the student: "
	nameFormat: .asciz "%s"
	scoreFormat: .asciz "%d"
	decFormat: .asciz "%d" 
	grade: .word 0
	continue: .word 0
	name: .space 50
	GradeOutput: .asciz "\nStudent %s had an average of %d and a grade of %s\n"
	A: .asciz "A"
	B: .asciz "B"
	C: .asciz "C"
	F: .asciz "F"
