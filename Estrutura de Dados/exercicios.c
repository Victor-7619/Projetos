#include<stdio.h>
#include<stdlib.h>
#include"listLibr.h"

Lista* duplica(Lista *p)
{
    Lista *L;
    L = criaLista();

    No *aux = p->inicio;

    while(aux!=NULL)
    {
        insereFimLista(L,aux->info);
        aux = aux->prox;
    }
    return L;
}

void inverte(Lista* L1,Lista* L2)
{
    No *aux = L1->inicio;

    while(aux!=NULL)
    {
        insereInicioLista(L2,aux->info);
        aux = aux->prox;
    }
}
void crescenteLista(Lista *p)
{
    No *aux = p->inicio,*aux2;
    int valueAux,cont = 1;

    if(vaziaLista(p))
    {
        printf("\nLista Vazia!");
    }
    else
    {
        while(aux->prox!=NULL)
        {
            if(aux->info>aux->prox->info)
            {
                cont = 1;
                while(cont!=0)
                {
                    aux2 = p->inicio;
                    cont = 0;

                    while(aux2!=aux->prox)
                    {
                        if(aux2->info>aux2->prox->info)
                        {
                            valueAux = aux2->info;
                            aux2->info = aux2->prox->info;
                            aux2->prox->info = valueAux;
                            cont++;
                        }
                        aux2 = aux2->prox;
                    }
                }
            }
            aux = aux->prox;
        }
    }
}
/*Lista* mergeListas(Lista *L1,Lista *L2)
{
    No *aux = L1->inicio, *aux2 = L2->inicio;

    while(aux)
}*/
Lista * Divide(Lista *p, int k)
{
    Lista* L;
    L = criaLista();
    No *aux = p->inicio;
    int valor;

    for(int i = 1; aux!= NULL && i<k; i++)
    {
        aux = aux->prox;
    }
    while(aux!=NULL)
    {
        aux = aux->prox;
        if(apagaQualquerPosLista(p,k,&valor))
        {
            insereFimLista(L,valor);
        }
    }
    return L;
}
void ImprimeSuspeito(Lista *p)
{
    No *aux = p->inicio;
    int cont = 0;

    while(aux != NULL)
    {
        if(aux->info == 1)
        {
            cont++;
        }
        aux = aux->prox;
    }
    if(cont==2)
    {
        printf("\nPessoa analisada é suspeita!");
    }
    else if(cont==3||cont==4)
    {
        printf("\nPessoa analisada consta como cumplice!");
    }
    else if(cont==5)
    {
        printf("\nPessoa analisada consta como Assassina!");
    }
    else
    {
       printf("\nPessoa é inocente.");
    }
}
int main()
{
    Lista *L,*L2,*L3;

    L = inicializaLista();
    L = criaLista();
    L3 = inicializaLista();
    L3 = criaLista();

    insereInicioLista(L,0);
    insereInicioLista(L,0);
    insereInicioLista(L,0);
    insereInicioLista(L,0);
    insereInicioLista(L,0);

    insereInicioLista(L3,4);
    insereInicioLista(L3,2);
    insereInicioLista(L3,6);

    /*printf("inicio L1: %d", apagaInicioLista(L));
    printf("\nfim l1: %d", apagaFimLista(L));
    printf("\npos 2 L3: %d", apagaQualquerPosLista(L3,2));*/

    /*crescenteLista(L);
    crescenteLista(L3);
    L2 = Divide(L,7);*/

    imprimeLista(L);
    /*imprimeLista(L2);
    imprimeLista(L3);*/
    ImprimeSuspeito(L);

    return 0;
}
