addi x20, x0, 0

lw x9, va
addi x5, x0, 5
blt x9, x5, Else

lw x9, vb
addi x5, x0, 65
blt x9, x5, Final_Comp
bne x9, x5, Else

Final_Comp:
	lw x9, vc
	addi x5, x0, 15
	blt x9, x5, Else
	beq x9, x5, Else

addi x20, x0, 1

Else: sw x20, vx
halt

va:.word 0x10
vb:.word 0x10
vc:.word 0x10
vx:.word 0x10
