    TITLE atividade 2 ; titulo do programa
    .MODEL SMALL ; modelo de memoria pequeno
    .DATA ; local de armazenamento de dados
    MSG1 DB 'digite um caracter em letra minuscula: $' ; string mensagem
    MSG2 DB 10,13,'o caracter digitado em maiusculo: $' ; string mensagem
    .CODE ; codigo do programa
    main proc ; inicio do programa
    
    mov ax,@data ; inicializar DS com endereço dos dados do .data   
    mov ds,ax ; guarda os endereços dos dados em ds

    MOV ah,9 ; função 09 para imprimir string
    LEA DX,MSG1 ; chama a string MSG1
    INT 21h ; executa a função 09(imprime a mensagem)

    mov ah,1 ; função 01 para ler caracter
    int 21h ; executa a função 01(ler caracter)

    sub al,20h ; adiciona 20 em hexa decimal em al para converter para maiúsculo
    mov bl,al ; armazena o caracter convertido em bl

    mov ah,9 ; função 09 para imprimir string
    lea dx,MSG2 ; chama a string MSG2
    int 21h ; executa a função 09(imprime a mensagem)

    mov ah,2 ; função 02 para imprimir caracter
    mov dl,bl ; coloca o caracter convertido em dl
    int 21h ; executa a função 02(imprime o caracter)

    mov ah,4ch ; função 4Ch para ah para terminar o programa
    int 21h ; executa a função 4Ch
    main endp ; fim do procedimento main
    end main ; fim do programa

