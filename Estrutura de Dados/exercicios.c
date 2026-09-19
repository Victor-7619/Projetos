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
int main()
{
    Lista *L,*L2,*L3;

    L = inicializaLista();
    L = criaLista();
    L3 = inicializaLista();
    L3 = criaLista();

    insereInicioLista(L,3);
    insereInicioLista(L,7);
    insereInicioLista(L,9);

    insereInicioLista(L3,4);
    insereInicioLista(L3,2);
    insereInicioLista(L3,6);

    crescenteLista(L);
    crescenteLista(L3);

    imprimeLista(L);
    imprimeLista(L2);
    imprimeLista(L3);

    return 0;
}
