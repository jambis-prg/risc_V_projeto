# x26 contador p/ pegar os 2 números
# x27 = 1, limite do loop
addi x26, x0, 0
addi x27, x0, 1

NUM:
    beq x26, x27, espaco # se x26 == 1 então pega o espaço
	jal x0, digitos

    espaco:
        lb x7, 1025(x0) # espaço
	
	digitos:
		lb x7, 1025(x0) # digito 1
		lb x28, 1025(x0) # digito 2
		lb x29, 1025(x0) # digito 3
		lb x30, 1025(x0) # digito 4
		lb x31, 1025(x0) # digito 5

    # Conversao ascii
    addi x7, x7, -48
    addi x28, x28, -48
    addi x29, x29, -48
    addi x30, x30, -48
    addi x31, x31, -48

    # DIGITO 5 * 10000:
    # Carregando 10000 no parametro a de Mul
    addi x12, x0, 1250
    slli x12, x12, 3

    # Carregando digito 1 no parametro b de Mul
    addi x13, x7, 0

    # Faz a multiplicação
    # E soma no resultado
    jal x1, Mul
    addi x18, x10, 0

    # DIGITO 4 * 1000:
    addi x12, x0, 1000
    add x13, x0, x28

    jal x1, Mul
    add x18, x18, x10

    # DIGITO 3 * 100:
    addi x12, x0, 100
    add x13, x0, x29

    jal x1, Mul
    add x18, x18, x10

    # DIGITO 2 * 10
    addi x12, x0, 10
    add x13, x0, x30

    jal x1, Mul
    add x18, x18, x10

    # - RESULTADOS de num1 e num2 -
    add x18, x18, x31
    beq x26, x0, salva_num1 # if x26 == 0: salva num1 em x20

    addi x13, x18, 0 # Salva o num2
    jal x1, mult # calcular num1 x num2

salva_num1:
    addi x20, x18, 0 # salva o num1
    addi x26, x26, 1 # x26++
    jal x0, NUM
        
mult:
    add x12, x20, x0 # Salva num1 em x12
    jal x1, Mul

	
	# contador p/ iterar e pegar os digitos do resultado
	addi x17, x0, 5

jal x1, divisao

    addi x31, x31, 48
    sw x31, 1024(x0)

halt

# Função Mul
# Parametros: x12 = a e x13 = b
Mul:
    addi x10, x0, 0
    addi x5, x0, 1

Mul_Loop:
    and x6, x13, x5   # Verifica se o bit atual do multiplicador é 1
    beq x6, x0, Skip  # Se o bit atual é 0, pula a adição

    add x10, x10, x12 # Adiciona o multiplicando deslocado ao produto

Skip:
    slli x12, x12, 1  # Desloca o multiplicando uma posição à esquerda
    srli x13, x13, 1  # Desloca o multiplicador uma posição à direita

    bne x13, x0, Mul_Loop # Continua até que todos os bits do multiplicador tenham sido processados

Exit_Loop:
    jalr x0, 0(x1) # Retorna a chamada da função


# Função divisao
divisao:
	beq x5, x0, saida

	sub x5, x5, 1	

a: .word 0x00
b: .word 0x00
sp: .word 0x00
