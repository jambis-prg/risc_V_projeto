# Usando o reg x5 para armazenar o digito
# Usando o reg x6 como contador do loop inicial
# Usando o reg x9 para armazenar o valor da soma
# Usando o reg x18 para o endereço base do array factorials

addi x9, x0, 0 # Zerando o resultado da soma
lw x18, factorials_ptr # Carregando endereço base do array
addi x6, x0, 5 # counter = 5

L0:
    lb x5, 1025(x0) # Lendo caracter

    beq x5, x0, L1 # if (x5 == '\0') break

    addi x5, x5, -48 # Convertendo char em int

    slli x5, x5, 2 # Obtendo o offset do array (x5 * 4)
    add x5, x5, x18 # x5 = address of factorials[i]
    lw x5, 0(x5) # x5 = factorials[i]

    add x9, x9, x5 # sum += factorials[i]
    
    addi x6, x6, -1 # counter--
    bne x6, x0, L0 # while (counter != 0)

L1:
    lw x19, result_str_ptr # array p/ os digitos
    addi x20, x0, 1 # if x10 == 0 then 1 digito 

    blt x9, x0, L3 # if (x9 <= 0) then go to L3
    beq x9, x0, L3

    addi x20, x0, 0 # counter

    # while temp > 0
    L2:
        addi x12, x9, 0 # Div_By_Ten(temp);
        jal x1, Div_By_Ten

        addi x9, x10, 0 # temp = Div_By_Ten(temp).first;
        addi x5, x11, 0 # digito = Div_By_Ten(temp).second;   
        addi x5, x5, 48 # digito += 48 convertendo de int para char

        add x6, x19, x20 # x6 = address of arr[i]
        sb x5, 0(x6) # arr[i] = (char)digito
        addi x20, x20, 1 # counter++

        blt x9, x0, L3
        bne x9, x0, L2
L3:
    addi x20, x20, -1
    L4:
        add x5, x19, x20 # x5 = address of arr[i]
        lb x5, 0(x5) # x5 = arr[i]
        sb x5, 1024(x0) # print(x5)

        addi x20, x20, -1 # counter--
        bge x20, x0, L4 # while(x20 >= 0)

halt

#Quociente - x10 Resto - x11
#Dividendo - x12
Div_By_Ten:
	addi x10, x0, 0
	addi x11, x0, 0

	addi x5, x0, 1
	slli x5, x5, 31
	addi x7, x0, 32 # i = 32
	addi x28, x0, 10 # Divisor = 10
	Div_L0:
		and x6, x12, x5
		slli x12, x12, 1
		slli x11, x11, 1
		slli x10, x10, 1

		beq x6, x0, Div_L1 # if (x6 != 0)
		addi x11, x11, 1

		Div_L1:
			blt x11, x28, Div_L2
			sub x11, x11, x28
			addi x10, x10, 1
		Div_L2:	
			addi x7, x7, -1 # i--
			bne x7, x0, Div_L0 # while (i != 0)
			
	jalr x0, 0(x1)

factorials_ptr: .word factorials
factorials: .word 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880

result_str_ptr: .word result_str
result_str: .byte 48
