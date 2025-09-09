title exibir todas letras minusculas
.model small
.stack 100h
.code
    main proc
        mov ax,@data
        mov ds,ax
        mov dl,'a'
        inicio:
            mov cx,4 
            prox_letra:
                cmp dl,'z'
                ja fim
                mov ah, 02h
                int 21h
                inc dl
                loop prox_letra
            push dx
            mov dl,10
            int 21h
            mov dl,13
            int 21h
            pop dx
            jmp inicio    
            fim:
                mov ah,4ch
                int 21h
    main ENDP
    end main

