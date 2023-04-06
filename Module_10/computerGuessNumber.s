# Title: computerGuessNumber.s
# Description: Prompts the computer to guess a random number from 1 to maximum (user inputted), querying the user until the correct number is guessed
# Author: Danny Tang
# Date Written: April 6, 2023
# Class: Computer Organization by Miriam Lorbert





.text
.global main
main: 
	# program dictionary: 
	# r4 - loop counter
	# r5 - user inputted maximum
	# r6 - computer guess
	# r7 - user response (-1) go lower, (0) bulls-eye, (1) Go Higher
	# r8 - ceiling, or the max of what the computer will guess again
	# r9 - floor, or the min of what the computer will guess again

	# Push to stack
	SUB sp, sp, #24
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	STR r6, [sp, #12]
	STR r7, [sp, #16]
	STR r8, [sp, #20]
	STR r9, [sp, #24]

	## prompt the user for a maximum value, storing in r5
	LDR r0, =promptMax
	BL printf
	LDR r0, =decFormat
	LDR r1, =maxValue
	BL scanf
	LDR r5, =maxValue
	LDR r5, [r5]
	MOV r8, r5

	# Guess half of the number that the user inputted, using a LSR
	MOV r6, r5, LSR #1

	
	# Iterate until the correct number has been obtained 

	loop: 
		ADD r4, r4, #1 // increment loop counter

		# computer says its guess
		LDR r0, =compGuess
		MOV r1, r6
		BL  printf

		# gather user input
		LDR r0, =decFormat
		LDR r1, =response
		BL scanf
		LDR r7, =response
		LDR r7, [r7]

		# review user input
		CMP r7, #0

		# if won, go to end of the loop
		BEQ endLoop
		
		# guess a lower number 
		BLT goLower
			## Go Higher
			ADD r9, r6, #0 // raise the floor to the guess 
			SUB r2, r8, r9 // find the difference between the floor and the ceil
			ADD r2, r2, #1 // add 1 to the diff to round up
			MOV r1, r2, LSR #1 // divide the difference by 2 and store in r1
			ADD r6, r6, r1 // update the computer guess to loop again
			B loop
		goLower: 
			SUB r8, r6, #0 // lower the ceil to guess 
			SUB r2, r8, r9 // find the diff between the ceiling and the floor
			ADD r2, r2, #1 // add 1 to the diff to round up
			MOV r1, r2, LSR #1 // divide the diff by 2 and store in r1
			SUB r6, r6, r1 // update the computer guess toloop again
			B loop
		
	endLoop: 

	# print out victory conditions
	LDR r0, =won
	MOV r1, r6 // the correct number
	MOV r2, r4 // how many tries it took
	BL printf

	# Pop stack
	LDR lr, [sp, #0]
	LDR r4, [sp, #4]
	LDR r5, [sp, #8]
	LDR r6, [sp, #12]
	LDR r7, [sp, #16]
	LDR r8, [sp, #20]
	LDR r9, [sp, #24]
	ADD sp, sp, #24
	MOV pc, lr

.data
	promptMax: .asciz "\nEnter a maximum integer: "
	compGuess: .asciz "\nComputer guess is %d. Go Higher? (1), Go Lower? (-1), or Bulls-Eye! (0):  \n"
	decFormat: .asciz "%d" 
	maxValue: .word 0
	response: .word 0
	won: .asciz "\n Computer guessed the number %d correctly in %d tries!\n"
