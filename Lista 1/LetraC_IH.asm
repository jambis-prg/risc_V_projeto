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
slli x31, x29, 3 #salva valor * 8 em x31
slli x29, x29, 1 #salva valor * 2 em x29
add x29, x29, x31 #salva 8x + 2x em x29

# Soma o valor da dezena e unidade de A
add x19, x29, x30

sw x19, va

lb x20, 1025(x0) # sinal de B
lb x29, 1025(x0) # Decimal de B
lb x30, 1025(x0) # Unidade de B

sub x29, x29, x5 # conversão ascii
sub x30, x30, x5

# Mult por 10
slli x31, x29, 3 #salva valor * 8 em x31
slli x29, x29, 1 #salva valor * 2 em x29
add x29, x29, x31 #salva 8x + 2x em x29

# Soma o valor da dezena e unidade de B
add x21, x29, x30

sw x21, vb

lb x22, 1025(x0) # sinal de C
lb x29, 1025(x0) # Decimal de C
lb x30, 1025(x0) # Unidade de C

sub x29, x29, x5 # conversão ascii
sub x30, x30, x5

# Mult por 10
slli x31, x29, 3 #salva valor * 8 em x31
slli x29, x29, 1 #salva valor * 2 em x29
add x29, x29, x31 #salva 8x + 2x em x29

# Soma o valor da dezena e unidade de C
add x23, x29, x30

sw x23, vc

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

	beq x22, x6, Else # compara sinal de c
	blt x23, x5, Else 
	beq x23, x5, Else

addi x24, x0, 1

# Mostrar na tela
Else: 
	addi x24, x24, 48
	sb x24, 1024(x0)
	sw x24, vx
halt

va : .word 0x00
vb : .word 0x00
vc : .word 0x00
vx : .word 0x00
