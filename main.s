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

	int_a_input_buffer:		.space 4
	int_b_input_buffer:		.space 4
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

	//Load registers with their values from the saved addresses
	ldr x19, =int_a_input_buffer
	ldr x19, [x19]
	ldr x20, =int_b_input_buffer
	ldr x20, [x20]
	ldr x3, =char_input_buffer
	ldrb w21, [x3, #0]

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
	ldr x0, =decimal_specifier
	add x1, x19, x20
	bl printf
	b exit

SUB:
	ldr x0, =decimal_specifier
	sub x1, x19, x20
	bl printf
	b exit

MUL:
	ldr x0, =decimal_specifier
	mul x1, x19, x20
	bl printf
	b exit

DIV:
	//Trynna catch 0 b vars
	//cbz x20, DIV_BY_ZERO
	//sub x0, x20, #0
	//cbz x0, DIV_BY_ZERO

	//Checking b arg
	//ldr x0, =decimal_specifier
	//mov x1, x20
	//bl printf

	b exit

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
