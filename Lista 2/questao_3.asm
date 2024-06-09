# x26: contador para pegar os 2 números
# x27: limite do loop (1)
# x18: valor temporário para armazenar os números

addi x26, x0, 0  # Inicializa contador
addi x27, x0, 1  # Limite do loop

get_num:
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

    # Conversão ascii p/ inteiro
    ascii:
        addi x7, x7, -48
        addi x28, x28, -48
        addi x29, x29, -48
        addi x30, x30, -48
        addi x31, x31, -48

    # DIGITO 5 * 10000:
    digito_5:
        addi x12, x0, 1250
        slli x12, x12, 3 # Carregando 10000 no parametro a de Mul

        # Carregando digito 1 no parametro b de Mul
        addi x13, x7, 0

        # Faz a multiplicação
        # E soma no resultado
        jal x1, Mul
        addi x18, x10, 0

    # DIGITO 4 * 1000:
    digito_4:
        addi x12, x0, 1000
        add x13, x0, x28

        jal x1, Mul
        add x18, x18, x10

    # DIGITO 3 * 100:
    digito_3:
        addi x12, x0, 100
        add x13, x0, x29

        jal x1, Mul
        add x18, x18, x10

    # DIGITO 2 * 10
    digito_2:
        addi x12, x0, 10
        add x13, x0, x30

        jal x1, Mul
        add x18, x18, x10

    # DIGITO 1 * 1
    digito_1:
        add x18, x18, x31

    # RESULTADOS de num1 e num2
    salva:
        beq x26, x0, salva_num1

    salva_num2:
        addi x13, x18, 0
        jal x1, mult # calcular num1 * num2

    salva_num1:
        addi x20, x18, 0 # salva o num1
        addi x26, x26, 1 # x26++
        jal x0, get_num

mult:
    add x12, x20, x0 # Salva num1 em x12
    jal x1, Mul
	jal x0, result_digits

fim:
	halt

# Função Mul
# Parametros: x12 = a e x13 = b
# Resultado em x10
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


result_digits:
    /* CRIAR LÓGICA P/ PEGAR CADA DÍGITO*/
    

# Função div
# Parametros: x14 = dividendo, x15 = divisor
# Resultados: x10 = quociente, x11 = resto
div:
    addi x27, x0, 0 # contador
    addi x28, x0, 32 # Limite do loop (32 bits)
    addi x14, x10, 0 # Inicializa o dividendo
    addi x10, x0, 0  # Inicializa quociente
    addi x11, x14, 0 # Inicializa resto com o dividendo

    div_Loop:
        sub x11, x11, x15 # resto -= divisor
        blt x11, x0, men_que # if resto < 0
		
		# resto >= 0
        slli x10, x10, 1
        addi x10, x10, 1
        jal x0, continue

        # resto < 0
        men_que:
            add x11, x11, x15
            slli x10, x10, 1

        continue:
            srli x15, x15, 1
			addi x27, x27, 1
            beq x27, x28, div_exit # if x27 == x28 then exit
            beq x11, x15, div_exit
            jal x0, div_Loop
                        
    div_exit:
        jalr x0, 0(x1) # retorna a função
