//
//  main.s
//  
//
//  Created by Nicholas Ionata on 2/14/19.
//

.data
	newline:                .asciz "\n"
	input_specifier:		.asciz "%d %d %c"
	decimal_specifier:      .asciz "%d"

	int_a_input_buffer:		.space 4
	int_b_input_buffer:		.space 4
	char_input_buffer: 		.space 1

.global main
.text

main:
	//Take user input
	ldr x0, =input_specifier
	ldr x1, =int_a_input_buffer
	ldr x2, =int_b_input_buffer
	ldr x3, =char_input_buffer
	bl scanf

	//Load registers with their values from the saved addresses
	ldr x1, =int_a_input_buffer
	ldr x1, [x1]
	ldr x2, =int_b_input_buffer
	ldr x2, [x2]
	ldr x3, =char_input_buffer



	ldr x0, =decimal_specifier
	bl DIV

ADD:
	add x1, x1, x2
	bl printf

SUB:

MUL:

DIV:
	cbz x2, exit

exit:
	ldr x0, =newline
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0
