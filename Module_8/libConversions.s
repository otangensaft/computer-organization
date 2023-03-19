# Title: libConversions.s
# Description: Library of functions that demonstrates the use of pointer counter and link register, when used in conjunction with main functions such as InchesToFt.s
# Author: Danny Tang
# Written: March 19, 2023
# Class: Introduction to Computer Organization
# Instructor: Professor Miriam Lorbert


.global CtoF 
.global InchesToFt 
.global Miles2Kilometers
.global KPH

.text 
CtoF: 
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]
	
	# r0 = (r0)*9/5+32
	MOV r1, #9
	MUL r0, r0, r1
	MOV r1, #5
	BL __aeabi_idiv
	MOV r1, #32
	ADD r0, r0, r1

	# pop stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
	
#END CtoF



.text
InchesToFt:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]

	# Convert inches to feet
	MOV r1, #12
	BL __aeabi_idiv

	# pop stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

#END InchesToFt


.text 
Miles2Kilometers:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]

	# convert miles to kilometers, r0 = r0*16/10, to avoid rounding error
	MOV r1, #16
	MUL r0, r0, r1
	MOV r1, #10
	BL __aeabi_idiv
	
	# pop stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

#END Miles2Kilometers
	
.text 
KPH:
	# push stack
	SUB sp, sp, #4
	STR lr, [sp]

	# stow away hours
	MOV r8, r0

	# Convert Miles to Kilometers
	MOV r0, r1
	BL Miles2Kilometers

	# Divide by hours
	MOV r1, r8
	BL __aeabi_idiv
	
	
	# pop stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr

#END KPH




	
	
	
