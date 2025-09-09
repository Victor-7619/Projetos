TITLE Numero ; titulo do programa

.MODEL SMALL ; define o modelo de memoria

.STACK 100h ; reserva 256 bytes para a pilha

.DATA ; seção de dados
MSG1 DB 'Digite um caractere: $' ; mensagem para solicitar o caractere
SIM DB 10,13,'O caractere digitado e um numero.$' ; mensagem para caractere numero
NAO DB 10,13,'O caractere digitado nao e um numero.$' ; mensagem para caractere nao numero

.CODE ; seção de código
    MAIN PROC ; início do procedimento MAIN
        MOV AX,@DATA ; define o segmento de dados
        MOV DS,AX ; carrega o registrador DS com o valor do segmento de dados

        MOV AH,9 ; função para exibir uma string na tela
        lea DX,MSG1 ; carrega o endereço da string em DX
        INT 21h ; chama a interrupção 21h para exibir a string
        
        MOV AH,1 ; função para ler um caractere do teclado
        INT 21h ; chama a interrupção 21h para ler o caractere
        
        MOV BL,AL ; move o caractere lido (em AL) para o registrador BL

        CMP BL,48 ; Compara o caractere em BL com o valor 48 (código ASCII do caractere “0”)
        JB NAOENUMERO ; Se o caractere em BL for menor que 48 (“0”), salta para o rótulo NAOENUMERO
        
        CMP BL,57 ; compara o caractere em BL com o valor 57 (código ASCII do caractere “9”)
        JA NAOENUMERO ; se o caractere em BL for maior que 57 (“9”), salta para o rótulo NAOENUMERO

        MOV AH,9 ; função para exibir uma string na tela
        lea DX,SIM ; carrega o endereço da string em DX
        INT 21h ; chama a interrupção 21h para exibir a string
        JMP FIM ; salta para o rótulo FIM

        NAOENUMERO: ; rótulo NAOENUMERO
        MOV AH,9 ; função para exibir uma string na tela
        lea dx,NAO ; carrega o endereço da string em DX
        INT 21h ; chama a interrupção 21h para exibir a string
       
        FIM:
        MOV AH,4Ch ; função para encerrar o programa
        INT 21h ; chama a interrupção 21h para encerrar o programa
    MAIN ENDP ; final do procedimento MAIN
END main ; final do programa, indicando o ponto de entrada
