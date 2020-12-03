.globl lab03b

lab03b:
	//load address of UIN into X4
	ADRP X4, UIN
	ADD X4, X4, :lo12:UIN
	
	AND X5, X5, XZR //initialize X5 to 0. X5 will represent i
	LDUR X0, [X4, #0] //load X4, which is UIN, into X0

loop:
	SUB X1, X5, #10 //subtract 10 from i and store the difference in X1
	CBZ X1, quit //if the difference is 0, we know the loop is over
	
	SUB X0, X0, #1 //subtract 1 from UIN, which is in X0
	ADD X5, X5, #1 //increment i by 1
	
	B loop //break and go to top of loop

quit:
	BR X30 //return to main


.section .data
UIN:
.word 42
