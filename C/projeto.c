#include<stdio.h>
#include<stdlib.h>
#include<locale.h>
#include <time.h>

int main()
{
    int sair=1;

    while(sair==1)
    {
        srand(time(NULL));

        int correto1=-1,correto2=-1,correto3=-1,correto4=-1;
        int num1,num2,num3,num4,i,palpite=0,w=0,x=0,y=0,z=0;
        int cmd,numsecreto1,numsecreto2,numsecreto3,numsecreto4,numsecreto;
        int carta1,carta2,carta3,opcao=0,digito;

        carta1=(rand()%4)+1;
        do
        {
            carta2 = (rand()%4)+1;
        } while(carta2==carta1);

        do
        {
            carta3=(rand()%4)+1;
        } while (carta3==carta1||carta3==carta2);


        numsecreto=(rand()%9000)+1000;
        cmd=numsecreto;

        numsecreto4=numsecreto%10;
        numsecreto/=10;
        numsecreto3=numsecreto%10;
        numsecreto/=10;
        numsecreto2=numsecreto%10;
        numsecreto/=10;
        numsecreto1=numsecreto%10;

        setlocale(LC_ALL,"portuguese");

        system("cls");
        printf("\n\t\t\t\t     ***************************************");
        printf("\n\t\t\t\t      ==>Seja bem vindo ao jogo SECRETO!<==");
        printf("\n\t\t\t\t     ***************************************");
        printf("\n\n\t   O jogo consiste em adivinhar um código secreto de 4 dígitos (1000 a 9999) em 10 tentativas. \n\t Se o jogador completar 5 falhas totais, terá um bônus de uma dica secreta para o auxiliá-lo!!!\n");
        printf("\t\n\n\t\t\t\t!!");
        system("pause");
        system("cls");

        for(i=1;i<11;i++)
        {
            do
            {
                system("cls");
                printf("\n   Digite sua tentativa de código: ");
                scanf("%d",&palpite);

                if(palpite<1000||palpite>9999)
                {
                    printf("\n   Código inválido!!\n\n   ");
                    system("pause");
                }
            }
            while(palpite<1000||palpite>9999);
            {
                num4=palpite%10;
                palpite/=10;
                num3=palpite%10;
                palpite/=10;
                num2=palpite%10;
                palpite/=10;
                num1=palpite%10;

                if(num1==numsecreto1)
                {
                    w=1;
                    correto1=num1;
                }
                else
                {
                    w=0;
                }
                if(num2==numsecreto2)
                {
                    x=1;
                    correto2=num2;
                }
                else
                {
                    x=0;
                }
                if(num3==numsecreto3)
                {
                    y=1;
                    correto3=num3;
                }
                else
                {
                    y=0;
                }
                if(num4==numsecreto4)
                {
                    z=1;
                    correto4=num4;
                }
                else
                {
                    z=0;
                }
                if((correto1==numsecreto1)&&(correto2==numsecreto2)&&(correto3==numsecreto3)&&(correto4==numsecreto4))
                {
                    system("cls");
                    printf("\n\t P A R A B É N S ! ! !\n\n\n");
                    printf("\tvocê acertou o código: %d\n\tem %d tentativa(s).......\n\n\t",cmd,i);
                    system("pause");
                    system("cls");
                    break;
                }
                if(w+x+y+z==0)
                {
                    printf("\n   Você não acertou nenhum digito dessa vez...\n\n");
                    printf("   Faltam %d tentativas....\n\n   ",10-i);
                    printf("   Seu código é: ",10-i);
                    if(correto1!=-1)
                    {
                        printf("%d ",correto1);
                    }
                    else
                    {
                        printf("_ ");
                    }
                    if(correto2!=-1)
                    {
                        printf("%d ",correto2);
                    }
                    else
                    {
                        printf("_ ");
                    }
                    if(correto3!=-1)
                    {
                        printf("%d ",correto3);
                    }
                    else
                    {
                        printf("_ ");
                    }
                    if(correto4!=-1)
                    {
                        printf("%d ",correto4);
                    }
                    else
                    {
                        printf("_ ");
                    }
                }
                else
                {
                    printf("\n   Você acertou %d digito(s) dessa vez...\n\n",w+x+y+z);
                    printf("   Faltam %d tentativas....\n\n   ",10-i);
                    printf("   Seu código é: ",10-i);
                    if(correto1!=-1)
                    {
                        printf("%d ",correto1);
                    }
                    else
                    {
                        printf("_ ");
                    }
                    if(correto2!=-1)
                    {
                        printf("%d ",correto2);
                    }
                    else
                    {
                        printf("_ ");
                    }
                    if(correto3!=-1)
                    {
                        printf("%d ",correto3);
                    }
                    else
                    {
                        printf("_ ");
                    }
                    if(correto4!=-1)
                    {
                        printf("%d ",correto4);
                    }
                    else
                    {
                        printf("_ ");
                    }
                }
                printf("\n\n   ");
                system("pause");
            }
            if(i==5&&palpite!=cmd)
            {

                do
                {
                    system("cls");
                    printf("\n\n\tDigite o dígito desejado para a dica ==> ");
                    scanf("%d",&digito);
                    if(digito<1||digito>4)
                    {
                        printf("\n\n\tdigito inválido!!! digite novamente...\n\n\t\t");
                        system("pause");
                        system("cls");
                    }
                } while(digito<1||digito>4);

                system("cls");
                printf("\n\tEscolha uma carta: \n");
                printf("\n\t __________           __________           __________ ");
                printf("\n\t|          |         |          |         |          |");
                printf("\n\t|    /|    |         |  _____   |         |  _____   |");
                printf("\n\t|   / |    |         | /     \\  |         |       \\  |");
                printf("\n\t|     |    |         |       |  |         |        \\ |");
                printf("\n\t|     |    |         |      /   |         |        / |");
                printf("\n\t|     |    |         |     /    |         |    ----  |");
                printf("\n\t|     |    |         |    /     |         |        \\ |");
                printf("\n\t|     |    |         |   /      |         |        / |");
                printf("\n\t|   __|__  |         |  /_____/ |         |  _____/  |");
                printf("\n\t|__________|         |__________|         |__________|");
                printf("\n\n\n\tResposta ==> ");
                scanf("%d", &opcao);


                    printf("\n\n\t");
                    switch(opcao)
                    {
                        case 1:
                        {
                            if(carta1==1)
                            {
                                printf("Deu azar!!! sua carta escolhida era a que não possuia nenhuma dica...");
                            }
                            if(carta1==2)
                            {
                                if(digito==1)
                                {
                                    if(numsecreto1>=3)
                                    {
                                        printf("número entre 3 e 9 _ _ _");
                                    }
                                    else
                                    {
                                        printf("número entre 0 e 6 _ _ _");
                                    }
                                }
                                if(digito==2)
                                {
                                    if(numsecreto2>=3)
                                    {
                                        printf("_ número entre 3 e 9 _ _");
                                    }
                                    else
                                    {
                                        printf("_ número entre 0 e 6 _ _");
                                    }
                                }
                                if(digito==3)
                                {
                                    if(numsecreto3>=3)
                                    {
                                        printf("_ _ número entre 3 e 9 _");
                                    }
                                    else
                                    {
                                        printf("_ _ número entre 0 e 6 _");
                                    }
                                }
                                if(digito==4)
                                {
                                    if(numsecreto4>=3)
                                    {
                                        printf("_ _ _ número entre 3 e 9 ");
                                    }
                                    else
                                    {
                                        printf("_ _ _ número entre 0 e 6 ");
                                    }
                                }
                            }
                            if(carta1==3)
                            {
                                if(digito==1)
                                {
                                    if(numsecreto1%2==0)
                                    {
                                        printf("par _ _ _");
                                    }
                                    else
                                    {
                                        printf("impar _ _ _");
                                    }
                                }
                                if(digito==2)
                                {
                                    if(numsecreto2%2==0)
                                    {
                                        printf("_ par _ _");
                                    }
                                    else
                                    {
                                        printf("_ ímpar _ _");
                                    }
                                }
                                if(digito==3)
                                {
                                    if(numsecreto3%2==0)
                                    {
                                        printf("_ _ par _");
                                    }
                                    else
                                    {
                                        printf("_ _ ímpar _");
                                    }
                                }
                                if(digito==4)
                                {
                                    if(numsecreto4%2==0)
                                    {
                                        printf("_ _ _ par");
                                    }
                                    else
                                    {
                                        printf("_ _ _ ímpar");
                                    }
                                }
                            }
                            break;
                        }
                        case 2:
                        {
                            if(carta2==1)
                            {
                                printf("Deu azar!!! sua carta escolhida era a que não possuia nenhuma dica...");
                            }
                            if(carta2==2)
                            {
                                if(digito==1)
                                {
                                    if(numsecreto1>=3)
                                    {
                                        printf("número entre 3 e 9 _ _ _");
                                    }
                                    else
                                    {
                                        printf("número entre 0 e 6 _ _ _");
                                    }
                                }
                                if(digito==2)
                                {
                                    if(numsecreto2>=3)
                                    {
                                        printf("_ número entre 3 e 9 _ _");
                                    }
                                    else
                                    {
                                        printf("_ número entre 0 e 6 _ _");
                                    }
                                }
                                if(digito==3)
                                {
                                    if(numsecreto3>=3)
                                    {
                                        printf("_ _ número entre 3 e 9 _");
                                    }
                                    else
                                    {
                                        printf("_ _ número entre 0 e 6 _");
                                    }
                                }
                                if(digito==4)
                                {
                                    if(numsecreto4>=3)
                                    {
                                        printf("_ _ _ número entre 3 e 9 ");
                                    }
                                    else
                                    {
                                        printf("_ _ _ número entre 0 e 6 ");
                                    }
                                }
                            }
                            if(carta2==3)
                            {
                                if(digito==1)
                                {
                                    if(numsecreto1%2==0)
                                    {
                                        printf("par _ _ _");
                                    }
                                    else
                                    {
                                        printf("impar _ _ _");
                                    }
                                }
                                if(digito==2)
                                {
                                    if(numsecreto2%2==0)
                                    {
                                        printf("_ par _ _");
                                    }
                                    else
                                    {
                                        printf("_ ímpar _ _");
                                    }
                                }
                                if(digito==3)
                                {
                                    if(numsecreto3%2==0)
                                    {
                                        printf("_ _ par _");
                                    }
                                    else
                                    {
                                        printf("_ _ ímpar _");
                                    }
                                }
                                if(digito==4)
                                {
                                    if(numsecreto4%2==0)
                                    {
                                        printf("_ _ _ par");
                                    }
                                    else
                                    {
                                        printf("_ _ _ ímpar");
                                    }
                                }
                            }
                            break;
                        }
                        case 3:
                        {
                            if(carta3==1)
                            {
                                printf("Deu azar!!! sua carta escolhida era a que não possuia nenhuma dica...");
                            }
                            if(carta3==2)
                            {
                                if(digito==1)
                                {
                                    if(numsecreto1>=3)
                                    {
                                        printf("número entre 3 e 9 _ _ _");
                                    }
                                    else
                                    {
                                        printf("número entre 0 e 6 _ _ _");
                                    }
                                }
                                if(digito==2)
                                {
                                    if(numsecreto2>=3)
                                    {
                                        printf("_ número entre 3 e 9 _ _");
                                    }
                                    else
                                    {
                                        printf("_ número entre 0 e 6 _ _");
                                    }
                                }
                                if(digito==3)
                                {
                                    if(numsecreto3>=3)
                                    {
                                        printf("_ _ número entre 3 e 9 _");
                                    }
                                    else
                                    {
                                        printf("_ _ número entre 0 e 6 _");
                                    }
                                }
                                if(digito==4)
                                {
                                    if(numsecreto4>=3)
                                    {
                                        printf("_ _ _ número entre 3 e 9 ");
                                    }
                                    else
                                    {
                                        printf("_ _ _ número entre 0 e 6 ");
                                    }
                                }
                            }
                            if(carta3==3)
                            {
                                if(digito==1)
                                {
                                    if(numsecreto1%2==0)
                                    {
                                        printf("par _ _ _");
                                    }
                                    else
                                    {
                                        printf("impar _ _ _");
                                    }
                                }
                                if(digito==2)
                                {
                                    if(numsecreto2%2==0)
                                    {
                                        printf("_ par _ _");
                                    }
                                    else
                                    {
                                        printf("_ ímpar _ _");
                                    }
                                }
                                if(digito==3)
                                {
                                    if(numsecreto3%2==0)
                                    {
                                        printf("_ _ par _");
                                    }
                                    else
                                    {
                                        printf("_ _ ímpar _");
                                    }
                                }
                                if(digito==4)
                                {
                                    if(numsecreto4%2==0)
                                    {
                                        printf("_ _ _ par");
                                    }
                                    else
                                    {
                                        printf("_ _ _ ímpar");
                                    }
                                }
                            }
                            break;
                        }
                        default:
                        {
                            printf("\n\n\tCarta inexistente!! digite novamente...\n\n\t");
                            system("pause");
                            continue;
                        }

                    }
                    printf("\n\n\n\t");
                    system("pause");
            }
        }

            if((correto1!=numsecreto1)||(correto2!=numsecreto2)||(correto3!=numsecreto3)||(correto4!=numsecreto4))
            {
                    system("cls");
                    printf("\n\t\t*********************");
                    printf("\n\t\t|==> Game over!! <==|");
                    printf("\n\t\t*********************\n\n\t");
                    printf("\tO código secreto era: %d\n\n\t\t",cmd);
                    system("pause");
            }
            do
            {
                system("cls");
                printf("\n\tJogar mais uma vez??? \n\n\n\t1 - SIM\n\n\t2 - NÃO");
                printf("\n\n\tResposta: ");
                scanf("%d",&sair);
                if(sair>2||sair<1)
                {
                    system("cls");
                    printf("\n\tnúmero inválido!!!\n\n\t");
                    system("pause");
                }
            } while(sair>2||sair<1);
    }
    system("cls");
    printf("\n\tSistema finalizando...até logo!!\n\n\t");
    system("pause");

    return 0;
}
