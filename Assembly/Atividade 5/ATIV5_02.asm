title Exibir caracter * 50 vezes com loop
.model small
.stack 100h
.data
    msg1 db '* $'
    msg2 db 10,13,"*$"
.code
    main proc
        mov dx,@data
        mov ds,dx
        mov cx,5
        inicio:
            mov ah,09h
            lea dx,msg1
            int 21h
            LOOP inicio
        mov cx,5
        inicio2:
            mov ah,09h
            lea dx,msg2
            int 21h
            LOOP inicio2
        mov ah,4ch
        int 21h
        main ENDP
        end main

