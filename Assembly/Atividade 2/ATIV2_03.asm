Title exercício 3
model small
.data
MSG1 db 'Digite o primeiro num(0 a 9): $'
MSG2 db 10,13, 'digite o segundo num(0 a 9): $'
MSG3 db 10,13, 'A soma dos numeros eh: $'
.code
main proc
mov ax,@data ; inicializar DS com endereço dos dados do .data
mov ds,ax ; guarda os endereços dos dados em ds

mov ah,9 ; função 09 para imprimir string
lea dx,MSG1 ; chama a string MSG1
int 21h ; executa a função 09(imprime a mensagem)

mov ah,1 ; função 01 para ler caracter
int 21h ; executa a função 01(ler caracter)

mov bl,al ; armazena o caracter lido em bh

mov ah,9 ; função 09 para imprimir string
lea dx,MSG2 ; chama a string MSG2
int 21h ; executa a função 09(imprime a mensagem)

mov ah,1 ; função 01 para ler caracter
int 21h ; executa a função 01(ler caracter)

mov cl,al ; armazena o caracter lido em cl

add bl,cl ; soma os valores em bl e cl
sub bl,30h ; converte o resultado para o valor real

mov ah,9 ; função 09 para imprimir string
lea dx,MSG3 ; chama a string MSG3
int 21h ; executa a função 09(imprime a mensagem)

mov ah,2 ; função 02 para imprimir caracter
mov dl,bl ; coloca o caracter convertido em dl para imprími-lo
int 21h ; executa a função 02(imprime o caracter)

mov ah,4ch ; função 4Ch para terminar o programa
int 21h ; executa a função 4Ch
main endp ; fim do procedimento main
end main ; fim do programa