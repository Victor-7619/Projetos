TITLE 03_2 ; Titulo do programa
.model SMALL ; Define o modelo de memoria
.stack 100h ; Reserva 256 bytes para a pilha

.DATA                                                                  ; seção de dados
    CARACTERE db 10,10,13, 'digite um caractere (ESC para sair): $'    ; mensagem para solicitar o caractere
    LETRA     db 10,10,13, 'caractere digitado e uma letra.$'          ; mensagem para caractere letra
    NUM       db 10,10,13, 'caractere digitado e um numero.$'          ; mensagem para caractere numero
    CARAC     db 10,10,13, 'caractere digitado e desconhecido.$'       ; mensagem para caractere desconhecido
    FINAL     db 10,10,13, 'Programa finalizado.$'                     ; mensagem de finalização
.CODE                            ; seção de código
main proc                        ; início do procedimento MAIN
             mov ax,@DATA        ; define o segmento de dados
             mov ds,ax           ; carrega o registrador DS com o valor do segmento de dados

    INICIO:                      ; rótulo INICIO
             mov ah,9            ; função para exibir uma string na tela
             lea dx,CARACTERE    ; carrega o endereço da string em DX
             int 21h             ; chama a interrupção 21h para exibir a string

             mov ah,1            ; função para ler um caractere do teclado
             int 21h             ; chama a interrupção 21h para ler o caractere
             mov bl,al           ; move o caractere lido (em AL) para o registrador BL

             cmp bl,27           ; compara o caractere em BL com o valor 27 (código ASCII do caractere "ESC")
             je  FIM             ; se for igual, salta para o rótulo FIM
             cmp bl,65           ; compara o caractere em BL com o valor 65 (código ASCII do caractere "A")
             jb  N_DIGITO        ; se for menor, salta para o rótulo N_DIGITO
             cmp bl,91           ; compara o caractere em BL com o valor 91 (código ASCII do caractere "Z")
             jb  DIGITO          ; se for menor, salta para o rótulo DIGITO
             cmp bl,97           ; compara o caractere em BL com o valor 97 (código ASCII do caractere "a")
             jb  N_DIGITO        ; se for menor, salta para o rótulo N_DIGITO
             cmp bl,123          ; compara o caractere em BL com o valor 123 (código ASCII do caractere "z")
             jb  DIGITO          ; se for menor, salta para o rótulo DIGITO

    N_DIGITO:                    ; rótulo N_DIGITO
             cmp bl,48           ; compara o caractere em BL com o valor 48 (código ASCII do caractere "0")
             jb  DESC            ; se for menor, salta para o rótulo DESC
             cmp bl,57           ; compara o caractere em BL com o valor 57 (código ASCII do caractere "9")
             ja  DESC            ; se for maior, salta para o rótulo DESC
             mov ah,9            ; função para exibir uma string na tela
             lea dx,num          ; carrega o endereço da string em DX
             int 21h             ; chama a interrupção 21h para exibir a string
             jmp INICIO          ; salta para o rótulo INICIO

    DIGITO:                      ; rótulo DIGITO
             mov ah,9            ; função para exibir uma string na tela
             lea dx,LETRA        ; carrega o endereço da string em DX
             int 21h             ; chama a interrupção 21h para exibir a string
             jmp INICIO          ; salta para o rótulo INICIO

    DESC:                        ; rótulo DESC
             mov ah,9            ; função para exibir uma string na tela
             lea dx,CARAC        ; carrega o endereço da string em DX
             int 21h             ; chama a interrupção 21h para exibir a string
             jmp INICIO          ; salta para o rótulo INICIO

    FIM:                         ; rótulo FIM
             mov ah,9            ; função para exibir uma string na tela
             lea dx,FINAL        ; carrega o endereço da string em DX
             int 21h             ; chama a interrupção 21h para exibir a string
             mov ah,4Ch          ; função para encerrar o programa
             int 21h             ; chama a interrupção 21h para encerrar o programa
main endp                        ; final do procedimento MAIN
end main ; final do programa, indicando o ponto de entrada
     