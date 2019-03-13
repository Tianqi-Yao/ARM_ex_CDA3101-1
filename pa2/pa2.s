//
//  main.s
//  
//
//  Created by Nicholas Ionata on 3/12/19.
//

.data
	newline:                .asciz "\n"
	input_specifier: 		.asciz "%s"
	input_buffer: 			.space 256
	voided_char:			.asciz "x"

.global main
.text

main:
	//Take user input
	ldr x0, =input_specifier
	ldr x1, =input_buffer
	bl scanf

	ldr x19, =input_buffer
	//Empty string in x20
	//Loop through the string
		//Save curr char in x21
		//Branch to check_vowels
		//Append whatever val in x21 to string in x20
	//Print string in x20

	bl check_vowels
	b exit

check_vowels:
	cmp x21, #97
	beq void_char

	cmp x21, #101
	beq void_char

	cmp x21, #105
	beq void_char

	cmp x21, #111
	beq void_char

	cmp x21, #117
	beq void_char

	br x30

void_char:
	ldr x20, =voided_char
	br x30

exit:
	ldr x0, =newline
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0
