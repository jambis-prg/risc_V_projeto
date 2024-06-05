# Converter char em int
addi x5, x0, 48 
addi x6, x0, 10

lb x7, 1025(x0) # digito 1
lb x28, 1025(x0) # digito 2
lb x29, 1025(x0) # digito 3
lb x30, 1025(x0) # digito 4
lb x31, 1025(x0) # digito 5

# Conversão ascii
sub x7, x7, x5
sub x28, x28, x5
sub x29, x29, x5
sub x30, x30, x5
sub x31, x31, x5

# - DIGITO 5 -
# digito 5 vezes 10000
slli x18, x7, 13
slli x19, x7, 10
slli x20, x7, 9
slli x21, x7, 8
slli x22, x7, 4

# Zera x7
# E soma com os valores para que
# x7 = digito 5 * 10000
addi x7, x0, 0
add x7, x18, x19
add x7, x7, x20
add x7, x7, x21
add x7, x7, x22

# - DIGITO 4 -
# digito 4 vezes 1000
slli x18, x28, 9
slli x19, x28, 8
slli x20, x28, 7
slli x21, x28, 6
slli x22, x28, 5
slli x23, x28, 3

# Zera x28
# E soma com os valores para que
# x28 = digito 4 * 1000
addi x28, x0, 0
add x28, x18, x19
add x28, x28, x20
add x28, x28, x21
add x28, x28, x22
add x28, x28, x23

# - DIGITO 3 -
# digito 3 vezes 100
slli x18, x29, 6
slli x19, x29, 5
slli x20, x29, 2

# Zera x29
# E soma com os valores para que
# x29 = digito 3 * 100
addi x29, x0, 0
add x29, x18, x19
add x29, x29, x20

# - DIGITO 2 -
# digito 2 vezes 10
slli x18, x30, 3
add x19, x18, x30
add x19, x19, x30

# Zera x30
# E soma com os valores para que
# x30 = digito 2 * 10
addi x30, x19, 0

# - RESULTADO -
addi x18, x0, 0
add x18, x7, x28
add x18, x18, x29
add x18, x18, x30
add x18, x18, x31

# a = x18
sw x18, a 

sb x18, 1024(x0)
halt

a: .word 0x00
b: .word 0x00
