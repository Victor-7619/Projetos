 clear % remove todas as váriaveis
 clc % limpa a janela de comandos
 close all % fecha todas as figuras gráficas abertas

  ## Pacote simbólico % biblioteca com variáveis
 pkg load symbolic % carregar as funções do pacote

  % --------- Simbólico base ---------

 syms th dx dy dz L1 L2 L3 L4 L5 L6 L7 real % declarar variáveis simbólicas
 syms th1 th2 th3 th4 th5 th6 th7 real %declarar variáveis simbólicas

 one = sym(1); zero = sym(0); % declaração de duas variáveis simbólicenseas (0 & 1)
 deg2rad_sym = @(d)sym(d) * sym(pi)/ sym(180); %usada para converter ângulos expressos em graus para radiano

 T = [ one zero zero dx;% condição de existência
      zero one zero dy; % X1, Y1 , Z1 relacionadas ao X0 / Criação da matriz de translação 4x4
      zero zero one dz;% X1, Y1 , Z1 relacionadas ao Y0
      zero zero zero one];% X1, Y1 , Z1 relacionadas ao Z0

 Rx = [ one   zero     zero     zero; % Eixo X1,onde o X1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero  cos(th) -sin(th)  zero; % Eixo Y1,onde o X1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero  sin(th)  cos(th)  zero; % Eixo Z1,onde o X1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero  zero     zero     one]; %Linha para montar matriz generalizada


 Rz= [ cos(th) -sin(th) zero zero;  %Eixo X, onde o Z1 vai ser rotacionado e comparado X0,Y0 & Z0
       sin(th) cos(th) zero zero; %Eixo Y1,onde o Z1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero     zero     one  zero; %Eixo Z1,onde o Z1 vai ser rotacionado e comparado com X0,Y0 & Z0
       zero     zero     zero  one]; % Linha para montar matriz generalizada

 F0 = sym(eye(4)); % criação de matriz identidade 4x4 e conversão para símbolos matemáticos

  % --------- Cadeia de frames (100% simbólica) ---------

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

 Tr_6_7 = subs(T, [dx dy dz], [zero zero L7]); % o Tr_6_7 será igual a substituição de dx, dy e dz da matriz de transição por zero zero e l7, sem rotação
 TH_6_7 = Tr_6_7 * subs(Rz, th, th7); % TH_6_7 será igual a translação de 5 a 6 multiplicado pela substituição do th por th7 de rz
 F7 = F6 * TH_6_7; % Frame 7 será o Frame 6 multiplicado pelo Tr_6_7

 Tr_7_8 = subs(T, [dx dy dz], [zero zero L7]); % o Tr_7_8 será igual a substituição de dx, dy e dz da matriz de transição por zero zero e l8, sem rotação
 F8 = F7 * Tr_7_8; % Frame 7 será o Frame 8 multiplicado pelo Tr_7_8
  % em resumo, do frame 7 para o frame 8, o robô irá transladar l7 unidades no eixo Z, sem rotacionar

  % --------- Parâmetros numéricos ---------

  % comprimentos (strings -> simbólico)
 l1s = sym('0.18'); l2s = sym('0.169'); l3s = sym('0.159'); % declaração de valores para l1 a l3
 l4s = sym('0.14825'); l5s = sym('0.12825'); l6s = sym('0.12585'); % declaração de valores para l4 a l6
 l7s = sym('0.04585');% declaração de valores para l7

  % ângulos em rad (simbólicos)
 t1s = deg2rad_sym(0); t2s = deg2rad_sym(0); t3s = deg2rad_sym(0); % conversão de graus para radianos
 t4s = deg2rad_sym(0); t5s = deg2rad_sym(0); t6s = deg2rad_sym(0); % conversão de graus para radianos
 t7s = deg2rad_sym(45); % conversão de graus para radianos

  % --------- Substituições -> vpa -> double ---------
 F0 = eye(4); % criação de matriz identidade 4x4 (ponto de origem frame 0)
 F1 = double(vpa(subs(F1, th1, t1s), 12)); % subs é executado primeiro, substituindo th1 por t1s. Depois vem o vpa que transforma o decimal do resultado de subs e o resume a 12 casas decimais e o double substitui todos os th1 por t1s na matriz simbólica, a transformando em matriz numérica
 F2 = double(vpa(subs(F2, [L1 th1 th2], [l1s t1s t2s]), 12)); % substitui L1, th1 e th2 por seus respectivos valores; vpa reduz a 12 casas decimais; double transforma em matriz numérica
 F3 = double(vpa(subs(F3, [L2 L1 th1 th2 th3], [l2s l1s t1s t2s t3s]), 12)); % substitui L2, L1, th1, th2 e th3; vpa avalia com 12 dígitos; double converte para matriz numérica
 F4 = double(vpa(subs(F4, [L3 L2 L1 th1 th2 th3 th4], [l3s l2s l1s t1s t2s t3s t4s]), 12)); % substitui L3 até L1 e th1 até th4; vpa reduz a 12 casas; double gera matriz numérica
 F5 = double(vpa(subs(F5, [L4 L3 L2 L1 th1 th2 th3 th4 th5], [l4s l3s l2s l1s t1s t2s t3s t4s t5s]), 12)); % substitui L4 até L1 e th1 até th5; vpa e double finalizam como antes
 F6 = double(vpa(subs(F6, [L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6], [l5s l4s l3s l2s l1s t1s t2s t3s t4s t5s t6s]), 12)); % substitui L5 até L1 e th1 até th6; vpa avalia com 12 casas decimais; double transforma em matriz numérica
 F7 = double(vpa(subs(F7, [L6 L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6 th7], [l6s l5s l4s l3s l2s l1s t1s t2s t3s t4s t5s t6s t7s]), 12)); % substitui L6 até L1 e th1 até th7; vpa calcula com 12 casas decimais; double converte para matriz numérica
 F8 = double(vpa(subs(F8, [L7 L6 L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6 th7], [l7s l6s l5s l4s l3s l2s l1s t1s t2s t3s t4s t5s t6s t7s]), 12)); % substitui L7 até L1 e th1 até th7; vpa avalia com 12 casas decimais; double transforma em matriz numérica

  % ==== Plot ====
 figure(1); clf; % cria e limpa uma janela da figura no plano
 axis equal; % garante que os três eixos tenham a mesma escala para evitar distorções
 grid on; % ativa a grade do gráfico (linhas)
 view(3); % permite a visualização 3D
 xlabel('x'); ylabel('y'); zlabel('z');  %nomeia os eixos
 hold on; % permite adicionar vários gráficos sem apagar os anteriores
 esc = 0.1; % define o fator de escala visual em 0.1
  mark = 5; % define o tamanho dos pontos em 5


  % ---------- Frame {0} ----------
 plot3(F0(1,4), F0(2,4), F0(3,4), 'om', 'linewidth', 2, 'markersize', mark); %plot 3 representa que o frame será em um gráfico de espaço 3D,F0(1,4)=X, F0(2,4)=Y, F0(3,4)=Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> o "o" da o tamanho circular ao ponto e o "m" a cor magenta; 'linemawidth' --> espessura da linha (nesse caso ocupando 2 linhas) 'marksize' --> tamanho do marcador
 plot3([F0(1,4) F0(1,4)+esc*F0(1,1)], [F0(2,4) F0(2,4)+esc*F0(2,1)], [F0(3,4) F0(3,4)+esc*F0(3,1)], 'b','linewidth', 2);  % plot3 com dois pontos em vetor desenha uma linha 3D, o primeiro ponto é a origem do frame 0 (F0(:,4)) e o segundo ponto é a origem deslocada pela 1ª coluna de F0 (direção do eixo X) multiplicada pelo fator esc que controla o comprimento, 'b' define cor azul e 'linewidth' 2 a espessura da linha, logo esse comando desenha o eixo X do frame 0.
 text( F0(1,4)+esc*F0(1,1), F0(2,4)+esc*F0(2,1), F0(3,4)+esc*F0(3,1), 'x_{\{0\}}'); % text insere uma legenda no espaço 3D, aqui nas coordenadas da ponta do eixo X do frame 0, e o texto exibido será 'x_{0}' indicando o rótulo do eixo.
 plot3([F0(1,4) F0(1,4)+esc*F0(1,2)], [F0(2,4) F0(2,4)+esc*F0(2,2)], [F0(3,4) F0(3,4)+esc*F0(3,2)], 'g','linewidth', 2); % desenha uma linha 3D partindo da origem do frame 0 até a ponta do vetor da 2ª coluna de F0 (eixo Y), multiplicado por esc para dar o comprimento, 'g' define cor verde e 'linewidth' 2 a espessura, logo esse comando representa o eixo Y do frame 0.
 text( F0(1,4)+esc*F0(1,2), F0(2,4)+esc*F0(2,2), F0(3,4)+esc*F0(3,2), 'y_{\{0\}}'); % insere o texto 'y_{0}' na ponta do eixo Y do frame 0, nas coordenadas (X,Y,Z) correspondentes ao final da linha desenhada anteriormente.
 plot3([F0(1,4) F0(1,4)+esc*F0(1,3)], [F0(2,4) F0(2,4)+esc*F0(2,3)], [F0(3,4) F0(3,4)+esc*F0(3,3)], 'r','linewidth', 2); % desenha uma linha 3D partindo da origem do frame 0 até a ponta do vetor da 3ª coluna de F0 (eixo Z), multiplicado por esc para controlar o tamanho, 'r' define cor vermelha e 'linewidth' 2 a espessura da linha, logo esse comando representa o eixo Z do frame 0.
 text( F0(1,4)+esc*F0(1,3), F0(2,4)+esc*F0(2,3), F0(3,4)+esc*F0(3,3), 'z_{\{0\}}'); % insere o texto 'z_{0}' na ponta do eixo Z do frame 0, nas coordenadas finais da linha desenhada acima.
 plot3([F0(1,4) F1(1,4)], [F0(2,4) F1(2,4)], [F0(3,4) F1(3,4)], 'k'); % desenha uma linha 3D conectando dois pontos, a origem do frame 0 (F0(:,4)) e a origem do frame 1 (F1(:,4)), 'k' define cor preta, logo esse comando mostra a ligação entre os dois frames.

  % ---------- Frame {1} ----------
 plot3(F1(1,4), F1(2,4), F1(3,4), 'om','linewidth',2,'markersize',mark); text(F1(1,4), F1(2,4), F1(3,4)-0.2, '\{1\}') % plot3 desenha o ponto que representa a origem do frame 1 em um gráfico 3D, suas coordenadas são dadas pela 4ª coluna de F1 (X=F1(1,4), Y=F1(2,4), Z=F1(3,4)), o marcador 'o' define a forma circular, 'm' a cor magenta, 'linewidth' 2 a espessura da borda e 'markersize' mark o tamanho, em seguida o comando text insere a legenda '{1}' logo abaixo do ponto (Z-0.2) para identificar que se trata da origem do frame 1.
 plot3([F1(1,4) F1(1,4)+esc*F1(1,1)], [F1(2,4) F1(2,4)+esc*F1(2,1)], [F1(3,4) F1(3,4)+esc*F1(3,1)],'b','linewidth',2) % desenha uma linha 3D que representa o eixo X do frame 1, o primeiro ponto é a origem do frame (F1(:,4)) e o segundo é a origem deslocada pela 1ª coluna de F1 multiplicada pelo fator esc que define o comprimento do vetor, a cor azul 'b' representa o eixo X e 'linewidth' 2 define a espessura da linha.
 text(F1(1,4)+esc*F1(1,1), F1(2,4)+esc*F1(2,1), F1(3,4)+esc*F1(3,1), 'x_{\{1\}}') % insere o texto 'x_{1}' na ponta da linha azul desenhada anteriormente, ou seja, no final do eixo X do frame 1, para rotular o eixo.
 plot3([F1(1,4) F1(1,4)+esc*F1(1,2)], [F1(2,4) F1(2,4)+esc*F1(2,2)], [F1(3,4) F1(3,4)+esc*F1(3,2)],'g','linewidth',2) % desenha uma linha 3D que representa o eixo Y do frame 1, partindo da origem até a ponta do vetor da 2ª coluna de F1 multiplicado por esc, a cor verde 'g' é usada para indicar o eixo Y e 'linewidth' 2 define a espessura.
 text(F1(1,4)+esc*F1(1,2), F1(2,4)+esc*F1(2,2), F1(3,4)+esc*F1(3,2), 'y_{\{1\}}') % insere o texto 'y_{1}' na ponta da linha verde anterior, ou seja, no final do eixo Y do frame 1.
 plot3([F1(1,4) F1(1,4)+esc*F1(1,3)], [F1(2,4) F1(2,4)+esc*F1(2,3)], [F1(3,4) F1(3,4)+esc*F1(3,3)],'r','linewidth',2) % desenha uma linha 3D que representa o eixo Z do frame 1, partindo da origem até a ponta do vetor da 3ª coluna de F1 multiplicado por esc, a cor vermelha 'r' é usada para o eixo Z e 'linewidth' 2 define a espessura da linha.
 text(F1(1,4)+esc*F1(1,3), F1(2,4)+esc*F1(2,3), F1(3,4)+esc*F1(3,3), 'z_{\{1\}}') % insere o texto 'z_{1}' na ponta da linha vermelha anterior, ou seja, no final do eixo Z do frame 1.
 plot3([F1(1,4) F2(1,4)], [F1(2,4) F2(2,4)], [F1(3,4) F2(3,4)], 'k') % desenha uma linha preta conectando a origem do frame 1 (F1(:,4)) até a origem do frame 2 (F2(:,4)), essa linha preta indica a ligação entre os dois frames consecutivos.

  % ---------- Frame {2} ----------
 plot3(F2(1,4), F2(2,4), F2(3,4), 'om','linewidth',2,'markersize',mark); % plot3 representa que o frame será desenhado em um gráfico 3D; F2(1,4)=X, F2(2,4)=Y, F2(3,4)=Z são as coordenadas do ponto a ser desenhado; 'o' = marcador circular, 'm' = cor magenta; 'linewidth' = espessura da linha (2), 'markersize' = tamanho do marcador definido em mark
 text(F2(1,4), F2(2,4), F2(3,4)-0.2, '\{2\}'); % Insere texto do número do frame logo abaixo do ponto de origem do frame {2}
 plot3([F2(1,4) F2(1,4)+esc*F2(1,1)], [F2(2,4) F2(2,4)+esc*F2(2,1)], [F2(3,4) F2(3,4)+esc*F2(3,1)],'b','linewidth',2); % Desenha eixo X do frame {2} em 3D: origem + vetor coluna 1 de F2 multiplicado por esc; cor azul ('b'), espessura da linha 2
 text(F2(1,4)+esc*F2(1,1), F2(2,4)+esc*F2(2,1), F2(3,4)+esc*F2(3,1), 'x_{\{2\}}'); % Texto indicando eixo X do frame {2} no ponto final da linha azul
 plot3([F2(1,4) F2(1,4)+esc*F2(1,2)], [F2(2,4) F2(2,4)+esc*F2(2,2)], [F2(3,4) F2(3,4)+esc*F2(3,2)],'g','linewidth',2); % Desenha eixo Y do frame {2}: origem + vetor coluna 2 de F2 * esc; cor verde, linha 2
 text(F2(1,4)+esc*F2(1,2), F2(2,4)+esc*F2(2,2), F2(3,4)+esc*F2(3,2), 'y_{\{2\}}'); % Texto indicando eixo Y do frame {2} no ponto final da linha verde
 plot3([F2(1,4) F2(1,4)+esc*F2(1,3)], [F2(2,4) F2(2,4)+esc*F2(2,3)], [F2(3,4) F2(3,4)+esc*F2(3,3)],'r','linewidth',2); % Desenha eixo Z do frame {2}: origem + vetor coluna 3 de F2 * esc; cor vermelha, linha 2
 text(F2(1,4)+esc*F2(1,3), F2(2,4)+esc*F2(2,3), F2(3,4)+esc*F2(3,3), 'z_{\{2\}}'); % Texto indicando eixo Z do frame {2} no ponto final da linha vermelha
 plot3([F2(1,4) F3(1,4)], [F2(2,4) F3(2,4)], [F2(3,4) F3(3,4)], 'k'); % Desenha linha preta conectando a origem do frame {2} à origem do frame {3}

  % ---------- Frame {3} ----------
 plot3(F3(1,4), F3(2,4), F3(3,4), 'om','linewidth',2,'markersize',mark); % Ponto de origem do frame {3}, marcador circular magenta, linha 2, tamanho do marcador mark
 text(F3(1,4), F3(2,4), F3(3,4)-0.2, '\{3\}'); % Texto do número do frame {3} logo abaixo do ponto de origem
 plot3([F3(1,4) F3(1,4)+esc*F3(1,1)], [F3(2,4) F3(2,4)+esc*F3(2,1)], [F3(3,4) F3(3,4)+esc*F3(3,1)],'b','linewidth',2); % Eixo X do frame {3}, linha azul, origem + vetor coluna 1 * esc
 text(F3(1,4)+esc*F3(1,1), F3(2,4)+esc*F3(2,1), F3(3,4)+esc*F3(3,1), 'x_{\{3\}}'); % Texto do eixo X do frame {3}
 plot3([F3(1,4) F3(1,4)+esc*F3(1,2)], [F3(2,4) F3(2,4)+esc*F3(2,2)], [F3(3,4) F3(3,4)+esc*F3(3,2)],'g','linewidth',2); % Eixo Y do frame {3}, linha verde, origem + vetor coluna 2 * esc
 text(F3(1,4)+esc*F3(1,2), F3(2,4)+esc*F3(2,2), F3(3,4)+esc*F3(3,2), 'y_{\{3\}}'); % Texto do eixo Y do frame {3}
 plot3([F3(1,4) F3(1,4)+esc*F3(1,3)], [F3(2,4) F3(2,4)+esc*F3(2,3)], [F3(3,4) F3(3,4)+esc*F3(3,3)],'r','linewidth',2); % Eixo Z do frame {3}, linha vermelha, origem + vetor coluna 3 * esc
 text(F3(1,4)+esc*F3(1,3), F3(2,4)+esc*F3(2,3), F3(3,4)+esc*F3(3,3), 'z_{\{3\}}'); % Texto do eixo Z do frame {3}
 plot3([F3(1,4) F4(1,4)], [F3(2,4) F4(2,4)], [F3(3,4) F4(3,4)], 'k'); % Linha preta conectando a origem do frame {3} à origem do frame {4}

  % ---------- Frame {4} ----------
 plot3(F4(1,4), F4(2,4), F4(3,4), 'om','linewidth',2,'markersize',mark); % Ponto de origem do frame {4}, marcador circular magenta, linha 2, tamanho mark
 text(F4(1,4), F4(2,4), F4(3,4)-0.2, '\{4\}'); % Texto do número do frame {4} logo abaixo do ponto
 plot3([F4(1,4) F4(1,4)+esc*F4(1,1)], [F4(2,4) F4(2,4)+esc*F4(2,1)], [F4(3,4) F4(3,4)+esc*F4(3,1)],'b','linewidth',2); % Eixo X do frame {4}, linha azul, origem + vetor coluna 1 * esc
 text(F4(1,4)+esc*F4(1,1), F4(2,4)+esc*F4(2,1), F4(3,4)+esc*F4(3,1), 'x_{\{4\}}'); % Texto do eixo X do frame {4}
 plot3([F4(1,4) F4(1,4)+esc*F4(1,2)], [F4(2,4) F4(2,4)+esc*F4(2,2)], [F4(3,4) F4(3,4)+esc*F4(3,2)],'g','linewidth',2); % Eixo Y do frame {4}, linha verde, origem + vetor coluna 2 * esc
 text(F4(1,4)+esc*F4(1,2), F4(2,4)+esc*F4(2,2), F4(3,4)+esc*F4(3,2), 'y_{\{4\}}'); % Texto do eixo Y do frame {4}
 plot3([F4(1,4) F4(1,4)+esc*F4(1,3)], [F4(2,4) F4(2,4)+esc*F4(2,3)], [F4(3,4) F4(3,4)+esc*F4(3,3)],'r','linewidth',2); % Eixo Z do frame {4}, linha vermelha, origem + vetor coluna 3 * esc
 text(F4(1,4)+esc*F4(1,3), F4(2,4)+esc*F4(2,3), F4(3,4)+esc*F4(3,3), 'z_{\{4\}}'); % Texto do eixo Z do frame {4}
 plot3([F4(1,4) F5(1,4)], [F4(2,4) F5(2,4)], [F4(3,4) F5(3,4)], 'k'); % Linha preta conectando a origem do frame {4} à origem do frame {5}

  % ---------- Frame {5} ----------
 plot3(F5(1,4), F5(2,4), F5(3,4), 'om','linewidth',2,'markersize',mark); % Ponto de origem do frame {5}, marcador circular magenta, linha 2, tamanho mark
 text(F5(1,4), F5(2,4), F5(3,4)-0.2, '\{5\}'); % Texto do número do frame {5} abaixo do ponto
 plot3([F5(1,4) F5(1,4)+esc*F5(1,1)], [F5(2,4) F5(2,4)+esc*F5(2,1)], [F5(3,4) F5(3,4)+esc*F5(3,1)],'b','linewidth',2); % Eixo X do frame {5}, linha azul, origem + vetor coluna 1 * esc
 text(F5(1,4)+esc*F5(1,1), F5(2,4)+esc*F5(2,1), F5(3,4)+esc*F5(3,1), 'x_{\{5\}}'); % Texto eixo X do frame {5}
 plot3([F5(1,4) F5(1,4)+esc*F5(1,2)], [F5(2,4) F5(2,4)+esc*F5(2,2)], [F5(3,4) F5(3,4)+esc*F5(3,2)],'g','linewidth',2); % Eixo Y do frame {5}, linha verde, origem + vetor coluna 2 * esc
 text(F5(1,4)+esc*F5(1,2), F5(2,4)+esc*F5(2,2), F5(3,4)+esc*F5(3,2), 'y_{\{5\}}'); % Texto eixo Y do frame {5}
 plot3([F5(1,4) F5(1,4)+esc*F5(1,3)], [F5(2,4) F5(2,4)+esc*F5(2,3)], [F5(3,4) F5(3,4)+esc*F5(3,3)],'r','linewidth',2); % Eixo Z do frame {5}, linha vermelha, origem + vetor coluna 3 * esc
 text(F5(1,4)+esc*F5(1,3), F5(2,4)+esc*F5(2,3), F5(3,4)+esc*F5(3,3), 'z_{\{5\}}'); % Texto eixo Z do frame {5}
 plot3([F5(1,4) F6(1,4)], [F5(2,4) F6(2,4)], [F5(3,4) F6(3,4)], 'k'); % Linha preta conectando a origem do frame {5} à origem do frame {6}

  % ---------- Frame {6} ----------
 plot3(F6(1,4), F6(2,4), F6(3,4), 'om','linewidth',2,'markersize',mark); % Ponto de origem do frame {6}, marcador circular magenta, linha 2, tamanho mark
 text(F6(1,4), F6(2,4), F6(3,4)-0.2, '\{6\}'); % Texto do número do frame {6} abaixo do ponto
 plot3([F6(1,4) F6(1,4)+esc*F6(1,1)], [F6(2,4) F6(2,4)+esc*F6(2,1)], [F6(3,4) F6(3,4)+esc*F6(3,1)],'b','linewidth',2); % Eixo X do frame {6}, linha azul, origem + vetor coluna 1 * esc
 text(F6(1,4)+esc*F6(1,1), F6(2,4)+esc*F6(2,1), F6(3,4)+esc*F6(3,1), 'x_{\{6\}}'); % Texto eixo X do frame {6}
 plot3([F6(1,4) F6(1,4)+esc*F6(1,2)], [F6(2,4) F6(2,4)+esc*F6(2,2)], [F6(3,4) F6(3,4)+esc*F6(3,2)],'g','linewidth',2); % Eixo Y do frame {6}, linha verde, origem + vetor coluna 2 * esc
 text(F6(1,4)+esc*F6(1,2), F6(2,4)+esc*F6(2,2), F6(3,4)+esc*F6(3,2), 'y_{\{6\}}'); % Texto eixo Y do frame {6}
 plot3([F6(1,4) F6(1,4)+esc*F6(1,3)], [F6(2,4) F6(2,4)+esc*F6(2,3)], [F6(3,4) F6(3,4)+esc*F6(3,3)],'r','linewidth',2); % Eixo Z do frame {6}, linha vermelha, origem + vetor coluna 3 * esc
 text(F6(1,4)+esc*F6(1,3), F6(2,4)+esc*F6(2,3), F6(3,4)+esc*F6(3,3), 'z_{\{6\}}'); % Texto eixo Z do frame {6}
 plot3([F6(1,4) F7(1,4)], [F6(2,4) F7(2,4)], [F6(3,4) F7(3,4)], 'k'); % Linha preta conectando a origem do frame {6} à origem do frame {7}

  % ---------- Frame {7} ----------
 plot3(F7(1,4), F7(2,4), F7(3,4), 'om','linewidth',2,'markersize',mark); % Ponto de origem do frame {7}, marcador circular magenta, linha 2, tamanho mark
 text(F7(1,4), F7(2,4), F7(3,4)-0.2, '\{7\}'); % Texto do número do frame {7} abaixo do ponto
 plot3([F7(1,4) F7(1,4)+esc*F7(1,1)], [F7(2,4) F7(2,4)+esc*F7(2,1)], [F7(3,4) F7(3,4)+esc*F7(3,1)],'b','linewidth',2); % Eixo X do frame {7}, linha azul, origem + vetor coluna 1 * esc
 text(F7(1,4)+esc*F7(1,1), F7(2,4)+esc*F7(2,1), F7(3,4)+esc*F7(3,1), 'x_{\{7\}}'); % Texto eixo X do frame {7}
 plot3([F7(1,4) F7(1,4)+esc*F7(1,2)], [F7(2,4) F7(2,4)+esc*F7(2,2)], [F7(3,4) F7(3,4)+esc*F7(3,2)],'g','linewidth',2); % Eixo Y do frame {7}, linha verde, origem + vetor coluna 2 * esc
 text(F7(1,4)+esc*F7(1,2), F7(2,4)+esc*F7(2,2), F7(3,4)+esc*F7(3,2), 'y_{\{7\}}'); % Texto eixo Y do frame {7}
 plot3([F7(1,4) F7(1,4)+esc*F7(1,3)], [F7(2,4) F7(2,4)+esc*F7(2,3)], [F7(3,4) F7(3,4)+esc*F7(3,3)],'r','linewidth',2); % Eixo Z do frame {7}, linha vermelha, origem + vetor coluna 3 * esc
 text(F7(1,4)+esc*F7(1,3), F7(2,4)+esc*F7(2,3), F7(3,4)+esc*F7(3,3), 'z_{\{7\}}'); % Texto eixo Z do frame {7}
 plot3([F7(1,4) F8(1,4)], [F7(2,4) F8(2,4)], [F7(3,4) F8(3,4)], 'k'); % Linha preta conectando a origem do frame {7} à origem do frame {8}

  % ---------- Frame {8} ----------
 plot3(F8(1,4), F8(2,4), F8(3,4), 'om','linewidth',2,'markersize',mark); % Ponto de origem do frame {8}, marcador circular magenta, linha 2, tamanho mark
 text(F8(1,4), F8(2,4), F8(3,4)-0.2, '\{8\}'); % Texto do número do frame {8} abaixo do ponto
 plot3([F8(1,4) F8(1,4)+esc*F8(1,1)], [F8(2,4) F8(2,4)+esc*F8(2,1)], [F8(3,4) F8(3,4)+esc*F8(3,1)],'b','linewidth',2); % Eixo X do frame {8}, linha azul, origem + vetor coluna 1 * esc
 text(F8(1,4)+esc*F8(1,1), F8(2,4)+esc*F8(2,1), F8(3,4)+esc*F8(3,1), 'x_{\{8\}}'); % Texto eixo X do frame {8}
 plot3([F8(1,4) F8(1,4)+esc*F8(1,2)], [F8(2,4) F8(2,4)+esc*F8(2,2)], [F8(3,4) F8(3,4)+esc*F8(3,2)],'g','linewidth',2); % Eixo Y do frame {8}, linha verde, origem + vetor coluna 2 * esc
 text(F8(1,4)+esc*F8(1,2), F8(2,4)+esc*F8(2,2), F8(3,4)+esc*F8(3,2), 'y_{\{8\}}'); % Texto eixo Y do frame {8}
 plot3([F8(1,4) F8(1,4)+esc*F8(1,3)], [F8(2,4) F8(2,4)+esc*F8(2,3)], [F8(3,4) F8(3,4)+esc*F8(3,3)],'r','linewidth',2); % Eixo Z do frame {8}, linha vermelha, origem + vetor coluna 3 * esc
 text(F8(1,4)+esc*F8(1,3), F8(2,4)+esc*F8(2,3), F8(3,4)+esc*F8(3,3), 'z_{\{8\}}'); % Texto eixo Z do frame {8}





