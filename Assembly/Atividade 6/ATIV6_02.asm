title Exercicio 2
.model small
.stack 100
.data
    msg1 db 'digite um caracter. Enter para sair.$'
    msg2 db 'fim$'
    msg3 db '*$'
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah,9
    lea dx, msg1
    int 21h

    xor cx,cx 
scan:
    mov ah, 1
    int 21h
    mov bl,al
    inc cl
    cmp bl, 13
    je printar_tela
    jmp scan

printar_tela:
    cmp cl, 0
    je fim
    mov ah,9
    lea dx, msg3
    int 21h

    dec cl
    jnz printar_tela

fim:
    mov ah, 2
    mov dl,10
    int 21h
    mov ah, 2
    mov dl,13
    int 21h
    mov ah,9
    lea dx, msg2
    int 21h
    mov ah, 4ch
    int 21h
main endp
end main

; No segundo programa, ao pressionar "Enter" (ASCII 13), ele quebra
; a linha antes de mostrar "fim". Assim, funciona como um
; Do While: mesmo sem digitar nada, roda pelo menos uma vez.