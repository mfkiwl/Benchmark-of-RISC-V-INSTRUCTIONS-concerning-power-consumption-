/* Benchmark assembly code for 100% Cache MISS */
/*ASSUMPTION IS THAT THE SIZE OF CACHE IS 64 WORDS , AND EACH WORD IS OF 4 BYTE (32 BIT ) LENGTH . */

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
lw x9, 0(x5)
lw x9, 64(x5)
lw x9, 128(x5)
lw x9, 192(x5)
lw x9, 256(x5)
lw x9, 320(x5)
lw x9, 384(x5)
lw x9, 448(x5)
lw x9, 512(x5)
lw x9, 576(x5)
lw x9, 640(x5)
lw x9, 704(x5)
lw x9, 768(x5)
lw x9, 832(x5)
lw x9, 896(x5)
lw x9, 960(x5)
lw x9, 1024(x5)
lw x9, 1088(x5)
add x3, x3, x1
bne x3, x6, loop
exit:   
	.end	start
