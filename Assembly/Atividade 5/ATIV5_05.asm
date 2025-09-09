title Somatoria de 5 numeros
.model small
.stack 100h
.data
    msg1 db 'Digite 5 numeros: $'
    msg2 db 10,13,'A soma dos numeros e: $'
.code
    main proc
        mov ax,@data
        mov ds,ax
        mov cx,5
        mov ah,09h
        lea dx,msg1
        int 21h
        mov bx,0
        mov cx,5
        Ler_num:
            mov ah,01h
            int 21h
            sub al,30h
            add bx,ax
            mov ah,02h
            mov dl,13
            int 21h
            mov dl,10
            int 21h
            loop Ler_num
        
        add bx,30h
        mov ah,09h
        lea dx,msg2
        int 21h
        mov dx,bx
        mov ah,02h
        int 21h
    main ENDP
end main
