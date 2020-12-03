
.section .text
.globl test2

test2:
	sub	X1, X0, X1 //subtract 5 from 6 and store in X1
	
	sub sp, sp, #16 //free space on stack
	stur X30, [sp, 0] //store return address on stack
	
	adr X0, print //store address of print function on X0
	bl printf //call printf by branching to it
	
	ldur X30, [sp, 0] //restore return address to X30
	add sp, sp, #16 // restore the stack
	br X30 //return home
	
.section .data
print: .asciz "Result of test2(6, 5) = %d\n"
