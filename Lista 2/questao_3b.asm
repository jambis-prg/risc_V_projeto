# x26: contador para pegar os 2 números
# x27: limite do loop (1)
# x18: valor temporário para armazenar os números

addi x26, x0, 0  # Inicializa contador
addi x27, x0, 1  # Limite do loop

L0:
    lb x7, 1025(x0) # digito 1
    lb x28, 1025(x0) # digito 2
    lb x29, 1025(x0) # digito 3
    lb x30, 1025(x0) # digito 4
    lb x31, 1025(x0) # digito 5

    #Convertendo os digitos de caracter para numeros
    addi x7, x7, -48
    addi x28, x28, -48
    addi x29, x29, -48
    addi x30, x30, -48
    addi x31, x31, -48

    # DIGITO 5 * 10000:
    addi x12, x0, 1250
    slli x12, x12, 3 # Carregando 10000 no parametro a de Mul

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

    # DIGITO 1 * 1
    add x18, x18, x31

    bge x26, x27, L1 # if (i >= 1) break;

    addi x20, x18, 0 # Salva o num1 em x20
    addi x26, x26, 1 # i++;
    lb x7, 1025(x0) # Carrega caracter espaço para descarte

    beq x0, x0, L0 # while(true)

L1:
    addi x12, x20, 0 # Salva num1 em x12
    addi x13, x18, 0 # Salva num2 em x13
    jal x1, Mul # num1 * num2
 
    blt x10, x0, L3 # if (x10 <= 0) then go to L3
    beq x10, x0, L3

    lw x19, result_str_ptr # array p/ os digitos
    addi x20, x0, 0 # cont
    addi x21, x10, 0 # temp
    addi x5, x0, 0 # digitos

    # while temp > 0
    L2:
        addi x11, x21, 0 # Div_By_Ten(temp);
        jal x1, Div_By_Ten

        addi x21, x10, 0 # temp = Div_By_Ten(temp).first;
        addi x5, x11, 0 # digito = Div_By_Ten(temp).second;   
        addi x5, x5, 48 # digito += 48 convertendo de int para char

        add x6, x19, x20 # x6 = address of arr[i]
        sb x5, 0(x6) # arr[i] = (char)digito
        addi x20, x20, 1 # cont++

        blt x21, x0, L3
        bne x21, x0, L2

L3:
    addi x20, x20, -1
    L4:
        add x5, x19, x20 # x5 = address of arr[i]
        lb x5, 0(x5) # x5 = arr[i]
        sb x5, 1024(x0) # print(x5)

        addi x20, x20, -1 # cont--
        bge x20, x0, L4 # while(x20 >= 0)

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

    jalr x0, 0(x1) # Retorna a chamada da função

# x10 = quociente ( return result_first )
# x11 = resto = dividendo ( return result_second )
Div_By_Ten:
    addi x5, x0, 10 # divisor
    addi x10, x0, 0

    # while( resto >= divisor )
    blt x11, x5, Return_Div_By_Ten
    Div_Loop:
        sub x11, x11, x5 # resto -= 10;
        addi x10, x10, 1 # quociente++;
        bge x11, x5, Div_Loop
        
    Return_Div_By_Ten:
        jalr x0, 0(x1)

result_str_ptr: .word result_str
result_str: .byte 0
