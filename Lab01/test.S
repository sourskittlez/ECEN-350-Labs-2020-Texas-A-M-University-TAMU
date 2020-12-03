.globl test

test :
LSR X1, X0, #6  //computation 1, result is in $X1
LSL X2, X0, #6 //computation 2, result is in $X2
ADD X0, X1, X2
BR X30 // return from main ; return address stored in X30


