.globl lab03c

lab03c:
	ADRP X4, UIN //load address of UIN into X4
	ADD X4, X4, :lo12:UIN
	
	ADRP X7, my_array //load address of my_array into X5
	ADD X7, X7, :lo12:my_array
	
	AND X3, X3, XZR //initialize X3 to 0. X3 will represent i
	LDUR X0, [X4, #0] //load UIN into X0

loop:
	SUB X1, X3, #10 //subtract 10 from i and store the difference in X1
	CBZ X1, quit //if the difference is 0, we know the loop is over
	
	STUR X0, [X7, #0] //store j, which is in X0 into X7 at its current address
	
	ADD X7, X7, #4 //increment X5 by 4 bytes so that in the next iteration, 
				   //line 17 will store j in the next word, i.e. the next
				   //array index
	
	ADD X0, X0, #1 //increment j by 1
	
	ADD X3, X3, #1 //increment i by 1
	
	B loop //break and go to top of loop

quit:
	BR X30 //return to main


.section .data

UIN:
.word 42

my_array:
.space 40 //because there are 10 array spaces and 
