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
	string_specifier: 		.asciz "%s"

	int_a_input_buffer:		.word 0
	int_b_input_buffer:		.word 0
	char_input_buffer: 		.space 1

	operator_err_message: 	.asciz "That is not a valid operator"
	div_err_message:		.asciz "Divide by 0 error"

.global main
.text

main:
	//Take user input
	ldr x0, =input_specifier
	ldr x1, =int_a_input_buffer
	ldr x2, =int_b_input_buffer
	ldr x3, =char_input_buffer
	bl scanf

	//Load registers from corresponding buffers
	ldr x19, =int_a_input_buffer
	ldr x19, [x19]
	ldr x20, =int_b_input_buffer
	ldr x20, [x20]
	ldr x3, =char_input_buffer
	ldrb w21, [x3, #0]

	//Select the corresponding operator
	bl OPERATOR

	//Print output when the corresponding operator subroutine returns
	ldr x0, =decimal_specifier
	mov x1, x21
	bl printf
	b exit

OPERATOR:
	//If char is +, add a and b
	cmp w21, #43
	beq ADD

	//If char is -, subtract b from a
	cmp w21, # 45
	beq SUB

	//If char is *, mutiply a by b
	cmp w21, #42
	beq MUL

	//If char is /, divide a by b
	cmp w21, #47
	beq DIV

	//If this is reached, a valid operator was not used
	ldr x0, =operator_err_message
	bl printf
	b exit

ADD:
	add x21, x19, x20
	br x30

SUB:
	sub x21, x19, x20
	br x30

MUL:
	mul x21, x19, x20
	br x30

DIV:
	//Check if b is a zero
	cbz w20, DIV_BY_ZERO

	sdiv w21, w19, w20
	br x30

DIV_BY_ZERO:
	ldr x0, =div_err_message
	bl printf
	b exit

exit:
	ldr x0, =newline
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0
