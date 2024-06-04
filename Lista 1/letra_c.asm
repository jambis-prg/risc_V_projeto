.section .data # usada para declarar variáveis e inicializá-las com valores nesse caso foi com 0
va: .word 0
vb: .word 0
vc: .word 0
vx: .word 0

.section .text
.globl _start # Define o ponto de entrada do programa
_start: # indica o início do código executável.
    # Lê valores do teclado e armazena nas variáveis
    lb x9, 1025(x0) # Lê um valor do teclado e armazena em 'x9'
    sw x9, va # Armazena o valor lido em 'va'
    lb x9, 1025(x0) # Lê outro valor do teclado e armazena em 'x9'
    sw x9, vb # Armazena o valor lido em 'vb'
    lb x9, 1025(x0) # Lê mais um valor do teclado e armazena em 'x9'
    sw x9, vc # Armazena o valor lido em 'vc'

addi x20, x0, 0

lw x9, va
addi x5, x0, 5
blt x9, x5, Else

lw x9, vb
addi x5, x0, 65
blt x9, x5, Final_Comp
bne x9, x5, Else

Final_Comp:
	lw x9, vc
	addi x5, x0, 15
	blt x9, x5, Else
	beq x9, x5, Else

addi x20, x0, 1

Else: sw x20, vx
halt

va:.word 0x10
vb:.word 0x10
vc:.word 0x10
vx:.word 0x10

#Visualiza o valor da variável x no monitor
    lw x20, vx # Carrega o valor de 'vx' para o registrador x20
    sb x20, 1024(x0) # Escreve o valor do registrador x20 no vídeo

    halt # Encerra o programa

