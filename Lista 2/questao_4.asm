.data
factorials: .word 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880 # definicao dos valores dos  fatorias de 0 a 9 

.text
.globl main
main:
    # supondo que o número de entrada esteja no registrador a0
    li t0, 0 # t0 será usado para armazenar a soma dos fatoriais

loop:
    # obter o último dígito do número apartir da func remu
    remu t1, a0, 10

    # calcular o endereço do fatorial na tabela
    slli t2, t1, 2
    add t2, t2, factorials

    # adicionar o fatorial à soma
    lw t3, 0(t2)
    add t0, t0, t3

    # remover o último dígito do número
    divu a0, a0, 10

    # continuar se ainda houver dígitos
    bnez a0, loop

    # a soma dos fatoriais está agora em t0



