lb x10, 0(x0)
sb x10, 1030(x0)

loop:

	lh x10, 1031(x0)
	
	addi x5, x0, 306 #(valor pro 15)
	blt x10, x5, Caso_1 # amarelo esquerda 
	beq x10, x5, Caso_1# amarelo esquerda

	addi x5, x0, 409 # valor pro 20
	blt x10,x5, Caso_2# verde esquerda
	beq x10, x5, Caso_2# verde esquerda

	addi x5, x0, 511# valor pro 25
	blt x10,x5, Caso_3 # verde direita
	beq x10, x5, Caso_3 # verde direita

	addi x5, x0, 613# valor pro 30
	blt x10,x5, Caso_4 # amarelo direita
	beq x10, x5, Caso_4 # amarelo direita

	addi x5, x0, 716# valor pro 35
	blt x10,x5, Caso_5 # vermelho direita
	beq x10, x5, Caso_5 # vrmelho direita

	beq x0, x0, Caso_6 # vermelho esquerda

	Caso_1:
		addi x10, x0, 6 # selecionando porta
		sb x10, 1033 (x0)

		addi x11, x0, 1000 # acender led
		sb x11, 1034 (x0)

		addi x11, x0, 0 # desligar led
		sb x11, 1034 (x0)

		beq x0,x0, loop
	Caso_2:
		addi x10, x0, 10
		sb x10, 1033 (x0)
		addi x11, x0, 1000
		sb x11, 1034 (x0)
		addi x11, x0, 0
		sb x11, 1034 (x0)
		beq x0,x0, loop
	Caso_3:
		addi x10, x0, 11
		sb x10, 1033 (x0)
		addi x11, x0, 1000
		sb x11, 1034 (x0)
		addi x11, x0, 0
		sb x11, 1034 (x0)
		beq x0,x0, loop
	Caso_4:
		addi x10, x0, 9
		sb x10, 1033 (x0)
		addi x11, x0, 1000
		sb x11, 1034 (x0)
		addi x11, x0, 0
		sb x11, 1034 (x0)
		beq x0,x0, loop
	Caso_5:
		addi x10, x0, 5
		sb x10, 1033 (x0)
		addi x11, x0, 1000
		sb x11, 1034 (x0)
		addi x11, x0, 0
		sb x11, 1034 (x0)
		beq x0,x0, loop
	Caso_6:
		addi x10, x0, 3
		sb x10, 1033 (x0)
		addi x11, x0, 11000
		sb x11, 1034 (x0)
		addi x11, x0, 0
		sb x11, 1034 (x0)
		beq x0,x0, loop
