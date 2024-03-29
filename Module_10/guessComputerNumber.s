# Title: guessComputerNumber.s
# Description: Prompts the user to guess a random number generated by the computer from 1 to maximum (user inputted), querying the user until the correct number is guessed
# Author: Danny Tang
# Date Written: April 6, 2023
# Class: Computer Organization





.text
.global main
main: 
	# program dictionary: 
	# r4 - max value
	# r5 - guess counter
	# r6 - random number
	# r7 - random number from 0 to 999
	# r8 - user guess
	# r9 - correct guess

	# Push to stack
	SUB sp, sp, #24
	STR lr, [sp, #0]
	STR r4, [sp, #4]
	STR r5, [sp, #8]
	STR r6, [sp, #12]
	STR r7, [sp, #16]
	STR r8, [sp, #20]
	STR r9, [sp, #24]

	# Initialize variables
	MOV r5, #0
	MOV r8, #-1

	## Generate random number from 0 to 999, using random % 1000 = random - (1000*int(random/1000))
	MOV r0, #0
	BL time
	BL srand
	BL rand // this creates a random number in r0
	MOV r6, r0 // store random number in r6
	MOV r1, #1000 // prepare for division
	BL __aeabi_idiv // result is int(rand/1000)
	MOV r1, #1000
	MUL r0, r0, r1 // result is 1000*(rand/1000), stored in r0
	SUB r7, r6, r0 // result is number from 0 to 999, stored in r7, random % 1000 = random - r0
	

	## prompt the user for a maximum value to guess
	LDR r0, =promptMax
	BL printf
	LDR r0, =decFormat
	LDR r1, =maxValue
	BL scanf
	LDR r4, =maxValue
	LDR r4, [r4]

	# Generate correct guess by selecting a number between 1 and maxValue, by multiplying maxValue*(0-999)/1000 + 1
	MUL r0, r4, r7
	MOV r1, #1000
	BL __aeabi_idiv	
	ADD r0, r0, #1
	MOV r9, r0

	# prompt the user for a guess
	LDR r0, =promptGuess
	MOV r1, r4
	BL printf
	LDR r0, =decFormat
	LDR r1, =guess
	BL scanf
	LDR r8, =guess // store the guess in register 8
	LDR r8, [r8]
	
	
	# Iterate until the correct number has been obtained 

	loop: 
		ADD r5, r5, #1 // increment loop counter
		
		# check for correct guess
		CMP r8, r9
		BEQ endLoop

		BLT guessHigher
			// tell the user to guess lower if the guess was too high
			LDR r0, =lower
			BL printf
			B askAgain
		guessHigher: 
			// tell the user to guess higher if the guess was too low
			LDR r0, =higher
			BL printf
		askAgain: 


		# prompt the user for a guess
		LDR r0, =promptGuess
		MOV r1, r4
		BL printf
		LDR r0, =decFormat
		LDR r1, =guess
		BL scanf
		LDR r8, =guess // store the guess in register 8
		LDR r8, [r8]

		B loop // start loop all over again

	endLoop: 

	# print out victory conditions
	LDR r0, =won
	MOV r1, r9 // the correct number
	MOV r2, r5 // how many tries it took
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
	promptGuess: .asciz "\nGuess a value from 1 to %d: "
	promptNum: .asciz "\nNumber is %d: \n"
	decFormat: .asciz "%d" 
	maxValue: .word 0
	guess: .word 0
	higher: .asciz "\n the number is higher\n" 
	lower: .asciz "\n the number is lower\n"
	won: .asciz "\n You guess the number %d correctly in %d tries!\n"
