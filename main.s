//
//  main.s
//  
//
//  Created by Nicholas Ionata on 2/14/19.
//

.data
	newline:                .asciz "\n"

	decimal_specificer:     .asciz "%d"
	int_a_buffer:			.space 4
	int_b_buffer:			.space 4

	char_specifier:      	.asciz "%c"
	char_buffer: 			.space 1

.global main
.text

main:
	ldr x0, =char_specificer
	ldr x1, =char_buffer
	bl scanf

	ldr x1, =char_buffer
	bl printf

	ldr x0, =newLine
	bl printf

exit:
	mov x0, #0
	mov x8, #93
	svc #0
