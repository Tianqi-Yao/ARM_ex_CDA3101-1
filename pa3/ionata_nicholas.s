//
//  pa3.s
//  
//
//  Created by Nicholas Ionata on 4/14/19.
//

.data
	newline:                .asciz "\n"
	input_specifier: 		.asciz "%d %d"
	decimal_specifier:      .asciz "%d"

	input_m_buffer: 		.space 256
	input_n_buffer:			.space 256

	input_string:			.asciz "Enter Two Integers: "
	div_by_zero_err: 		.asciz "Divide by zero error"

.global main
.text

#19, m
#20, n
#21, %
#22, temp
#23, GCD

main:
	//Prompt for user input
	ldr x0, =input_string
	bl printf

	//Take user input
	ldr x0, =input_specifier
	ldr x1, =input_m_buffer
	ldr x2, =input_n_buffer
	bl scanf

	//Load m and n into more permanent registers
	ldr x19, =input_m_buffer
	ldrsw x19, [x19]
	ldr x20, =input_n_buffer
	ldrsw x20, [x20]

	//Check if m is negative
	cmp x19, #0
	b.lt MABSOLUTE

	//Check if n is negative
	cmp x20, #0
	b.lt NABSOLUTE

	//Start the recursive calls
	bl GCD

MABSOLUTE:
	//Flip the sign
	neg x19, x19

	//Check if n is negative
	cmp x20, #0
	b.lt NABSOLUTE

	//Start the recursive calls
	bl GCD

NABSOLUTE:
	//Flip the sign
	neg x20, x20

	//Start the recursive calls
	bl GCD

GCD:
	//Set the stack pointer and store m, n, and return address
	sub sp, sp, #32
	str x19, [sp, #16]
	str x20, [sp, #8]
	str x30, [sp, #0]

	//If m < n, swap the variables
	cmp x19, x20
	b.lt SWAP

	//Handles zeros as one of the variables
	cbz x20, ZERO

	//Perform M modulo N and save the result in x21
	bl MOD

	//Move answer to x23 for printing
	mov x23, x20

	//If modulo is 0, then n is GCP
	cbz x21, POP

	//Modulo != 0, so try again by shifting the divisor
	mov x19, x20
	mov x20, x21
	bl GCD

SWAP:
	//Swap the variables if M is less than N
	mov x22, x19
	mov x19, x20
	mov x20, x22
	bl GCD

ZERO:
	//Load the error mess
	mov x23, x19
	bl PRINT

MOD:
	//Divide m by n
	udiv x21, x19, x20

	//Multiply the floored quotient
	mul x21, x21, x20

	//Subtract to get the remainder
	subs x21, x19, x21

	//Return
	br x30

POP:
	//Restore values from the stack
	ldr x19, [sp, #16]
	ldr x20, [sp, #8]
	ldr x30, [sp, #0]
	add sp, sp, #32

	//Print the final output
	bl PRINT

PRINT:
	//Print gcd
	ldr x0, =decimal_specifier
	mov x1, x23
	bl printf
	bl FLUSH
	b exit

FLUSH:
	//Store return address
	mov x29, x30

	//Clear the buffer
	ldr x0, =newline
	bl printf

	//Return to branch location
	br x29
 
exit:
	mov x0, #0
	mov x8, #93
	svc #0
