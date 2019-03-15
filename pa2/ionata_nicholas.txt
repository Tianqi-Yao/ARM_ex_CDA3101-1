//
//  main.s
//  
//
//  Created by Nicholas Ionata on 3/12/19.
//

.data
	newline:                .asciz "\n"
	input_specifier: 		.asciz "%[^\n]"
	char_specifier:			.asciz "%c"
	input_buffer: 			.space 256
	input_string:			.asciz "Input a string: "
	voided_char:			.asciz "x"

.global main
.text

main:
	//Prompt for user input
	ldr x0, =input_string
	bl printf

	//Take user input
	ldr x0, =input_specifier
	ldr x1, =input_buffer
	bl scanf

	//Sets initial register values
	ldr x19, =input_buffer
	mov x20, #-1

	//Loops through each char and checks for vowels
	loop:
		add x20, x20, #1
		ldrb w21, [x19, x20]
		cbz w21, exit
		bl check_vowels

//Checks for a, A, e, E, i, I, o, O, u, U
check_vowels:

	cmp w21, #97
	beq void_char

	cmp w21, #65
	beq void_char

	cmp w21, #101
	beq void_char

	cmp w21, #69
	beq void_char

	cmp w21, #105
	beq void_char

	cmp w21, #73
	beq void_char

	cmp w21, #111
	beq void_char

	cmp w21, #79
	beq void_char

	cmp w21, #117
	beq void_char

	cmp w21, #85
	beq void_char

	//If the current char isn't a vowel, print the original char
	ldr x0, =char_specifier
	mov w1, w21
	bl printf
	b loop

//If the current char is a vowel, print x
void_char:
	ldr x0, =voided_char
	bl printf
	b loop

exit:
	ldr x0, =newline
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0
