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

# coloca um numero no registrador, pq 
# transforma em binario e cada bit
# vai para uma porta (comecando do g até b)	

# Limpar:
addi x12, x0, 0
addi x13, x0, 000000

addi x5, x0, 15
beq x10, x5, PRINTAR

# Zero:
addi x12, x0, 1 # Passa os parametros
addi x13, x0, 31

beq x10, x0, PRINTAR # Verifica se é para printar

# Um:
addi x12, x0, 0
addi x13, x0, 3

addi x5, x0, 1
beq x10, x5, PRINTAR	

# Dois:
addi x12, x0, 1
addi x13, x0, 45

addi x5, x5, 1
beq x10, x5, PRINTAR

# Tres: 
addi x12, x0, 1
addi x13, x0, 39

addi x5, x5, 1
beq x10, x5, PRINTAR

# Quatro:
addi x12, x0, 0
addi x13, x0, 51

addi x5, x5, 1
beq x10, x5, PRINTAR

# Cinco:
addi x12, x0, 1
addi x13, x0, 54

addi x5, x5, 1
beq x10, x5, PRINTAR

# Seis:
addi x12, x0, 1
addi x13, x0, 62

addi x5, x5, 1
beq x10, x5, PRINTAR

# Sete:
addi x12, x0, 1
addi x13, x0, 3

addi x5, x5, 1
beq x10, x5, PRINTAR

# Oito:
addi x12, x0, 1
addi x13, x0, 63

addi x5, x5, 1
beq x10, x5, PRINTAR

# Nove:
addi x12, x0, 1
addi x13, x0, 51

addi x5, x5, 1
beq x10, x5, PRINTAR

# Passando os valores para as portas
# do display 

PRINTAR:	
	sb x12, 1029(x0)
	sb x13, 1027(x0)
	halt
