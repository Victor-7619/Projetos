clear;                % remove todas as váriaveis
close all;            % limpa a janela de comandos
clc                   % fecha todas as figuras gráficas abertas

## Pacote simbólico   % biblioteca com variáveis
pkg load symbolic     % carregar as funções do pacote


% -------Simbólico base------
syms th dx dy dz L1 L2 L3 L4 L5 L6 L7 real         % declarar variáveis simbólicas
syms th1 th2 th3 th4 th5 th6 th7 real              % variáveis genéricas, ângulos das juntas

one = sym(1); zero = sym(0)                        % declaração de duas variáveis simbólicas (0 & 1)
deg2rad_sym = @(d) sym(d) * sym(pi) / sym(180)     % usada para converter ângulos

T = [ one zero zero dx
      zero one zero dy
      zero zero one dz
      zero zero zero one ]                         % definição da matriz de translação nos eixos x,y,z

Rx = [ one zero zero zero
       zero cos(th) -sin(th) zero
       zero sym(th) cos(th) zero
       zero zero zero one ]                        % define a matriz de tranformação homegênea, em que irá rotacionar em torno do eixo x

Rz = [ cos(th) -sin(th) zero zero
       sin(th) cos(th) zero zero
       zero zero one zero
       zero zero zero one ]                        % define a matriz de tranformação homegênea, em que irá rotacionar em torno do eixo z

F0 = sym(eye(4))                                   % criação de matriz identidade 4x4 e conversão para símbolos matemáticos


% --------- Cadeia de frames (100% simbólica) ---------
Tr_0_1 = subs(T, [dx dy dz], [zero zero zero]);                        % Define a matriz de translação de {0} para {1} como nula, pois a junta 1 apenas rotaciona na base.
TH_0_1 = Tr_0_1 * subs(Rz, th, th1);                                   % Cria a matriz de transformação completa de {0} para {1}, aplicando a rotação da junta th1 em torno do eixo Z.
F1 = F0 * TH_0_1;                                                      % Calcula a matriz de pose final do frame {1} em relação ao referencial da base {0}.

pi2= sym(pi)/2;                                                        % declarando pi2 / pi2=3,14/2, como valor simbólico

Tr_1_2 = subs(T, [dx dy dz],[zero zero L1]) * subs(Rx, th, -pi2);      % o Tr_1_2 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero zero e l1, pela a substituição de th por pi2 de Rx
TH_1_2 = Tr_1_2 * subs(Rz, th, th2);                                   % TH_1_2 será igual a translação de 1 a 2 multiplicado pela substituição do th por th2 de rz
F2 = F1*TH_1_2;                                                        % Frame 2 será o Frame 1 multiplicado pelo TH_1_2

% em resumo, do frame 1 para o frame 2, o robô irá transladar l1 unidades no eixo Z, rotacionar 90 graus em torno do eixo x e rotacionar th2 radianos ou graus em torno do eixo z

Tr_2_3 = subs(T, [dx dy dz],[zero L2 zero]) * subs(Rx, th, -pi2);      % o Tr_2_3 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero l2 e zero, pela a substituição de th por -pi2 de Rx
TH_2_3 = Tr_2_3 * subs (Rz, th, th3);                                  % TH_1_2 será igual a translação de 2 a 3 multiplicado pela substituição do th por th3 de rz
F3= F2* TH_2_3;                                                        % Frame 3 será o Frame 2 multiplicado pelo TH_2_3

% em resumo, do frame 2 para o frame 3, o robô irá transladar l2 unidades no eixo y, rotacionar -90 graus em torno do eixo x e rotacionar th3 radianos ou graus em torno do eixo z

Tr_3_4 =  subs(T, [dx dy dz], [zero zero L3]) * subs(Rx, th, pi2);     % o Tr_3_4 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero zero e l3, pela a substituição de th por pi2 de Rx
TH_3_4 = Tr_3_4 * subs(Rz, th, th4);                                   % TH_3_4 será igual a translação de 3 a 4 multiplicado pela substituição do th por th4 de rz
F4 = F3 * TH_3_4;                                                      % Frame 4 será o Frame 3 multiplicado pelo TH_3_4

% em resumo, do frame 3 para o frame 4, o robô irá transladar l3 unidades no eixo Z, rotacionar 90 graus em torno do eixo x e rotacionar th4 radianos ou graus em torno do eixo z

Tr_4_5 = subs(T, [dx dy dz], [zero L4 zero]) * subs(Rx, th, -pi2);     % o Tr_4_5 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero l4 e zero, pela a substituição de th por -pi2 de Rx
TH_4_5 = Tr_4_5 * subs(Rz, th, th5);                                   % TH_4_5 será igual a translação de 4 a 5 multiplicado pela substituição do th por th5 de rz
F5 = F4 * TH_4_5;                                                      % Frame 5 será o Frame 4 multiplicado pelo TH_4_5

% em resumo, do frame 4 para o frame 5, o robô irá transladar l4 unidades no eixo y, rotacionar -90 graus em torno do eixo x e rotacionar th5 radianos ou graus em torno do eixo z

Tr_5_6 = subs(T, [dx dy dz], [zero zero L5]) * subs(Rx, th, pi2);      % o Tr_5_6 será igual a multiplicação da substituição de dx, dy e dz da matriz de transição por zero zero e l5, pela a substituição de th por pi2 de Rx
TH_5_6 = Tr_5_6 * subs(Rz, th, th6);                                   % TH_5_6 será igual a translação de 5 a 6 multiplicado pela substituição do th por th6 de rz
F6 = F5 * TH_5_6;                                                      % Frame 6 será o Frame 5 multiplicado pelo TH_5_6

% em resumo, do frame 5 para o frame 6, o robô irá transladar l5 unidades no eixo Z, rotacionar 90 graus em torno do eixo x e rotacionar th6 radianos ou graus em torno do eixo z

Tr_6_7 = subs(T, [dx dy dz], [zero L6 zero]) * subs(Rx, th, -pi2);     % o Tr_6_7 será igual a substituição de dx, dy e dz da matriz de transição por zero zero e l7, sem rotação
TH_6_7 = Tr_6_7 * subs(Rz, th, th7);                                   % TH_6_7 será igual a translação de 5 a 6 multiplicado pela substituição do th por th7 de rz
F7 = F6 * TH_6_7;                                                      % Frame 7 será o Frame 6 multiplicado pelo Tr_6_7

% em resumo, do frame 6 para o 7, o robô translada L6 no eixo Y, rotaciona -90 graus no eixo X e rotaciona th7 no eixo Z.


% --------- Parâmetros numéricos ---------

% comprimentos (strings -> simbólico)
l1s = sym('0.220');   % Valor correspondente a 220 mm
l2s = sym('0.118');   % Valor correspondente a 118 mm
l3s = sym('0.200');   % Valor correspondente a 200 mm
l4s = sym('0.0865');  % Valor correspondente a 86.5 mm
l5s = sym('0.160');   % Valor correspondente a 160 mm
l6s = sym('0.0917');  % Valor correspondente a 91.7 mm
l7s = sym('0.0');     % Distância da última junta à ponta (zero)

% ângulos em rad (simbólicos)
t1s = deg2rad_sym(0);
t2s = deg2rad_sym(0);
t3s = deg2rad_sym(0);
t4s = deg2rad_sym(0);
t5s = deg2rad_sym(0);
t6s = deg2rad_sym(0);
t7s = deg2rad_sym(45); %  % Pose com todos os ângulos zerados


% --------- Substituições -> vpa -> double ---------
F0 = eye(4);                                                                                                                            % criação de matriz identidade 4x4 (ponto de origem frame 0)
F1 = double(vpa(subs(F1, th1, t1s), 12));                                                                                               % subs é executado primeiro, substituindo th1 por t1s. Depois vem o vpa que transforma o decimal do resultado de subs e o resume a 12 casas decimais e o double transforma em matriz numérica
F2 = double(vpa(subs(F2, [L1 th1 th2], [l1s t1s t2s]), 12));                                                                            % substitui L1, th1 e th2 por seus respectivos valores; vpa reduz a 12 casas decimais; double transforma em matriz numérica
F3 = double(vpa(subs(F3, [L2 L1 th1 th2 th3], [l2s l1s t1s t2s t3s]), 12));                                                             % substitui L2, L1, th1, th2 e th3; vpa avalia com 12 dígitos; double converte para matriz numérica
F4 = double(vpa(subs(F4, [L3 L2 L1 th1 th2 th3 th4], [l3s l2s l1s t1s t2s t3s t4s]), 12));                                              % substitui L3 até L1 e th1 até th4; vpa reduz a 12 casas; double gera matriz numérica
F5 = double(vpa(subs(F5, [L4 L3 L2 L1 th1 th2 th3 th4 th5], [l4s l3s l2s l1s t1s t2s t3s t4s t5s]), 12));                               % substitui L4 até L1 e th1 até th5; vpa e double finalizam como antes
F6 = double(vpa(subs(F6, [L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6], [l5s l4s l3s l2s l1s t1s t2s t3s t4s t5s t6s]), 12));                % substitui L5 até L1 e th1 até th6; vpa avalia com 12 casas decimais; double transforma em matriz numérica
F7 = double(vpa(subs(F7, [L6 L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6 th7], [l6s l5s l4s l3s l2s l1s t1s t2s t3s t4s t5s t6s t7s]), 12)); % substitui L6 até L1 e th1 até th7; vpa calcula com 12 casas decimais; double converte para matriz numérica


% ==== Plot ====
figure(1); clf; % cria e limpa uma janela da figura no plano
axis equal;     % garante que os três eixos tenham a mesma escala para evitar distorções
grid on;        % ativa a grade do gráfico (linhas)
view(3);        % permite a visualização 3D
xlabel('x'); ylabel('y'); zlabel('z'); % nomeia os eixos
hold on;        % permite adicionar vários gráficos sem apagar os anteriores
esc = 0.1;      % define o fator de escala visual em 0.1
mark = 5;       % define o tamanho dos pontos em 5

% ---------- Frame {0} ----------
plot3(F0(1,4), F0(2,4), F0(3,4), 'om', 'linewidth', 2, 'markersize', mark);                                              % plot 3, pois o gráfico será em espaço 3D,F0(1,4) X, F0(2,4) Y, F0(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
plot3([F0(1,4) F0(1,4)+esc*F0(1,1)], [F0(2,4) F0(2,4)+esc*F0(2,1)], [F0(3,4) F0(3,4)+esc*F0(3,1)], 'b', 'linewidth', 2); % Desenha linha 3D da origem de F0 ao ponto final (origem + vetor da 1ª coluna de F0 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text( F0(1,4)+esc*F0(1,1), F0(2,4)+esc*F0(2,1), F0(3,4)+esc*F0(3,1), 'x_{\{0\}}');                                       % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{0}' é o texto que será exibido.
plot3([F0(1,4) F0(1,4)+esc*F0(1,2)], [F0(2,4) F0(2,4)+esc*F0(2,2)], [F0(3,4) F0(3,4)+esc*F0(3,2)], 'g', 'linewidth', 2); % Desenha linha 3D da origem de F0 ao ponto final (origem + vetor da 2ª coluna de F0 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text( F0(1,4)+esc*F0(1,2), F0(2,4)+esc*F0(2,2), F0(3,4)+esc*F0(3,2), 'y_{\{0\}}');                                       % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{0}' é o texto que será exibido.
plot3([F0(1,4) F0(1,4)+esc*F0(1,3)], [F0(2,4) F0(2,4)+esc*F0(2,3)], [F0(3,4) F0(3,4)+esc*F0(3,3)], 'r', 'linewidth', 2); % Desenha linha 3D da origem de F0 ao ponto final (origem + vetor da 3ª coluna de F0 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text( F0(1,4)+esc*F0(1,3), F0(2,4)+esc*F0(2,3), F0(3,4)+esc*F0(3,3), 'z_{\{0\}}');                                       % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{0}' é o texto que será exibido.
plot3([F0(1,4) F1(1,4)], [F0(2,4) F1(2,4)], [F0(3,4) F1(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F0 (linhas 1-3, col 4) e a origem de F1 (linhas 1-3, col 4); 'k' = cor preta.

% ---------- Frame {1} ----------
plot3(F1(1,4), F1(2,4), F1(3,4), 'om','linewidth',2,'markersize',mark);                                                  % plot 3, pois o gráfico será em espaço 3D,F1(1,4) X, F1(2,4) Y, F1(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
text(F1(1,4), F1(2,4), F1(3,4)-0.2, '\{1\}');                                                                            % Insere texto na posição X,Y,Z um pouco abaixo da origem de F1 (Z-0.2); '\{1\}' é o texto que será exibido.
plot3([F1(1,4) F1(1,4)+esc*F1(1,1)], [F1(2,4) F1(2,4)+esc*F1(2,1)], [F1(3,4) F1(3,4)+esc*F1(3,1)], 'b','linewidth',2);   % Desenha linha 3D da origem de F1 ao ponto final (origem + vetor da 1ª coluna de F1 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text(F1(1,4)+esc*F1(1,1), F1(2,4)+esc*F1(2,1), F1(3,4)+esc*F1(3,1), 'x_{\{1\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{1}' é o texto que será exibido.
plot3([F1(1,4) F1(1,4)+esc*F1(1,2)], [F1(2,4) F1(2,4)+esc*F1(2,2)], [F1(3,4) F1(3,4)+esc*F1(3,2)], 'g','linewidth',2);   % Desenha linha 3D da origem de F1 ao ponto final (origem + vetor da 2ª coluna de F1 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text(F1(1,4)+esc*F1(1,2), F1(2,4)+esc*F1(2,2), F1(3,4)+esc*F1(3,2), 'y_{\{1\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{1}' é o texto que será exibido.
plot3([F1(1,4) F1(1,4)+esc*F1(1,3)], [F1(2,4) F1(2,4)+esc*F1(2,3)], [F1(3,4) F1(3,4)+esc*F1(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F1 ao ponto final (origem + vetor da 3ª coluna de F1 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F1(1,4)+esc*F1(1,3), F1(2,4)+esc*F1(2,3), F1(3,4)+esc*F1(3,3), 'z_{\{1\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{1}' é o texto que será exibido.
plot3([F1(1,4) F2(1,4)], [F1(2,4) F2(2,4)], [F1(3,4) F2(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F1 (linhas 1-3, col 4) e a origem de F2 (linhas 1-3, col 4); 'k' = cor preta.

% ---------- Frame {2} ----------
plot3(F2(1,4), F2(2,4), F2(3,4), 'om','linewidth',2,'markersize',mark);                                                  % plot 3, pois o gráfico será em espaço 3D,F2(1,4) X, F2(2,4) Y, F2(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
text(F2(1,4), F2(2,4), F2(3,4)-0.2, '\{2\}');                                                                            % Insere texto na posição X,Y,Z um pouco abaixo da origem de F2 (Z-0.2); '{2}' é o texto que será exibido.
plot3([F2(1,4) F2(1,4)+esc*F2(1,1)], [F2(2,4) F2(2,4)+esc*F2(2,1)], [F2(3,4) F2(3,4)+esc*F2(3,1)], 'b','linewidth',2);   % Desenha linha 3D da origem de F2 ao ponto final (origem + vetor da 1ª coluna de F2 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text(F2(1,4)+esc*F2(1,1), F2(2,4)+esc*F2(2,1), F2(3,4)+esc*F2(3,1), 'x_{\{2\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{2}' é o texto que será exibido.
plot3([F2(1,4) F2(1,4)+esc*F2(1,2)], [F2(2,4) F2(2,4)+esc*F2(2,2)], [F2(3,4) F2(3,4)+esc*F2(3,2)], 'g','linewidth',2);   % Desenha linha 3D da origem de F2 ao ponto final (origem + vetor da 2ª coluna de F2 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text(F2(1,4)+esc*F2(1,2), F2(2,4)+esc*F2(2,2), F2(3,4)+esc*F2(3,2), 'y_{\{2\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{2}' é o texto que será exibido.
plot3([F2(1,4) F2(1,4)+esc*F2(1,3)], [F2(2,4) F2(2,4)+esc*F2(2,3)], [F2(3,4) F2(3,4)+esc*F2(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F2 ao ponto final (origem + vetor da 3ª coluna de F2 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F2(1,4)+esc*F2(1,3), F2(2,4)+esc*F2(2,3), F2(3,4)+esc*F2(3,3), 'z_{\{2\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{2}' é o texto que será exibido.
plot3([F2(1,4) F3(1,4)], [F2(2,4) F3(2,4)], [F2(3,4) F3(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F2 (linhas 1-3, col 4) e a origem de F3 (linhas 1-3, col 4); 'k' = cor preta.

% ---------- Frame {3} ----------
plot3(F3(1,4), F3(2,4), F3(3,4), 'om','linewidth',2,'markersize',mark);                                                  %plot 3, pois o gráfico será em espaço 3D,F3(1,4) X, F3(2,4) Y, F3(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
text(F3(1,4), F3(2,4), F3(3,4)-0.2, '\{3\}');                                                                            % Insere texto na posição X,Y,Z um pouco abaixo da origem de F3 (Z-0.2); '{3}' é o texto que será exibido.
plot3([F3(1,4) F3(1,4)+esc*F3(1,1)], [F3(2,4) F3(2,4)+esc*F3(2,1)], [F3(3,4) F3(3,4)+esc*F3(3,1)], 'b','linewidth',2);   % Desenha linha 3D da origem de F3 ao ponto final (origem + vetor da 1ª coluna de F3 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text(F3(1,4)+esc*F3(1,1), F3(2,4)+esc*F3(2,1), F3(3,4)+esc*F3(3,1), 'x_{\{3\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{3}' é o texto que será exibido.
plot3([F3(1,4) F3(1,4)+esc*F3(1,2)], [F3(2,4) F3(2,4)+esc*F3(2,2)], [F3(3,4) F3(3,4)+esc*F3(3,2)], 'g','linewidth',2);   % Desenha linha 3D da origem de F3 ao ponto final (origem + vetor da 2ª coluna de F3 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text(F3(1,4)+esc*F3(1,2), F3(2,4)+esc*F3(2,2), F3(3,4)+esc*F3(3,2), 'y_{\{3\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{3}' é o texto que será exibido.
plot3([F3(1,4) F3(1,4)+esc*F3(1,3)], [F3(2,4) F3(2,4)+esc*F3(2,3)], [F3(3,4) F3(3,4)+esc*F3(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F3 ao ponto final (origem + vetor da 3ª coluna de F3 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F3(1,4)+esc*F3(1,3), F3(2,4)+esc*F3(2,3), F3(3,4)+esc*F3(3,3), 'z_{\{3\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{3}' é o texto que será exibido.
plot3([F3(1,4) F4(1,4)], [F3(2,4) F4(2,4)], [F3(3,4) F4(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F3 (linhas 1-3, col 4) e a origem de F4 (linhas 1-3, col 4); 'k' = cor preta.

% ---------- Frame {4} ----------
plot3(F4(1,4), F4(2,4), F4(3,4), 'om','linewidth',2,'markersize',mark);                                                  % plot 3, pois o gráfico será em espaço 3D,F4(1,4) X, F4(2,4) Y, F4(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
text(F4(1,4), F4(2,4), F4(3,4)-0.2, '\{4\}');                                                                            % Insere texto na posição X,Y,Z um pouco abaixo da origem de F4 (Z-0.2); '{4}' é o texto que será exibido.
plot3([F4(1,4) F4(1,4)+esc*F4(1,1)], [F4(2,4) F4(2,4)+esc*F4(2,1)], [F4(3,4) F4(3,4)+esc*F4(3,1)], 'b','linewidth',2);   % Desenha linha 3D da origem de F4 ao ponto final (origem + vetor da 1ª coluna de F4 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text(F4(1,4)+esc*F4(1,1), F4(2,4)+esc*F4(2,1), F4(3,4)+esc*F4(3,1), 'x_{\{4\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{4}' é o texto que será exibido.
plot3([F4(1,4) F4(1,4)+esc*F4(1,2)], [F4(2,4) F4(2,4)+esc*F4(2,2)], [F4(3,4) F4(3,4)+esc*F4(3,2)], 'g','linewidth',2);   % Desenha linha 3D da origem de F4 ao ponto final (origem + vetor da 2ª coluna de F4 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text(F4(1,4)+esc*F4(1,2), F4(2,4)+esc*F4(2,2), F4(3,4)+esc*F4(3,2), 'y_{\{4\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{4}' é o texto que será exibido.
plot3([F4(1,4) F4(1,4)+esc*F4(1,3)], [F4(2,4) F4(2,4)+esc*F4(2,3)], [F4(3,4) F4(3,4)+esc*F4(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F4 ao ponto final (origem + vetor da 3ª coluna de F4 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F4(1,4)+esc*F4(1,3), F4(2,4)+esc*F4(2,3), F4(3,4)+esc*F4(3,3), 'z_{\{4\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{4}' é o texto que será exibido.
plot3([F4(1,4) F5(1,4)], [F4(2,4) F5(2,4)], [F4(3,4) F5(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F4 (linhas 1-3, col 4) e a origem de F5 (linhas 1-3, col 4); 'k' = cor preta.

% ---------- Frame {5} ----------
plot3(F5(1,4), F5(2,4), F5(3,4), 'om','linewidth',2,'markersize',mark);                                                  % plot 3, pois o gráfico será em espaço 3D,F5(1,4) X, F5(2,4) Y, F5(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
text(F5(1,4), F5(2,4), F5(3,4)-0.2, '\{5\}');                                                                            % Insere texto na posição X,Y,Z um pouco abaixo da origem de F5 (Z-0.2); '{5}' é o texto que será exibido.
plot3([F5(1,4) F5(1,4)+esc*F5(1,1)], [F5(2,4) F5(2,4)+esc*F5(2,1)], [F5(3,4) F5(3,4)+esc*F5(3,1)],'b','linewidth',2);    % Desenha linha 3D da origem de F5 ao ponto final (origem + vetor da 1ª coluna de F5 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text(F5(1,4)+esc*F5(1,1), F5(2,4)+esc*F5(2,1), F5(3,4)+esc*F5(3,1), 'x_{\{5\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{5}' é o texto que será exibido.
plot3([F5(1,4) F5(1,4)+esc*F5(1,2)], [F5(2,4) F5(2,4)+esc*F5(2,2)], [F5(3,4) F5(3,4)+esc*F5(3,2)], 'g','linewidth',2);   % Desenha linha 3D da origem de F5 ao ponto final (origem + vetor da 2ª coluna de F5 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text(F5(1,4)+esc*F5(1,2), F5(2,4)+esc*F5(2,2), F5(3,4)+esc*F5(3,2), 'y_{\{5\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{5}' é o texto que será exibido.
plot3([F5(1,4) F5(1,4)+esc*F5(1,3)], [F5(2,4) F5(2,4)+esc*F5(2,3)], [F5(3,4) F5(3,4)+esc*F5(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F5 ao ponto final (origem + vetor da 3ª coluna de F5 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F5(1,4)+esc*F5(1,3), F5(2,4)+esc*F5(2,3), F5(3,4)+esc*F5(3,3), 'z_{\{5\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{5}' é o texto que será exibido.
plot3([F5(1,4) F6(1,4)], [F5(2,4) F6(2,4)], [F5(3,4) F6(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F5 (linhas 1-3, col 4) e a origem de F6 (linhas 1-3, col 4); 'k' = cor preta.

% ---------- Frame {6} ----------
plot3(F6(1,4), F6(2,4), F6(3,4), 'om','linewidth',2,'markersize',mark);                                                  % plot 3, pois o gráfico será em espaço 3D,F6(1,4) X, F6(2,4) Y, F6(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
text(F6(1,4), F6(2,4), F6(3,4)-0.2, '\{6\}');                                                                            % Insere texto na posição X,Y,Z um pouco abaixo da origem de F6 (Z-0.2); '{6}' é o texto que será exibido.
plot3([F6(1,4) F6(1,4)+esc*F6(1,1)], [F6(2,4) F6(2,4)+esc*F6(2,1)], [F6(3,4) F6(3,4)+esc*F6(3,1)], 'b','linewidth',2);   % Desenha linha 3D da origem de F6 ao ponto final (origem + vetor da 1ª coluna de F6 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text(F6(1,4)+esc*F6(1,1), F6(2,4)+esc*F6(2,1), F6(3,4)+esc*F6(3,1), 'x_{\{6\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{6}' é o texto que será exibido.
plot3([F6(1,4) F6(1,4)+esc*F6(1,2)], [F6(2,4) F6(2,4)+esc*F6(2,2)], [F6(3,4) F6(3,4)+esc*F6(3,2)], 'g','linewidth',2);   % Desenha linha 3D da origem de F6 ao ponto final (origem + vetor da 2ª coluna de F6 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text(F6(1,4)+esc*F6(1,2), F6(2,4)+esc*F6(2,2), F6(3,4)+esc*F6(3,2), 'y_{\{6\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{6}' é o texto que será exibido.
plot3([F6(1,4) F6(1,4)+esc*F6(1,3)], [F6(2,4) F6(2,4)+esc*F6(2,3)], [F6(3,4) F6(3,4)+esc*F6(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F6 ao ponto final (origem + vetor da 3ª coluna de F6 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F6(1,4)+esc*F6(1,3), F6(2,4)+esc*F6(2,3), F6(3,4)+esc*F6(3,3), 'z_{\{6\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{6}' é o texto que será exibido.
plot3([F6(1,4) F7(1,4)], [F6(2,4) F7(2,4)], [F6(3,4) F7(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F6 (linhas 1-3, col 4) e a origem de F7 (linhas 1-3, col 4); 'k' = cor preta.
text(F6(1,4)+esc*F6(1,2), F6(2,4)+esc*F6(2,2), F6(3,4)+esc*F6(3,2), 'y_{\{6\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{6}' é o texto que será exibido.
plot3([F6(1,4) F6(1,4)+esc*F6(1,3)], [F6(2,4) F6(2,4)+esc*F6(2,3)], [F6(3,4) F6(3,4)+esc*F6(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F6 ao ponto final (origem + vetor da 3ª coluna de F6 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F6(1,4)+esc*F6(1,3), F6(2,4)+esc*F6(2,3), F6(3,4)+esc*F6(3,3), 'z_{\{6\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{6}' é o texto que será exibido.
plot3([F6(1,4) F7(1,4)], [F6(2,4) F7(2,4)], [F6(3,4) F7(3,4)], 'k');                                                     % Desenha uma linha 3D conectando dois pontos: a origem de F6 (linhas 1-3, col 4) e a origem de F7 (linhas 1-3, col 4); 'k' = cor preta.

% ---------- Frame {7} ----------
plot3(F7(1,4), F7(2,4), F7(3,4), 'om','linewidth',2,'markersize',mark);                                                  % plot 3, pois o gráfico será em espaço 3D,F7(1,4) X, F7(2,4) Y, F7(3,4) Z , são coordenadas do ponto a ser desenhado, dos comandos em "roxo", 'om'--> especificador de estilo do ponto 'linemawidth' --> espessura da linha 'marksize' --> tamanho do marcador
text(F7(1,4), F7(2,4), F7(3,4)-0.2, '\{7\}');                                                                            % Insere texto na posição X,Y,Z um pouco abaixo da origem de F7 (Z-0.2); '{7}' é o texto que será exibido.
plot3([F7(1,4) F7(1,4)+esc*F7(1,1)], [F7(2,4) F7(2,4)+esc*F7(2,1)], [F7(3,4) F7(3,4)+esc*F7(3,1)], 'b','linewidth',2);   % Desenha linha 3D da origem de F7 ao ponto final (origem + vetor da 1ª coluna de F7 * esc); 'b' = cor azul; 'linewidth' 2 = espessura da linha.
text(F7(1,4)+esc*F7(1,1), F7(2,4)+esc*F7(2,1), F7(3,4)+esc*F7(3,1), 'x_{\{7\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo X); 'x_{7}' é o texto que será exibido.
plot3([F7(1,4) F7(1,4)+esc*F7(1,2)], [F7(2,4) F7(2,4)+esc*F7(2,2)], [F7(3,4) F7(3,4)+esc*F7(3,2)], 'g','linewidth',2);   % Desenha linha 3D da origem de F7 ao ponto final (origem + vetor da 2ª coluna de F7 * esc); 'g' = cor verde; 'linewidth' 2 = espessura da linha.
text(F7(1,4)+esc*F7(1,2), F7(2,4)+esc*F7(2,2), F7(3,4)+esc*F7(3,2), 'y_{\{7\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Y); 'y_{7}' é o texto que será exibido.
plot3([F7(1,4) F7(1,4)+esc*F7(1,3)], [F7(2,4) F7(2,4)+esc*F7(2,3)], [F7(3,4) F7(3,4)+esc*F7(3,3)], 'r','linewidth',2);   % Desenha linha 3D da origem de F7 ao ponto final (origem + vetor da 3ª coluna de F7 * esc); 'r' = cor vermelha; 'linewidth' 2 = espessura da linha.
text(F7(1,4)+esc*F7(1,3), F7(2,4)+esc*F7(2,3), F7(3,4)+esc*F7(3,3), 'z_{\{7\}}');                                        % Insere texto na posição X,Y,Z do ponto final da linha anterior (ponta do eixo Z); 'z_{7}' é o texto que será exibido.
