TITLE exibir caracter

.model SMALL ; dividir o processador em 16 partes de 64k cada

.data ; armazena variáveis e constantes
MSG1 DB 'DIGITE UM CARACTER: $' ; mensagem para o usuário
MSG2 DB 10,13,'O CARACTER DIGITADO FOI: $' ; mensagem para exibir o caracter digitado

.CODE ; parte que localiza todo o código do programa
main proc ; inicia o main com a função proc

mov ax,@DATA ; move as informações do data para o ax
mov ds,ax ; move as informações de data movidas antes para ax, ao segmento DS (do .data)

mov ah,9 ; função para imprimir string
lea dx,MSG1 ; joga o endereço da string no registrador DX
int 21h ; executa a função de imprimir string

mov AH,1 ; chama a função 1 (espera o usuário digitar um caracter)
int 21h ; executa a função 21h que está em ah

mov bl,al ; guardar caracter em bl

mov ah,2 ; chama a função 2 do 21h para o usuário digitar um caracter
mov dl,10 ; guarda o código ASCII 10h (pular linha) em dl
int 21h ; executa a função do 21h que está em ah
mov ah,2 ; chama a função 2 (imprimir um caracter na tela)
mov dl,13 ; guarda o código ASCII 13h (voltar para o início da linha) em dl
int 21h ; executa a função do 21h que está em ah

MOV ah,9 ; função para imprimir string
lea dx,MSG2 ; joga o endereço da string no registrador DX
int 21h ; executa a função de imprimir string

mov ah,2 ; chama a função 2 (imprimir um caracter na tela)
mov dl,bl ; move o caracter digitado de bl para dl
int 21h ; executa a função do 21h que está em ah

mov ah,4Ch ; chama a função 4Ch em ah para iniciar o processo de finalização
int 21h ; executa a função chamada acima
main ENDP ; finaliza o procedimento main com a função ENDP
end main ; finaliza o programa

