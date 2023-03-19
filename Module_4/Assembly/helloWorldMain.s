.text
.global main

main:
    # save return to OS on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Printin gthe Message
    LDR r0, =helloWorld
    BL printf

    # Return to OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Stores the string to be printed
    helloWorld: .asciz "I am a tomato\n"

