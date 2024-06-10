get_num:
    lw x12, 0(x20) # num1
    lw x13, 0(x21) # num2
    jal x1, Mul # multiplicação

fim:
    halt

# Função Mul
# Parametros: x12 = a e x13 = b
# Resultado em x10
Mul:
    addi x10, x0, 0
    addi x5, x0, 1

    Mul_Loop:
        and x6, x13, x5 # Verifica se o bit atual d o multiplicador é 1
        beq x6, x0, Skip  # Se o bit atual é 0, pula a adição
        add x10, x10, x12 # Adiciona o multiplicando deslocado ao produto

    Skip:
        slli x12, x12, 1  # Desloca o multiplicando uma posição à esquerda
        srli x13, x13, 1  # Desloca o multiplicador uma posição à direita
        bne x13, x0, Mul_Loop # Continua até que todos os bits do multiplicador tenham sido processados

    Exit_Loop:
        jalr x0, 0(x1) # Retorna a chamada da função
