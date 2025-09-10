clear % remove todas as váriaveis
clc % limpa a janela de comandos
close all % fecha todas as figuras gráficas abertas

## Pacote simbólico % biblioteca com variáveis
pkg load symbolic % carregar as funções do pacote

syms th dx dy dz L1 l2 L3 L4 L5 L6 L7 real % declarar variáveis simbólicas
syms th1 th2 th3 th4 th5 th6 th7 real %declarar variáveis simbólicas

one = sym(1); zero = sym(0); % declaração de duas variáveis simbólicenseas (0 & 1)
deg2rad_sym = @(d)sym(d) * sym(pi)/ sym(180); %usada para converter ângulos expressos em graus para radiano

T = [ zero zero zero one;% condição de existência
      one zero zero dx; % X1, Y1 , Z1 relacionadas ao X0 / Criação da matriz de translação 4x4
      zero one zero dy;% X1, Y1 , Z1 relacionadas ao Y0
      zero zero one dz];% X1, Y1 , Z1 relacionadas ao Z0
      
Rx = [ one   zero     zero     zero; % Eixo X1,onde o X1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero  cos(th) -sin(th)  zero; % Eixo Y1,onde o X1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero  sin(th)  cos(th)  zero; % Eixo Z1,onde o X1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero  zero     zero     one]; %Linha para montar matriz generalizada
       
       
 Rz= [ cos(th) -sin(th) zero zero;  %Eixo X, onde o Z1 vai ser rotacionado e comparado X0,Y0 & Z0
       sin(th) cos(th) zero zero; %Eixo Y1,onde o Z1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero     zero     one  zero; %Eixo Z1,onde o Z1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero     zero     one  zero]; % Linha para montar matriz generalizada
       
 F0=sym(eye(4)); % criação de matriz identidade 4x4 e conversão para símbolos matemáticos
 
 Tr_0_1 = subs(T, [dx dy dz], [zero zero zero]); % inicializar o sistema homogêneo
 TH_0_1 = Tr_0_1 * subs(Rz, th, th1); % comando de movimentação sendo o antigo * o novo para movimentação
 F1 = F0 * TH_0_1;% criação do frame inercial
 
 pi2 = sym(pi)/2; % declarando pi2 / pi2=3,14/2, como valor simbólico
 
 Tr_1_2 = subs(T, [dx dy dz], [zero zero L1]) * subs(Rx, th, pi2); % o Tr_1_2 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero zero e l1, pela a substituição de th por pi2 de Rx
 TH_1_2 = Tr_1_2 * subs(Rz, th, th2) % TH_1_2 será igual a translação de 1 a 2 multiplicado pela substituição do th por th2 de rz
 F2 = F1 * TH_1_2; % Frame 2 será o Frame 1 multiplicado pelo TH_1_2
 
 % em resumo, do frame 1 para o frame 2, o robô irá transladar l1 unidades no eixo Z, rotacionar 90 graus em torno do eixo x e rotacionar th2 radianos ou graus em torno do eixo z
 
 Tr_2_3 = subs(T, [dx dy dz], [zero L2 zero]) * subs(Rx, th, -pi2); % o Tr_2_3 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero l2 e zero, pela a substituição de th por -pi2 de Rx
 TH_2_3 = Tr_2_3 * subs(Rz, th, th3); % TH_1_2 será igual a translação de 2 a 3 multiplicado pela substituição do th por th3 de rz
 F3 = F2 * TH_2_3; % Frame 3 será o Frame 2 multiplicado pelo TH_2_3
 
  % em resumo, do frame 2 para o frame 3, o robô irá transladar l2 unidades no eixo y, rotacionar -90 graus em torno do eixo x e rotacionar th3 radianos ou graus em torno do eixo z
 
 Tr_3_4 = subs(T, [dx dy dz], [zero zero L3]) * subs(Rx, th, pi2); % o Tr_3_4 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero zero e l3, pela a substituição de th por pi2 de Rx
 TH_3_4 = Tr_3_4 * subs(Rz, th, th4); % TH_3_4 será igual a translação de 3 a 4 multiplicado pela substituição do th por th4 de rz
 F4 = F3 * TH_3_4; % Frame 4 será o Frame 3 multiplicado pelo TH_3_4

 % em resumo, do frame 3 para o frame 4, o robô irá transladar l3 unidades no eixo Z, rotacionar 90 graus em torno do eixo x e rotacionar th4 radianos ou graus em torno do eixo z

 Tr_4_5 = subs(T, [dx dy dz], [zero L4 zero]) * subs(Rx, th, -pi2); % o Tr_4_5 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero l4 e zero, pela a substituição de th por -pi2 de Rx
 TH_4_5 = Tr_4_5 * subs(Rz, th, th5); % TH_4_5 será igual a translação de 4 a 5 multiplicado pela substituição do th por th5 de rz
 F5 = F4 * TH_4_5; % Frame 5 será o Frame 4 multiplicado pelo TH_4_5

 % em resumo, do frame 4 para o frame 5, o robô irá transladar l4 unidades no eixo y, rotacionar -90 graus em torno do eixo x e rotacionar th5 radianos ou graus em torno do eixo z

 Tr_5_6 = subs(T, [dx dy dz], [zero zero L5]) * subs(Rx, th, pi2); % o Tr_5_6 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero zero e l5, pela a substituição de th por pi2 de Rx
 TH_5_6 = Tr_5_6 * subs(Rz, th, th6); % TH_5_6 será igual a translação de 5 a 6 multiplicado pela substituição do th por th6 de rz
 F6 = F5 * TH_5_6; % Frame 6 será o Frame 5 multiplicado pelo TH_5_6

 % em resumo, do frame 5 para o frame 6, o robô irá transladar l5 unidades no eixo Z, rotacionar 90 graus em torno do eixo x e rotacionar th6 radianos ou graus em torno do eixo z

 Tr_7_8 = subs(T, [dx dy dz], [zero zero L7]); % o Tr_7_8 será igual a substituição de dx, dy e dz da matriz de transição por zero zero e l7, sem rotação
 F8 = F7 * Tr_7_8; % Frame 8 será o Frame 7 multiplicado pelo Tr_7_8

 % em resumo, do frame 7 para o frame 8, o robô irá transladar l7 unidades no eixo Z, sem rotacionar

       

       
       