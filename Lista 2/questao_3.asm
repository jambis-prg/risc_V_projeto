# Converter char em int
addi x5, x0, 48 
addi x6, x0, 10

# NUM 1:
lb x7, 1025(x0) # digito 1
lb x28, 1025(x0) # digito 2
lb x29, 1025(x0) # digito 3
lb x30, 1025(x0) # digito 4
lb x31, 1025(x0) # digito 5

# Conversao ascii
sub x7, x7, x5
sub x28, x28, x5
sub x29, x29, x5
sub x30, x30, x5
sub x31, x31, x5

# DIGITO 5 * 10000
# Carregando 10000 no arg a
addi x12, x0, 1250
slli x12, x12, 3

# Carregando digito 1 no arg b
addi x13, x7, 0

jal x1, Mul
addi x18, x10, 0

# DIGITO 4 * 1000
addi x12, x0, 1000
add x13, x0, x28
jal x1, Mul
add x18, x18, x10

# DIGITO 3 * 100
addi x12, x0, 100
add x13, x0, x29
jal x1, Mul
add x18, x18, x10

# DIGITO 2 * 10
addi x12, x0, 10
add x13, x0, x30
jal x1, Mul
add x18, x18, x10

# - RESULTADO de A -
add x18, x18, x31

# a = x18
sw x18, a 

# NUM 2:
lb x7, 1025(x0) # Espaço
lb x7, 1025(x0) # digito 1
lb x28, 1025(x0) # digito 2
lb x29, 1025(x0) # digito 3
lb x30, 1025(x0) # digito 4
lb x31, 1025(x0) # digito 5

# Conversao ascii
sub x7, x7, x5
sub x28, x28, x5
sub x29, x29, x5
sub x30, x30, x5
sub x31, x31, x5

# DIGITO 5 * 10000
# Carregando 10000 no arg a
addi x12, x0, 1250
slli x12, x12, 3

# Carregando digito 1 no arg b
addi x13, x7, 0

jal x1, Mul
addi x19, x10, 0

# DIGITO 4 * 1000
addi x12, x0, 1000
add x13, x0, x28
jal x1, Mul
add x19, x19, x10

# DIGITO 3 * 100
addi x12, x0, 100
add x13, x0, x29
jal x1, Mul
add x19, x19, x10

# DIGITO 2 * 10
addi x12, x0, 10
add x13, x0, x30
jal x1, Mul
add x19, x19, x10

# - RESULTADO de B -
add x19, x19, x31

add x12, x18, x0 # Salva x18 em x12
add x13, x19, x0 # Salva x19 em x13
jal x1, Mul

halt

#x12 = a -- x13 = b
Mul:
	beq x12, x0, Exit_Loop
	beq x13, x0, Exit_Loop
	addi x10, x0, 0
	addi x5, x0, 1

	Mul_Loop:
		and x6, x13, x5
		bne x5, x6, C1
		add x10, x10, x12

		C1:
			slli x12, x12, 1
			srli x13, x13, 1

		beq x12, x0, Exit_Loop
		bne x13, x0, Mul_Loop

	Exit_Loop:
		jalr x0, 0(x1)

a: .word 0x00
b: .word 0x00
sp: .word 0x00
