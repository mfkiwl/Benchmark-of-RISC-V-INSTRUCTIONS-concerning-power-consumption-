#include "macros.h"	
	.text
	.globl	_start
	.org	0x00000000
_start:
li x5, 0x80000000
li x6, 0x00100000
li x1, 0x00000012
li x3, 0x00000000
loop:
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
lw x9, 1024(x5)
add x3, x3, x1
bne x3, x6, loop
exit:   
	.end	start
