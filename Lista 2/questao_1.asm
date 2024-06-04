#x9 player_1 score - x18 player_2 score

jal x1, Get_String_And_Score
add x9, x10, x0 #player_1 = GetScore()

jal x1, Get_String_And_Score
add x18, x10, x0 #player_2 = GetScore()

addi x5, x0, 48
beq x9, x18, Show_Monitor
 
addi x5, x0, 49
bge x9, x18, Show_Monitor

addi x5, x0, 50

Show_Monitor:
sb x5, 1024(x0)

halt

#x5 temp char keyboard
#x6 temp char to compare
#x10 return score
Get_String_And_Score:
	addi x10, x0, 0 #zerando o retorno da função

	Get_Char_Loop: 
	lb x5, 1025(x0) #lendo caracter do teclado

	#letra A
	addi x6, x0, 65
	beq x5, x6, C1_Res
	
	#letra E
	addi x6, x0, 69
	beq x5, x6, C1_Res

	#letra I
	addi x6, x0, 73
	beq x5, x6, C1_Res

	#letra O
	addi x6, x0, 79
	beq x5, x6, C1_Res

	#letra U
	addi x6, x0, 85
	bne x5, x6, C2

	#Soma-se à pontuação do player +3
	C1_Res:
	addi x10, x10, 3
	beq x0, x0, C_Exit
	
	#condiçao 2
	C2:
	addi x6, x0, 68 #letra D
	beq x5, x6, C2_Res
	
	#letra G
	addi x6, x0, 71
	beq x5, x6, C2_Res

	#letra T
	addi x6, x0, 84
	bne x5, x6, C3

	#Soma-se à pontuação do player +1
	C2_Res:
	addi x10, x10, 1
	beq x0, x0, C_Exit
	
	C3:
	addi x6, x0, 66 #letra B
	beq x5, x6, C3_Res
	
	#letra C
	addi x6, x0, 67
	beq x5, x6, C3_Res

	#letra M
	addi x6, x0, 77
	beq x5, x6, C3_Res
	
	#letra N
	addi x6, x0, 78
	beq x5, x6, C3_Res
	
	#letra P
	addi x6, x0, 80
	bne x5, x6, C4
	
	#Soma-se à pontuação do player +4
	C3_Res:	
	addi x10, x10, 4
	beq x0, x0, C_Exit

	C4:
	addi x6, x0, 70 #letra F
	beq x5, x6, C4_Res
	
	#letra H
	addi x6, x0, 72
	beq x5, x6, C4_Res	
	
	#letra V
	addi x6, x0, 86
	beq x5, x6, C4_Res
	
	#letra W
	addi x6, x0, 87
	beq x5, x6, C4_Res	
	
	#letra Y
	addi x6, x0, 89
	bne x5, x6, C5
	
	#Soma-se à pontuação do player +2
	C4_Res:	
	addi x10, x10, 2
	beq x0, x0, C_Exit

	C5:
	addi x6, x0, 75 #letra K
	beq x5, x6, C5_Res
	
	#letra R
	addi x6, x0, 82
	beq x5, x6, C5_Res
	
	#letra S
	addi x6, x0, 83
	bne x5, x6, C6

	#Soma-se à pontuação do player +5
	C5_Res:
	addi x10, x10, 5
	beq x0, x0, C_Exit

	C6:
	addi x6, x0, 74 #letra J
	beq x5, x6, C6_Res
	
	#letra L
	addi x6, x0, 76
	beq x5, x6, C6_Res
	
	#letra K
	addi x6, x0, 75
	bne x5, x6, C7

	#Soma-se à pontuação do player +8
	C6_Res:
	addi x10, x10, 8
	beq x0, x0, C_Exit

	C7:
	addi x6, x0, 81 #letra Q
	beq x5, x6, C7_Res
	
	#letra Z
	addi x6, x0, 90
	bne x5, x6, C_Exit

	#Soma-se à pontuação do player +6
	C7_Res:
	addi x10, x10, 6

	#While c != ' ' and c != '\0'
	C_Exit:
	addi x6, x0, 32 #caracter de espaço
	beq x5, x6, Exit_Loop #c == ' '
	addi x6, x0, 0	#caracter nulo
	bne x5, x6, Get_Char_Loop

	Exit_Loop:
	jalr x0, 0(x1) #return

