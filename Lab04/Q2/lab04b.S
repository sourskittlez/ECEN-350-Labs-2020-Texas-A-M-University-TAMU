        .globl lab04b

lab04b: 
	SUB SP, SP, #16		//store n and return address on stack
	STUR LR, [SP, #8]
	STUR X0, [SP, #0]
	
	CBNZ X0, else		//if n ! = 0, go to else statement
	
	ORR X1, XZR, #1		//return 1 X1
	
	ADD SP, SP, #16		//pop stack without restoring
						//values because we're at the
						//of the stack frame
	
	BR LR				//time to return home boys
	
else:
	SUB X0, X0, 1		//n - 1
	BL lab04b			//call fact(n-1) we'll return
						//back here after function call
	
	LDUR X0, [SP, #0]	//restore n from caller
	LDUR LR, [SP, #8]	//restore LR from caller
	ADD SP, SP, #16 	//pop stack
	
	SUB SP, SP, #16		//store return address on stack
	STUR LR, [SP, #8]
	
	BL my_mul			//multiply n and the previous function call
	ADD X1, X0, XZR 	//store result of my_mul in X1
	
	LDUR LR, [SP, #8]	//restore LR from caller
	ADD SP, SP, #16
	
	BR LR
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
my_mul:
	SUB SP, SP, 16
        STUR X19, [SP, 0]       //push X19
        ADD X19, X1, XZR        //set X19 equal to X1
        ADD X9, XZR, XZR      //set X9 to 0
mult_loop:
        CBZ X19,  mult_eol
        ADD X9, X9, X0
        SUB X19, X19, 1
        B mult_loop
mult_eol:
        LDUR X19, [SP, 0]
        ADD SP, SP, 16
        ADD X0, X9, XZR         // Move X9 to X0 to return
        BR X30


	
