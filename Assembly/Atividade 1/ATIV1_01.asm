TITLE Mensagens ; Título do programa

.MODEL SMALL ; divide o processador de 1 MB em 16 partes de 64k

.DATA ; armazena variáveis e constantes

MSG1 DB 'Mensagem 1.$' ; variável definida com o valor de "mensagem 1", parando ao chegar no valor de 1 $. O DB significa Double Word

MSG2 DB 10,13,'Mensagem 2.$' ; a função 10 funciona para pular a linha e a 13, para mover o cursor para o início da linha

.CODE ; todo o código do programa estára presente aqui

MAIN PROC ; inicia a função main

MOV AX,@DATA ; move as informações do data para o ax

MOV DS,AX ; move as informações de data movidas antes para ax, ao segmento DS (do .data)

MOV AH,9 ; função para imprimir string

LEA DX,MSG1 ; joga o endereço da string no registrador DX

INT 21h ; executa inúmeras funções

MOV AH,9 ; função para imprimir string

LEA DX,MSG2 ; joga o endereço da string no registrador DX

INT 21h ; executa inúmeras funções

MOV AH,4Ch ; chama a função 4ch para finalizar o programa e joga em ah

INT 21h ; executa a função chamada acima

MAIN ENDP ; finaliza o main

END MAIN ; finaliza o programa