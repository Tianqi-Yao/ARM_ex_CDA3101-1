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
	mov x20, #0

	loop:
		ldrb w21, [x19, x20]
		cbz w21, exit_loop

		bl check_vowels
		strb w21, [x19, x20]
		add x20, x20, #1
		b loop

	exit_loop:
		mov x0, x19
		bl printf
		b exit

check_vowels:
	cmp w21, #97
	beq void_char

	cmp w21, #101
	beq void_char

	cmp w21, #105
	beq void_char

	cmp w21, #111
	beq void_char

	cmp w21, #117
	beq void_char

	br x30

void_char:
	ldr w21, =voided_char
	br x30

exit:
	ldr x0, =newline
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0
