#x18 - Sinal de A , x19 - valor de A
#x20 - Sinal de B , x21 - valor de B
#x22 - Sinal de C , x23 - valor de C
#x23 - valor de X

# Converter char em int
addi x5, x0, 48 
addi x6, x0, 10

# Lendo numeros:

lb x18, 1025(x0) #sinal de A
lb x29, 1025(x0) #decimal de A
lb x30, 1025(x0) #Unidade de A

sub x29, x29, x5 #conversão ascii
sub x30, x30, x5

#Mult por 10
add x31, x29, x0 #dx salvo valor
slli x29, x29, 2 #x4
add x31, x31, x29 #x5
slli x29, x31, 1 #x10

addi x19, x0, 0 
add x19, x19, x29
add x19, x19, x30 

lb x20, 1025(x0) #sinal de B
lb x29, 1025(x0) #Decimal de B
lb x30, 1025(x0) #Unidade de B

sub x29, x29, x5
sub x30, x30, x5

#Mult por 10
add x31, x29, x0 #dx salvo valor
slli x29, x29, 2 #x4
add x31, x31, x29 #x5
slli x29, x31, 1 #x10

addi x21, x0, 0 
add x21, x21, x29
add x21, x21, x30

lb x22, 1025(x0) #sinal de C
lb x29, 1025(x0) #Decimal de C
lb x30, 1025(x0) #Unidade de C

sub x29, x29, x5
sub x30, x30, x5

#Mult por 10
add x31, x29, x0 #dx salvo valor
slli x29, x29, 2 #x4
add x31, x31, x29 #x5
slli x29, x31, 1 #x10

addi x23, x0, 0
add x23, x23, x29
add x23, x23, x30

# Terminou de ler

add x24, x0, x0 ## nosso X

# Comparação 1
addi x5, x0, 5 
addi x6, x0, 45 #sinal de -

beq x18, x6, Else
blt x19, x5, Else

# Comparação 2
addi x5, x0, 65
addi x6, x0, 43 #sinal de +

beq x20, x6, Else
blt x21, x5, Final_Comp
bne x21, x5, Else

#Comparação 3
Final_Comp:
	addi x5, x0, 15
	addi x6, x0, 45

	beq x22, x6, Else
	blt x23, x5, Else
	beq x23, x5, Else

addi x24, x0, 1

#Mostrar na tela
Else:		addi x24, x24, 48
		sb x24, 1024(x0)

halt

