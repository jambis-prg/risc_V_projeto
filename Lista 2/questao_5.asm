#Portas: A0 - Temperatura, 6 - Amarelo esquerda, 10 - Verde esquerda
# 11 - Verde direita, 9 - Amarelo direita, 
# 5 - Vermelho direita, 3 - Vermelho esquerda

#x12 é o parametro da func de acender

lb x10, 0(x0) #Porta A0 para temperatura
sb x10, 1030(x0)

loop:

	lh x10, 1031(x0)
	
	# Caso 1
	addi x5, x0, 306 # valor pro 15
	addi x12, x0, 6 # Parametro para amarelo esquerda
	
	blt x10, x5, Acender #Verificando se é menor
	beq x10, x5, Acender #Ou igual para acender
	
	# Caso 2
	addi x5, x0, 409 # valor pro 20
	addi x12, x0, 10 # Parametro para verde esquerda
	
	blt x10,x5, Acender
	beq x10, x5, Acender

	# Caso 3
	addi x5, x0, 511# valor pro 25
	addi x12, x0, 11 #Parametro para verde direita

	blt x10,x5, Acender 
	beq x10, x5, Acender 

	# Caso 4
	addi x5, x0, 613 # valor pro 30
	addi x12, x0, 9 # Parametro para amarelo direita

	blt x10,x5, Acender
	beq x10, x5, Acender

	# Caso 5
	addi x5, x0, 716 # valor pro 35
	addi x12, x0, 5 # Parametro para vermelho direita

	blt x10,x5, Acender 
	beq x10, x5, Acender 
	
	#Caso 6
	addi x12, x0, 3 # Parametro para vemelho esquerda
	beq x0, x0, Acender
	
	Acender:
		sb x12, 1033 (x0) # selecionando porta

		addi x11, x0, 1000 # acender led
		sb x11, 1034 (x0)

		addi x11, x0, 0 # desligar led
		sb x11, 1034 (x0)

		beq x0,x0, loop
