#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<ctype.h>
#include<locale.h>
#define tam 10

void inicializar_tabuleiro(int tabuleiro[tam][tam])
{
    for(int i=0;i<tam;i++)
    {
        for(int j=0;j<tam;j++)
        {
        tabuleiro[i][j]=rand()%2;
        }
    }
}
void imprimir_tabuleiro(int tabuleiro[tam][tam])
{
    for(int i=0;i<tam;i++)
    {
        printf("\t");
        for(int j=0;j<tam;j++)
        {
            if(tabuleiro[i][j]==1)
            {
                printf("V ");
            }
            else
            {
                printf("- ");
            }
        }
        printf("\n");
    }
}
int contar_vizinhos_vivos(int tabuleiro[tam][tam], int linha, int coluna)
{
    int cont=0,nlinha,ncoluna;

    for(int i=-1;i<=1;i++)
    {
        for (int j=-1;j<=1;j++)
        {
            if (i==0&&j==0)
            {
                continue;
            }
            nlinha=linha+i;
            ncoluna=coluna+j;
            if (nlinha>=0&&nlinha<tam&&ncoluna>=0&&ncoluna<tam)
            {
                cont+=tabuleiro[nlinha][ncoluna];
            }

        }
    }
    return cont;
}
void atualizar_tabuleiro(int tabuleiro [tam][tam], int novoTabuleiro[tam][tam])
{
    int i,j,vizinhos;

    for(i=0;i<tam;i++)
    {
        for(j=0;j<tam;j++)
        {
            vizinhos=contar_vizinhos_vivos(tabuleiro,i,j);
            if (tabuleiro[i][j]==1)
            {
                novoTabuleiro[i][j]=(vizinhos==2 || vizinhos==3) ? 1:0;
            }
            else
            {
                novoTabuleiro[i][j]=(vizinhos == 3) ? 1:0;
            }
        }
    }
}
void copiar_tabuleiro(int origem[tam][tam], int destino[tam][tam])
{
    for(int i=0;i<tam;i++)
    {
        for(int j=0;j<tam;j++)
        {
            destino[i][j]=origem[i][j];
        }
    }
}
void limpar_tela()
{

    printf("\n");
    printf("\tPressione ENTER para continuar...\n");
    getchar();
    system("cls");
}

int main()
{
    char resposta;
    int tabuleiro[tam][tam],novoTabuleiro[tam][tam],geracoes,geracao_atual;

    srand(time(NULL));
    setlocale(LC_ALL, "portuguese");

    do
    {
        printf("\n\t=========================================\n");
        printf("\t||                                     ||\n");
        printf("\t||         JOGO DA VIDA - CONWAY       ||\n");
        printf("\t||                                     ||\n");
        printf("\t=========================================\n");
        printf("\t      Um simulador de células vivas      \n");
        printf("\t        baseado em regras simples        \n");
        printf("\t             criado por você!            \n");
        printf("\t=========================================\n");
        limpar_tela();


        printf("\n\t=========== INSTRUÇÕES DO JOGO ===========\n\n");
        printf("\t1. O tabuleiro tem tamanho %dx%d;\n", tam, tam);
        printf("\t2. Cada célula pode estar VIVA (V) ou MORTA (-);\n");
        printf("\t3. A cada geração, as células evoluem de acordo com estas regras:\n");
        printf("\t   - Uma célula viva continua viva se tiver 2 ou 3 vizinhos vivos,\n\t     caso contrário, morre por solidão ou superpopulação;\n");
        printf("\t   - Uma célula morta torna-se viva se tiver exatamente 3 vizinhos vivos;\n");
        printf("\t   - Em todos os outros casos, as células morrem ou permanecem mortas;\n");
        printf("\t4. Você escolherá quantas gerações deseja simular.\n");
        printf("\t===========================================\n\n");
        printf("\tPressione ENTER para iniciar o jogo...\n\t");
        getchar();
        system("cls");
        do
        {
            printf("\n\tQuantas gerações você deseja simular?\n\n");
            printf("\tResposta: ");
            scanf("%d", &geracoes);
            if(geracoes<1)
            {
                printf("\n\tQuantidade inválida... digite um número maior que 0.\n");
                limpar_tela();
            }
        } while(geracoes<1);
        limpar_tela();
        printf("\n\tPrimeira geração: \n\n");
        inicializar_tabuleiro(tabuleiro);
        imprimir_tabuleiro(tabuleiro);
        limpar_tela();

        for(geracao_atual=1;geracao_atual<=geracoes;geracao_atual++)
        {
            printf("\n\t==>Geração %d\n\n",geracao_atual);
            printf("\tGeração atual:\n");
            imprimir_tabuleiro(tabuleiro);
            atualizar_tabuleiro(tabuleiro,novoTabuleiro);
            printf("\n\tNova geração:\n");
            imprimir_tabuleiro(novoTabuleiro);
            copiar_tabuleiro(novoTabuleiro,tabuleiro);
            limpar_tela();
        }
        printf("\n\tFim do jogo...\n");
        limpar_tela();
        printf("\n\tDeseja simular novamente?");
            printf("\n\n\t==> S: Sim\n\n\t==> N: Não\n\n");
            printf("\tResposta: ");
            fflush(stdin);
            resposta=getchar();
            while((toupper(resposta)!='S') && (toupper(resposta)!='N'))
            {
                system("cls");
                printf("\n\tDigite apenas S OU N\n\n");
                printf("\tNova Resposta: ");
                fflush(stdin);
                resposta=getchar();
                limpar_tela();
            }
    }while(toupper(resposta)=='S');
    printf("\n\tSimulação finalizada!! Até breve.\n\t");
    return 0;
}
