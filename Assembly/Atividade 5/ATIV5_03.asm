title exibir todas letras minusculas
.model small
.stack 100h
.code
    main proc
        mov ax,@data
        mov ds,ax
        mov dx,65
        maiusculo:
            mov ah,02h
            int 21h
            inc dx
            cmp dx,91
            JNE maiusculo
        prox:
            mov ah,02h
            mov dx,10
            int 21h
            mov dx,13
            int 21h
            mov dx,97
            minusculo:
                mov ah,02h
                int 21h
                inc dx
                cmp dx,123
                JNE minusculo
        fim:
            mov ah,4ch
            int 21h
    main ENDP
    end main

