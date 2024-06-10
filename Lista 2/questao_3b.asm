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
	addi x19, x19, -1 # correção
	
	print:
		addi x20, x0, -1 # condição de parada
		beq x19, x20, exit # if cont == -1 exit
	
		slli x6, x19, 3 # x6 = cont * 8
    		add x18, x5, x6 # address of arr[i]
    
		lw x10, 0(x18) # x10 = arr[i]
		sb x10, 1024(x0) # printa
    
		addi x19, x19, -1 # cont++
		jal x0, print

exit:
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
    addi x5, x0, 0 # array p/ os digitos
    addi x19, x0, 0 # cont
    addi x15, x10, 0 # temp
    addi x7, x0, 0 # digitos

    # while temp > 0
    loop:
        bge x15, x0, dif # if temp >= 0
        dif:
            beq x15, x0, fim # if temp == 0 sai

        jal x1, div
        addi x7, x11, 0 # digito = temp % 10    
        addi x7, x7, 48 # ascii

        slli x6, x19, 3 # x6 = cont * 8
        add x18, x5, x6 # address of arr[i]
        sw x7, 0(x18) # arr[i] = x7
        addi x19, x19, 1 # cont++

        jal x0, loop

div:
    addi x14, x0, 10 # divisor
    addi x10, x0, 0 # quociente = 0
    addi x11, x15, 0 # resto = dividendo

    div_loop:
        blt x11, x14, div_exit
        sub x11, x11, x14
        addi x10, x10, 1
        jal x0, div_loop
        
        div_exit:
            addi x15, x10, 0 # temp = temp / 10
            jalr x0, 0(x1)
