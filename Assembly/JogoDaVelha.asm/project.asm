title Projeto - jogo da velha
.model small
.stack 100h



; ----------------------------------------------------------
;                       Macros                               
; ---------------------------------------------------------- 

Push_all macro                ; Macro para push em todos os registradores
                push ax
                push BX
                push cx
                push Dx
                push si
endm

pop_all macro               ; Macro para pop em todos os registradores
               pop si
               pop dx
               pop cx
               pop bx
               pop ax
endm

move_XY macro x,y                  ;Macro para pocionar o cursor na posicao desejada
               push_all

               mov      ah,2
               mov      dh,x
               mov      dl,y
               int      10h

               pop_all
endm

imprime macro MSG
               push ax
               push dx

               mov  ah,9
               lea  dx,MSG
               int  21h
               
               pop  ax
               pop  dx
endm


print_carac macro carac                 ; Macro para imprimir um unico caractere
                   push ax
                   push dx

                   mov  ah, 2
                   mov  dl, carac
                   int  21h
                   
                   pop  dx
                   pop  ax
endm

pular macro                       ; Macro para pular linha
             Push_all
             mov      ah,2
             mov      dx,10
             int      21h

             mov      dx,13
             int      21h
             pop_all
endm

limpatela macro
                 push_all            ; Macro para limpar tela

                 MOV      AH,0
                 MOV      AL,3
                 INT      10H

                 pop_all
endm

cls macro
            push      ax              ;macro para pausar "cls" no C

            pular
            imprime   continuar

            mov       ah,1
            int       21h

            limpatela
            pop       ax
endm

Coordenadas macro L1, C1, Linha, Coluna              ;Macro para armazenar os valores de linha e coluna
                   Local    comeco

                   Push_all

       comeco:     

                   imprime  Linha

                   xor      bx,bx

                   mov      ah,1
                   int      21h

                   sub      al,30h

                   dec      al

                   mov      bl,3

                   mul      bl

                   mov      L1, al
       
                   imprime  Coluna

                   mov      ah,1
                   int      21h

                   sub      al,30h

                   dec      al

                   mov      C1, al
       
                   pop_all
endm
.data
       ; -----------------------------------
       ;                 Regras
       ; -----------------------------------
       msg1          db 9,9,'Jogo da Velha - Projeto de Assembly.$'
       
       regra         db 10,10,13,' Regras do Jogo:'
                     db 10,10,13,' 1 - O jogo e para dois jogadores.'
                     db 13,10,' 2 - Cada jogador escolhe um simbolo (X ou O).'
                     db 13,10,' 3 - Os jogadores se alternam para fazer suas jogadas.'
                     db 13,10,' 4 - As jogadas serao feitas atraves de coordenadas (linha e coluna).'
                     db 13,10,' 5 - O objetivo eh alinhar tres simbolos na horizontal, vertical ou diagonal.'
                     db 10,13,' 6 - O jogo termina quando um jogador vence ou quando todas as posicoes forem ',10,' preenchidas.'
                     db 10,10,13,' Divirta-se!$'
       
       continuar     db 10,10,10,10,10,10,10,13,9,9,' Pressione qualquer tecla para continuar...$'

       
       ; ---------------------------------
       ;               ESCOLHA DE JOGO
       ; ---------------------------------
       escolha       db 'Escolha: '
                     db 10,10,13, ' 1 - Solo        (Um jogador)'
                     db 10,13, ' 2 - Multiplayer (Dois jogadores)'
                     db 10,10,13, ' $'
       invalido      db 10,10,13,9,'Escolha invalida!! digite novamente.$'
       ; ---------------------------------
       ;ESCOLHA DE SIMBOLOS
       ; ---------------------------------
       
       msg2          db 'Jogador 1, escolha com qual ira jogar:'
                     db 10,10,13,' 1 - X'
                     db 10,13,' 2 - O'
                     db 10,10,13, ' $'
       ; ------------------------------
       ;              Tabuleiro
       ; ------------------------------
       Matriz1       db '?', '?', '?'
                     db '?', '?', '?'
                     db '?', '?', '?'

       ;Matriz1   db 3 dup (3 dup ('?'))

       linha1        db 9,'   ', 179, '   ', 179, '   ', 10, 13, '$'
       linha2        db 9,196, 196, 196, 197, 196, 196, 196, 197, 196, 196, 196, 10, 13, '$'
       linha3        db 9,'   ', 179, '   ', 179, '   ', 10, 13, '$'
       linha4        db 9,196, 196, 196, 197, 196, 196, 196, 197, 196, 196, 196, 10, 13, '$'
       linha5        db 9,'   ', 179, '   ', 179, '   ', 10, 13, '$'

       ;Vez do jogador
       J1            db '?$'
       J2            db '?$'

       
       msg3um        db 10,10,13,'Jogador 1 ($'
       msg3dois      db 10,10,13,'Jogador 2 ($'
       msg3_1        db '), de a jogada: $'

       Linha         db 10,10,13,'Linha (1-3): $'
       Coluna        db 10,13,'Coluna (1-3): $'

       L1            db ?
       C1            db ?

       msg_erro      db 10,10,13,'Jogada invalida! Tente novamente.$'
       velha         db 10,10,13, 'Jogo deu velha!!$'

       msg_ganhouJ1  db 10,10,13,'Parabens Jogador 1, voce ganhou!!$'
       msg_ganhouJ2  db 10,10,13,'Parabens Jogador 2, voce ganhou!!$'
       
       jogar_de_novo db 10,10,13,'Deseja jogar de novo?'
                     db 10,13, '1 - Sim'
                     db 10,13, '2 - Nao'
                     db 10,10,13,  'Resposta: $'
       
       ; -------------------------------------------
       ;          Variaveis de verificacao
       ; -------------------------------------------

       var1          db 0

       vetor         db 3 dup (?)

.code
main proc
       ;chama os procedimentos
                          mov         ax,@data
                          mov         ds,ax

       Start:             

                          limpaTela
                          call        inicio
                          call        escolher_game

       faca_sua_escolha:  

                          imprime     jogar_de_novo

                          mov         ah,1
                          int         21h

                          cmp         al,'1'
                          je          Start

                          cmp         al,'2'
                          je          Endi 
                          
                          imprime     invalido

                          cls
                          
                          jmp         faca_sua_escolha

                          ; inicializar a matriz, vetor e registradores ao jogar novamente.

       Endi:               
                          mov         ah,4ch
                          int         21h
main endp

inicio proc
       ;inicializa o jogo, mostrando as regras
                          pular
                         
                          imprime     msg1

                          pular

                          imprime     regra

                          cls

                          ret
inicio endp

escolher_game proc
       ;o jogador escolhe o numero de jogadores e
       ;escolhe o simbolo do jogador
                          limpatela
       leitura:           
                          move_XY     1,9
                          imprime     escolha

                          mov         ah,1
                          int         21h

                          cmp         al,'1'
                          je          um_jogador
                          cmp         al,'2'
                          je          dois_jogadores

                          limpatela
                          
                          imprime     invalido

                          cls

                          jmp         leitura                     ; deixar mais bonito depois
              
       
       um_jogador:        
                          call        jogoUm
                          jmp         sai

       dois_jogadores:    
                          call        jogoDois
                          jmp         sai
       
       sai:               
                          ret
escolher_game endp

jogoUm proc near
       ; implementar o jogo para um jogador
       ;um_jogador:                                   fazer depois
       ;               pular
              
       ;               imprime msg2
       ;
       ;               mov      ah,1
       ;               int      21h
jogoUm endp

jogoDois proc near
       ; implementar o jogo para dois jogadores
       
       inicioDois:        
                          mov         ch,9
                          mov         di,0

                          limpaTela
                          
                          move_XY     1,9
         
                          imprime     msg2
       
                          mov         ah,1
                          int         21h
       
                          cmp         al,'1'
                          je          RetornarX
       
                          cmp         al,'2'
                          je          RetornarO

                          limpaTela

                          imprime     invalido
                          
                          cls
                          
                          jmp         inicioDois                  ; deixar mais bonito depois
                      
       RetornarX:         
                          mov         J1, 'X'
                          mov         J2, 'O'

                          jmp         comecar
       RetornarO:         
                          mov         J1, 'O'
                          mov         J2, 'X'

       comecar:           
                          limpaTela

                          call        desenharTabuleiro

                          call        write
                         
                          call        verifica_ganhador

                          cmp         var1,0
                          jne         puloUm

                          call        vez

                          mov         bl, L1
                          mov         al, C1

                          cmp         al,0
                          jl          erro

                          cmp         al,2
                          jg          erro

                          cmp         bl,0
                          jl          erro

                          cmp         bl,6
                          jg          erro

                          jmp         cnt

       puloUm:            
                          jmp         fim6

       cnt:               
                          xor         ah,ah
                          mov         si,ax

                          mov         al,Matriz1 [bx][si]

                          cmp         al, '?'
                          jne         erro

                          call        comparacao

                          dec         ch
                         
                          cmp         ch,0
                          jnz         comecar

                          jmp         eh_velha
                         
       erro:              
                          imprime     msg_erro

                          cls

                          jmp         comecar
       eh_velha:          
                          
                          limpaTela

                          call        desenharTabuleiro

                          call        write

                          imprime     velha
       fim6:              
                          
                          cls

                          limpaTela

                          ret
jogoDois endp

desenharTabuleiro proc near
       ;Desenha o tabuleiro vazio na tela.
                          push        ax
                          push        dx
                         
                          move_XY     0,0

                          pular
                          pular
                         
                          imprime     linha1

                          imprime     linha2

                          imprime     linha3

                          imprime     linha4

                          imprime     linha5

    
                          pop         dx
                          pop         ax
                          ret
desenharTabuleiro endp

write proc
                          push_all
                            
                          xor         bx,bx
                          mov         cl,3
                          mov         dh,2
       linha_2:           
                          xor         si,si
                          mov         dl,9

       coluna_2:          
                          mov         al,Matriz1[bx][si]

                          cmp         al,'?'
                          je          prox
       
                          move_XY     dh,dl

                          cmp         al,'X'
                          je          impX

                          print_carac 'O'
                          jmp         prox
       
       impX:              
                          print_carac 'X'

       prox:              
                          add         dl,4
                         
                          inc         si
                         
                          cmp         dl,17
                          jle         coluna_2
            
                          add         bx,3
                          add         dh,2
                         
                          dec         cl

                          move_XY     6,9
                         
                          cmp         cl,0
                          jnz         linha_2

                          pop_all

                          ret

write endp

verifica_ganhador proc
                          Push_all

                          xor         bx,bx
                          mov         cx,3
                          xor         si,si
              
       verifica_linha:    


                          mov         al, Matriz1[bx][si]
                          mov         vetor[si],al
              
                          inc         si
                         
                          cmp         si,3
                          jl          verifica_linha

                          xor         si,si

                          mov         al, vetor[si]

                          inc         si
                         
                          cmp         vetor[si],al
                          jne         prox2

                          inc         si

                          cmp         al,vetor[si]
                          jne         prox2

                          cmp         al,'?'
                          je          prox2

                          call        ganhador
                          mov         var1,1
                         
                          jmp         fim4

       prox2:             

                          xor         si,si
                          add         bx,3
                          loop        verifica_linha
              
                          xor         bx,bx
                          mov         cx,3
                          xor         si,si
                          xor         di,di
              
       verifica_coluna:   

                          mov         al, Matriz1[bx][si]
                          mov         vetor[di],al
              
                          add         bx,3
                          inc         di
                         
                          cmp         bx,9
                          jle         verifica_coluna

                          xor         di,di

                          mov         al, vetor[di]

                          inc         di
                         
                          cmp         vetor[di],al
                          jne         prox3

                          inc         di

                          cmp         al,vetor[di]
                          jne         prox3

                          cmp         al,'?'
                          je          prox3

                          call        ganhador
                          mov         var1,1
                         
                          jmp         fim4

       prox3:             

                          xor         bx,bx
                          inc         si
                          xor         di,di
                          loop        verifica_coluna

                          xor         bx,bx
                          mov         cx,3
                          xor         si,si
                          xor         di,di

       verifica_diagonalP:
                          mov         al, Matriz1[bx][si]
                          mov         vetor[si],al
              
                          add         bx,3
                          inc         si
                         
                          cmp         si,3
                          jl          verifica_diagonalP

                          xor         si,si

                          mov         al, vetor[si]

                          inc         si
                         
                          cmp         vetor[si],al
                          jne         prox4

                          inc         si

                          cmp         al,vetor[si]
                          jne         prox4

                          cmp         al,'?'
                          je          prox4
                          call        ganhador
                          mov         var1,1
                         
                          jmp         fim4

       
       prox4:             
                          mov         bx,6
                          xor         si,si
       verifica_diagonalS:
       
                          mov         al, Matriz1[bx][si]
                          mov         vetor[si],al
                          
                          sub         bx,3
                          inc         si
                         
                          cmp         si,3
                          jl          verifica_diagonalS

                          xor         si,si

                          mov         al, vetor[si]

                          inc         si
                         
                          cmp         vetor[si],al
                          jne         fim4

                          inc         si

                          cmp         al,vetor[si]
                          jne         fim4

                          cmp         al,'?'
                          je          fim4

                          call        ganhador
                          mov         var1,1

       fim4:              
                          pop_all
                          ret

verifica_ganhador endp

ganhador proc

                          cmp         al,J1
                          jne         impj2

                          imprime     msg_ganhouJ1
                          jmp         fim5

       impj2:             
                          imprime     msg_ganhouJ2
       fim5:              
                          ret

ganhador endp

vez proc
                          Push_all

                          test        ch,1
                          jz          jogador2
       
       jogador1:          
                          imprime     msg3um

                          imprime     J1

                          imprime     msg3_1

                          Coordenadas L1, C1, Linha, Coluna

                          jmp         fim

       jogador2:          
                          imprime     msg3dois
                         
                          imprime     J2

                          imprime     msg3_1

                          Coordenadas L1, C1, Linha, Coluna

       fim:               
                          pop_all
                          ret
vez endp

comparacao proc
                          push_all

                          test        ch,1
                          jz          jogador_2

                          mov         al,J1
                          mov         Matriz1 [bx][si], al
                          jmp         fim2

       jogador_2:         
                          mov         al, J2
                          mov         Matriz1 [bx][si], al
       fim2:              
                          pop_all
                          ret
comparacao endp


end main