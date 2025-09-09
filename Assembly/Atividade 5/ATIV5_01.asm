title Exibir caracter * 50 vezes
.model small
.stack 100h
.data
    msg1 db '* $'
    msg2 db 10,13,"*$"
.code
    main proc
        mov dx,@data
        mov ds,dx
        mov cx,50
        inicio:
            mov ah,09h
            lea dx,msg1
            int 21h
            DEC cx
            CMP cx,0
            JNE inicio
        mov cx,50
        inicio2:
            mov ah,09h
            lea dx,msg2
            int 21h
            DEC cx
            CMP cx,0
            JNE inicio2
        mov ah,4ch
        int 21h
        main ENDP
        end main

