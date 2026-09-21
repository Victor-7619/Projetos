#ifndef PILHALIBR_H_INCLUDED
#define PILHALIBR_H_INCLUDED

typedef struct no
{
int info;
struct no *prox;
}No;

typedef struct pilha
{
No *Topo;
}Pilha;

Pilha* CriaPilha (void)
{
Pilha *p;
p=(Pilha*)malloc(sizeof(Pilha));
p->Topo = NULL;
return p;
}

No* ins_ini (No* t, int a)
{
No* aux = (No*) malloc(sizeof(No));
aux->info = a;
aux->prox = t;
return aux;
}

int vaziaPilha(Pilha *p)
{
    if(p->Topo==NULL)
    {
        return 1;
    }
    return 0;
}

void push (Pilha* p, int v)
{
p->Topo = ins_ini(p->Topo,v);
}

No* ret_ini (No* aux)
{
No* p = aux->prox;
free(aux);
return p;
}

int pop (Pilha *p)
{
int v;
if (vaziaPilha(p))
    {
    printf("\n\n\t==> Pilha VAZIA, IMPOSSIVEL CONTINUAR.\b\n");
    exit(1); /* aborta programa */
    }
v = p->Topo->info;
p->Topo = ret_ini(p->Topo);
return v;
}

void imprimePilha(Pilha *p)
{
    No *aux=p->Topo;

    printf("\nLista: ");
    while(aux!=NULL)
    {
        printf("%d ",aux->info);
        aux=aux->prox;
    }
}
void liberaPilha(Pilha *p)
{
    No *aux;

    while(p->Topo != NULL)
    {
        aux = p->Topo;
        p->Topo = p->Topo->prox;
        free(aux);
    }

    free(p);
}
float mediaPilha(Pilha *p)
{
    No *aux=p->Topo;
    float soma=0;
    int cont=0;

    for(;aux!=NULL;cont++)
    {
        soma+=aux->info;
        aux=aux->prox;
    }
    return soma/cont;
}
int MaisElements(Pilha *p1,Pilha *p2)
{
    No *aux=p1->Topo;
    int i,j;

    for(i=0;aux!=NULL;i++)
    {
        aux=aux->prox;
    }
    printf("\ni: %d\n\n",i);
    aux=p2->Topo;

    for(j=0;aux!=NULL;j++)
    {
        aux=aux->prox;
    }
    printf("j: %d\n\n",j);

    if(i==j)
    {
        return 0;
    }
    if(i>j)
    {
        return 1;
    }
    return 2;
}

#endif // PILHALIBR_H_INCLUDED
