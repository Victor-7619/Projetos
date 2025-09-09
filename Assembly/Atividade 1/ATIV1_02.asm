TITLE Eco ; título do programa

.MODEL SMALL ; divide o processador em 16 partes de 64k cada

.CODE ; parte que localiza todo o código do progama

MAIN PROC ; inicia o main com a função proc

MOV AH,2 ; chama a função 2 do 21h para o usuário digiar um caracter

MOV DL,'?' ; move o codigo em ASCII do interrogação para o dl

INT 21h ; executa a função do 21h que está em ah

MOV AH,1 ; chama a função 1 (espera o usuário digitar um caracter)

INT 21h ; executa a função 21h que está em ah

MOV BL,AL ; movimenta a informação de al para bl

MOV AH,2 ;chama a função 2 (imprimir um caracter na tela)

MOV DL,10 ; guarda o codigo ASCII 10h (pular linha) em dl

INT 21h ; executa o que está em ah 

MOV AH,2 ; chama a função (imprimir um caracter) no ah

MOV DL,13 ; guarda o codigo ASCII 13h (voltar para o inicio da linha) em dl

INT 21h ; executa o que está em ah

MOV AH,2 ; chama a função 2 (imprimir um caracter na tela)

MOV DL,BL ; move o que está em bl para dl

INT 21h ; executa o que está em ah

MOV AH,4Ch ; chama a função 4Ch em ah par iniciar o processo de finalização

INT 21h ; executa o que está em ah

MAIN ENDP ; finaliza o procedimento main com a função ENDP

END MAIN ; finaliza o programa