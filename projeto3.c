#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<locale.h>
#include<ctype.h>


typedef struct produto
{
    int codigo,quant_estoque;
    char nome[51];
    float valor;
}produto;
typedef struct venda
{
    int codigo_venda,quant_vendida;
    produto produto_vendido;
    float valorTT;
}venda;
void lp()
{
    printf("\n\t");
    system("pause");
    system("cls");
}
void cadastrar_produto(produto produtos[], int *quant)
{
    int i,aux=1,carac=1;
    if(*quant>=50)
    {
        printf("\n\t==> Limite de produtos atingido!! <==\n");
        return;
    }
    do
    {
        printf("\n\tDigite o nome do novo produto: ");
        fflush(stdin);
        fgets(produtos[*quant].nome,51,stdin);
        if(*quant>0)
        {
            for(i=0;i<*quant;i++)
            {
                if(strcmp(produtos[i].nome,produtos[*quant].nome)==0)
                {
                    printf("\n\t==> Produto já cadastrado!! <==\n");
                    aux=0;
                    lp();
                    break;
                }
                else
                {
                    aux=1;
                }
            }
        }
    }while(aux==0);
    do
    {
        do
        {
            printf("\n\tDigite o código do novo produto: ");
            carac=scanf("%d",&produtos[*quant].codigo);
            if(carac!=1)
            {
                printf("\n\t==> Atenção!! Digite um valor numérico... <==\n");
                fflush(stdin);
                lp();
            }
        }while(carac!=1);
        if(*quant>0)
        {
            for(i=0;i<*quant;i++)
            {
                if(produtos[i].codigo==produtos[*quant].codigo)
                {
                    printf("\n\t==> Código já cadastrado!! <==\n");
                    aux=0;
                    lp();
                    break;
                }
                else
                {
                    aux=1;
                }
            }
        }
    }while(aux==0);
    do
    {
        printf("\n\tDigite a quantidade em estoque do novo produto: ");
        carac=scanf("%d",&produtos[*quant].quant_estoque);
        if(carac!=1)
        {
            printf("\n\t==> Atenção!! Digite um valor numérico... <==\n");
            fflush(stdin);
            lp();
        }
    }while(carac!=1);
    do
    {
        printf("\n\tDigite o valor do novo produto (em Reais): ");
        carac=scanf("%f",&produtos[*quant].valor);
        if(carac!=1)
        {
            printf("\n\t==> Atenção!! Digite um valor numérico... <==\n");
            fflush(stdin);
            lp();
        }
    }while(carac!=1);
    (*quant)++;
    printf("\n\tProduto cadastrado!(Total cadastrado: %d)\n",*quant);
}
void registrar_venda(produto produtos[],venda vendas[],int *quant_v,int *quant_p)
{
    char nome[51];
    int aux=-1,prod=-1,carac=1;
    if(*quant_p==0)
    {
        printf("\n\t==> Nenhum produto registrado!! <==\n");
        return;
    }
    do
    {
        printf("\n\tDigite o nome do produto vendido: ");
        fflush(stdin);
        fgets(nome,51,stdin);
        for (int i=0;i<*quant_p;i++)
        {
            if (strcmp(nome,produtos[i].nome)==0)
            {
                prod=i;
                break;
            }
        }
        if (prod==-1)
        {
            printf("\n\t==> Produto não encontrado!! <==\n");
            lp();
        }
    }while(prod==-1);
    do
    {
        do
        {
            printf("\n\tDigite o código da venda: ");
            carac=scanf("%d",&vendas[*quant_v].codigo_venda);
            if(carac!=1)
            {
                printf("\n\t==> Atenção!! Digite um valor numérico... <==\n");
                fflush(stdin);
                lp();
            }
        }while(carac!=1);
        if(*quant_v>0)
        {
            for(int i=0;i<*quant_v;i++)
            {
                if(vendas[*quant_v].codigo_venda==vendas[i].codigo_venda)
                {
                    printf("\n\t==> Código já cadastrado!! <==\n");
                    aux=0;
                    lp();
                    break;
                }
                else
                {
                    aux=-1;
                }
            }
        }
    }while(aux==0);
    do
    {
        printf("\n\tDigite a quantidade de produtos vendidos: ");
        carac=scanf("%d",&vendas[*quant_v].quant_vendida);
        if(carac!=1)
        {
            printf("\n\t==> Atenção!! Digite um valor numérico... <==\n");
            fflush(stdin);
            lp();
        }
    }while(carac!=1);

    if (vendas[*quant_v].quant_vendida > produtos[prod].quant_estoque)
    {
        printf("\n\t==> Erro: estoque insuficiente. <==\n");
        return;
        lp();
    }
    vendas[*quant_v].produto_vendido = produtos[prod];
    vendas[*quant_v].valorTT=produtos[prod].valor*vendas[*quant_v].quant_vendida;
    produtos[prod].quant_estoque -= vendas[*quant_v].quant_vendida;
    (*quant_v)++;
    printf("\n\tVenda concluída e registrada com sucesso!!\n");
}
void exibir_disponiveis(produto produtos[],int quant)
{
    int aux=0;
    if(quant==0)
    {
        printf("\n\t==> Nenhum produto registrado!! <==\n");
        return;
    }
    for(int i=0;i<quant;i++)
    {
        if(produtos[i].quant_estoque>0)
        {
            printf("\n              ===> Produto %d: <===\n\n",produtos[i].codigo);
            printf("\tNome do produto       - %s\n",produtos[i].nome);
            printf("\tCódigo do produto     - %d\n\n",produtos[i].codigo);
            printf("\tQuantidade em estoque - %d\n\n",produtos[i].quant_estoque);
            printf("\tValor do produto      - R$ %.2f\n\n",produtos[i].valor);
            printf("\t---------------------------------------------------------------");
            aux++;
        }
        if(aux==0)
        {
            printf("\n\t==> Todos os produtos encontram-se em falta!! <==\n");
        }
    }
}
void listar_vendas(venda vendas[],int quant)
{
    if(quant==0)
    {
        printf("\n\t==> Nenhuma venda registrada!! <==\n");
        return;
    }
    for(int i=0;i<quant;i++)
    {
        printf("\n              ===> Venda %d: <===\n\n",vendas[i].codigo_venda);
        printf("\tNome do produto vendido   - %s\n",vendas[i].produto_vendido.nome);
        printf("\tCódigo da venda           - %d\n\n",vendas[i].codigo_venda);
        printf("\tUnidades vendidas         - %d\n\n",vendas[i].quant_vendida);
        printf("\tValor total da venda      - R$ %.2f\n\n",vendas[i].valorTT);
        printf("\t---------------------------------------------------------------");
    }
}
void produtos_falta(produto produtos[],int quant)
{
    int aux=0;
    if(quant==0)
    {
        printf("\n\t==> Nenhum produto registrado!! <==\n");
        return;
    }
    for(int i=0;i<quant;i++)
    {
        if(produtos[i].quant_estoque==0)
        {
            if(aux==0)
            {
                printf("\n              PRODUTOS EM FALTA!!\n\n");
            }
            printf("\n              ===> Produto %d: <===\n\n",produtos[i].codigo);
            printf("\tNome do produto       - %s\n",produtos[i].nome);
            printf("\tCódigo do produto     - %d\n\n",produtos[i].codigo);
            printf("\tQuantidade em estoque - %d\n\n",produtos[i].quant_estoque);
            printf("\tValor do produto      - R$ %.2f\n\n",produtos[i].valor);
            printf("\t---------------------------------------------------------------");
            aux++;
        }
    }
    if(aux==0)
    {
        printf("\n\t==> Nenhum produto encontra-se em falta!! <==\n");
    }
}
void rela_um(venda vendas[],produto produtos[],int quant_vendas,int quant_produtos)
{
    int aux=0,mais_v[50]={0},mais_vendido;
    for(int i=0;i<quant_produtos;i++)
    {
        for(int j=0;j<quant_vendas;j++)
        {
            if(strcmp(vendas[j].produto_vendido.nome,produtos[i].nome)==0)
            {
                mais_v[i]=mais_v[i]+vendas[j].quant_vendida;
            }
        }
    }
    for(int i=0;i<quant_produtos;i++)
    {
        if(mais_v[i]>aux)
        {
            aux=mais_v[i];
            mais_vendido=i;
        }
    }

    printf("\n              ****MAIS VENDIDO****\n");
    printf("\n              ===> Produto %d: <===\n\n",produtos[mais_vendido].codigo);
    printf("\tNome do produto       - %s\n\n",produtos[mais_vendido].nome);
    printf("\tCódigo do produto     - %d\n\n",produtos[mais_vendido].codigo);
    printf("\tQuantidade vendida    - %d\n\n",mais_v[mais_vendido]);
    printf("\tValor do produto      - R$ %.2f\n\n",produtos[mais_vendido].valor);
    printf("\t---------------------------------------------------------------");
}
void rela_dois(venda vendas[],produto produtos[],int quant_vendas,int quant_produtos)
{
    for(int i=0;i<quant_produtos;i++)
    {
        int cont=0;
        for(int j=0;j<quant_vendas;j++)
        {
            if(strcmp(vendas[j].produto_vendido.nome,produtos[i].nome)==0)
            {
                if(cont==0)
                {
                    printf("\n\t<PRODUTO %d> \n",produtos[i].codigo);
                }
                printf("\n\t==> VENDA %d:",j+1);
                printf("\n\tCódigo da venda: %d",vendas[j].codigo_venda);
                printf("\n\tQuantidade vendida: %d\n",vendas[j].quant_vendida);
                cont++;
            }
        }
        printf("\n\t--> Quantidade Total de vendas do produto %d: %d <--\n",produtos[i].codigo,cont);
        printf("\t------------------------------------------------------");
    }
}
void rela_tres(venda vendas[],int quant_vendas)
{
    float soma=0;
    for(int i=0;i<quant_vendas;i++)
    {
        soma+=vendas[i].valorTT;
    }
    listar_vendas(vendas,quant_vendas);
    printf("\n\n\t==> O valor total ganho com totas as vendas é de R$%.2f\n",soma);
}
void gerar_rela(venda vendas[],produto produtos[],int quant_vendas,int quant_produtos)
{
    int opcao,carac=0;
    do
    {
        do
        {
            printf("\n\t===========================================\n");
            printf("\n\t<DIGITE QUAL RELATÓRIO VOCê DESEJA ACESSAR>\n");
            printf("\n\t========================================\n");
            printf("\t1 - Relatório Nº 1 (Produto mais vendido)\n");
            printf("\t2 - Relatório Nº 2 (Vendas por produto)\n");
            printf("\t3 - Relatório Nº 3 (vendas totais)\n");
            printf("\t0 - Sair\n");
            printf("\t===========================================\n");
            printf("\tDigite a opção desejada: ");
            carac=scanf("%d",&opcao);
            if(carac!=1)
            {
                printf("\n\t==> Atenção!! Digite um valor numérico... <==\n");
                fflush(stdin);
                opcao=-1;
                lp();
            }
            system("cls");
        }while(opcao==-1);

        switch(opcao)
        {
            case 1:
            {
                if(quant_vendas==0)
                {
                    printf("\n\t==> Nenhuma venda registrada!! <==\n");
                    lp();
                    break;
                }
                rela_um(vendas,produtos,quant_vendas,quant_produtos);
                lp();
                break;
            }
            case 2:
            {
                if(quant_vendas==0)
                {
                    printf("\n\t==> Nenhuma venda registrada!! <==\n");
                    lp();
                    break;
                }
                rela_dois (vendas,produtos,quant_vendas,quant_produtos);
                lp();
                break;
            }
            case 3:
            {
                if(quant_vendas==0)
                {
                    printf("\n\t==> Nenhuma venda registrada!! <==\n");
                    lp();
                    break;
                }
                rela_tres(vendas,quant_vendas);
                lp();
                break;
            }
            case 0:
            {
                break;
            }
            default:
            {
                printf("\n\tOpção inválida!!\n");
                lp();
                break;
            }
        }
    }while(opcao!=0);
}

int main()
{
    produto produtos[50];
    venda vendas[100];
    int opcao,quant_produtos=0,quant_vendas=0,carac=0;
    setlocale(LC_ALL,"portuguese");
    do
    {
        do
        {

            printf("\n\t========================================\n");
            printf("\t        ==>QUAL VOCÊ DESEJA?<==\n");
            printf("\t========================================\n");
            printf("\t1 - Cadastrar um Produto\n");
            printf("\t2 - Registrar uma Venda\n");
            printf("\t3 - Listar Produtos Disponíveis\n");
            printf("\t4 - Listar Vendas\n");
            printf("\t5 - Listar Produtos em Falta\n");
            printf("\t6 - Gerar Relatórios\n");
            printf("\t0 - Sair\n");
            printf("\t========================================\n");
            printf("\tDigite a opção desejada: ");
            carac=scanf("%d",&opcao);
            if(carac!=1)
            {
                printf("\n\t==> Atenção!! Digite um valor numérico... <==\n");
                fflush(stdin);
                opcao=-1;
                lp();
            }
            system("cls");
        }while(opcao==-1);

        switch(opcao)
        {
            case 1:
            {
                cadastrar_produto(produtos,&quant_produtos);
                lp();
                break;
            }
            case 2:
            {
                registrar_venda(produtos,vendas,&quant_vendas,&quant_produtos);
                lp();
                break;
            }
            case 3:
            {
                exibir_disponiveis(produtos,quant_produtos);
                lp();
                break;
            }
            case 4:
            {
                 listar_vendas(vendas,quant_vendas);
                 lp();
                 break;
            }
            case 5:
            {
                produtos_falta(produtos,quant_produtos);
                lp();
                break;
            }
            case 6:
            {
                gerar_rela(vendas,produtos,quant_vendas,quant_produtos);
                break;
            }
            case 0:
            {
                printf("\n\t==>Encerrando o sistema!!\n\t");
                break;
            }
            default:
            {
                printf("\n\t==> Opção inválida!! <==");
                lp();
            }
        }
    }while(opcao!=0);
    return 0;
}
