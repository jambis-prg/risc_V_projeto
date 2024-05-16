#x18 - Sinal de A , x19 - valor de A
#x20 - Sinal de B , x21 - valor de B
#x22 - Sinal de C , x23 - valor de C
#x23 - valor de X

# Converter char em int
addi x5, x0, 48 
addi x6, x0, 10

# Lendo numeros:
lb x18, 1025(x0) # sinal de A
lb x29, 1025(x0) # decimal de A
lb x30, 1025(x0) # Unidade de A

sub x29, x29, x5 # conversão ascii
sub x30, x30, x5

# Mult por 10
add x31, x29, x0 # salvo valor
slli x29, x29, 2 # x29 = valor * 4
add x31, x31, x29 # x31 = valor * 5
slli x29, x31, 1 # x29 = valor * 10

# a
add x19, x29, x30

lb x20, 1025(x0) # sinal de B
lb x29, 1025(x0) # Decimal de B
lb x30, 1025(x0) # Unidade de B

sub x29, x29, x5
sub x30, x30, x5

# Mult por 10
add x31, x29, x0 # salvo valor
slli x29, x29, 2 # x29 = valor * 4
add x31, x31, x29 # x31 = valor * 5
slli x29, x31, 1 # x29 = valor * 10

# b
add x21, x29, x30

lb x22, 1025(x0) # sinal de C
lb x29, 1025(x0) # Decimal de C
lb x30, 1025(x0) # Unidade de C

sub x29, x29, x5
sub x30, x30, x5

# Mult por 10
add x31, x29, x0 # salvo valor
slli x29, x29, 2 # x29 = valor * 4
add x31, x31, x29 # x31 = valor * 5
slli x29, x31, 1 # x29 = valor * 10

# c
add x23, x29, x30

# Terminou de ler
# x = 0
add x24, x0, x0

# Comparação de a
addi x5, x0, 5 
addi x6, x0, 45 # sinal de -

beq x18, x6, Else # compara sinal de a
blt x19, x5, Else # comp se a < 5

# Comparação de b
addi x5, x0, 65

beq x20, x6, Final_Comp # compara sinal de b
blt x21, x5, Final_Comp # comp se b < 65
bne x21, x5, Else

# Comparação de c
Final_Comp:
	addi x5, x0, 15
	addi x6, x0, 45 # sinal de -

	beq x22, x6, Else # compara sinal de c
	blt x23, x5, Else 
	beq x23, x5, Else

addi x24, x0, 1
addi x5, x0, 1
beq x24, x5, End
# Mostrar na tela
Else:
    addi x24, x24, 48
	sb x24, 1024(x0)

End:
    halt
