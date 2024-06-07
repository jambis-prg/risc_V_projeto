#Portas:
# a - 2, b - 8, c - 9, d - 10 e assim sucessivamente

# Converter char em int
addi x5, x0, 48 

# Lendo números:
lb x28, 1025(x0) # Bit D
lb x29, 1025(x0) # Bit C
lb x30, 1025(x0) # Bit B
lb x31, 1025(x0) # Bit A

# Converter ASCII para número
sub x28, x28, x5
sub x29, x29, x5
sub x30, x30, x5
sub x31, x31, x5 

# Convertendo o binario para decimal
slli x28, x28, 3 # 2^3
slli x29, x29, 2 # 2^2
slli x30, x30, 1 # 2^1

# Calculando o numero
add x10, x28, x29
add x10, x10, x30
add x10, x10, x31

#Comparações para vê qual ope fazer
addi x5, x0, 15
beq x10, x5, LIMPAR

beq x10, x0, ZERO

addi x5, x0, 1
beq x10, x5, UM

addi x5, x5, 1
beq x10, x5, DOIS

addi x5, x5, 1
beq x10, x5, TRES

addi x5, x5, 1
beq x10, x5, QUATRO

addi x5, x5, 1
beq x10, x5, CINCO

addi x5, x5, 1
beq x10, x5, SEIS

addi x5, x5, 1
beq x10, x5, SETE

addi x5, x5, 1
beq x10, x5, OITO

addi x5, x5, 1
beq x10, x5, NOVE

# Passando os valores para as portas
# do display 
ZERO:
	addi x6, x0, 1
	sb x6, 1029(x0)
	#coloca um numero no registrador, pq 
	#transforma em binario e cada bit
	# vai para uma porta (comecando do g até b)
	addi x6, x0, 31
	sb x6, 1027(x0)
	beq x0,x0, ACABAR

UM:
	sb x0, 1029(x0)
	addi x6, x0, 3
	sb x6, 1027(x0)
	beq x0,x0, ACABAR

DOIS:
	addi x6, x0, 1
	sb x6, 1029(x0)
	addi x6, x0, 45
	sb x6, 1027(x0)
	beq x0,x0, ACABAR

TRES:
	addi x6, x0, 1
	sb x6, 1029(x0)
	addi x6, x0, 39
	sb x6, 1027(x0)
	beq x0,x0, ACABAR

QUATRO:
	sb x0, 1029(x0)
	addi x6, x0, 51
	sb x6, 1027(x0)
	beq x0,x0, ACABAR
CINCO:
	addi x6, x0, 1
	sb x6, 1029(x0)
	addi x6, x0, 54
	sb x6, 1027(x0)
	beq x0,x0, ACABAR
SEIS:
	addi x6, x0, 1
	sb x6, 1029(x0)
	addi x6, x0, 62
	sb x6, 1027(x0)
	beq x0,x0, ACABAR

SETE:
	addi x6, x0, 1
	sb x6, 1029(x0)
	addi x6, x0, 3
	sb x6, 1027(x0)
	beq x0,x0, ACABAR

OITO:
	addi x6, x0, 1
	sb x6, 1029(x0)
	addi x6, x0, 63
	sb x6, 1027(x0)
	beq x0,x0, ACABAR

NOVE:
	addi x6, x0, 1
	sb x6, 1029(x0)
	addi x6, x0, 51
	sb x6, 1027(x0)
	beq x0,x0, ACABAR


LIMPAR:
	addi x6, x0,000000
	sb x0, 1029(x0)
	sb x6, 1027(x0)

ACABAR:
	halt
