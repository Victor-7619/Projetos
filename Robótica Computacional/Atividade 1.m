clear;%limpa todas as variáveis da área de trabalho 
close all;% Fecha as janelas de figuras abertas 
clc% limpa as janelas de comando 
 
## Pacote simbólico 
pkg load symbolic% carrega o pacote simbólico, tipo bliblioteca em C 
 
% -------Simbólico base------ 
syms th dx dy dz L1 L2 L3 L4 L5 L6 L7 real% declara as variáveis simbólicas 
syms th1 th2 th3 th4 th5 th6 th7 real% variáveis genéricas, ângulos das juntas 
 
one = sym(1); zero = sym(0)%cria as verções simbólicas do numeors 1 e 0, para que os 
calculos sejam simblocos 
deg2rad_sym = @(d) sym(d) * sym(pi) / sym(180)%cria uma função anonima para coverter 
o ângulo D para radianos. 
 
T = [ one zero zero dx 
      zero one zero dy 
      zero zero one dz 
      zero zero zero one ]%definição da matriz de translação nos eixos x,y,z 
 
Rx = [ one zero zero zero 
       zero cos(th) -sin(th) zero 
       zero sym(th) cos(th) zero 
       zero zero zero one ] %defini a matriz de tranformação homegenea, rx para uma rotação 
em tono do eixo x, para o ângulo TH 
 
Rz = [ cos(th) -sin(th) zero zero 
       sin(th) cos(th) zero zero 
       zero zero one zero 
       zero zero zero one ]%defini a matriz de tranformação homegenea, rz para uma rotação 
em tono do eixo z, para o ângulo TH 
 
F0 = sym(eye(4))%defini a matriz de transformação de frame base F0 como uma matriz 
indentidade de 4x4 
 
% --------- Cadeia de frames (100% simbólica) --------- 
Tr_0_1 = subs(T, [dx dy dz], [zero zero zero])%calcula a matriz de transformação 
TH_0_1 = Tr_0_1 * subs(Rz, th, th1) %substitui o ângulo generico TH na matriz de rotação 
Rz pelo ângulo da junta TH 1 
F1 = F0 * TH_0_1%calcula a posse do frame 1 em relação a base 
 
pi2= sym(pi)/2;%pi2 que armazena o valor matemático de pi/2 radianos (90°) 
 
Tr_1_2 = subs(T, [dx dy dz],[zero zero L1]) * subs(Rx, th, -pi2)%faz o subtitui os proximos 
ângulos e aloca em tr 
TH_1_2 = Tr_1_2 * subs(Rz, th, th2)%multiplica Tr com a multiplicação dos proximos 
angulos 
F2 = F1*TH_1_2%pega o frame 1 e multiplica pelos ângulos em TH e põe no frame 2 
%mesma coisa que o anterior, só que põe no frame 3 
Tr_2_3 = subs(T, [dx dy dz],[zero L2 zero]) * subs(Rx, th, -pi2) 
TH_2_3 = Tr_2_3 * subs (Rz, th, th3) 
F3= F2* TH_2_3 
%mesma coisa que o anterior, só que põe no frame 4 
Tr_3_4 =  subs(T, [dx dy dz], [zero zero L3]) * subs(Rx, th, pi2) 
TH_3_4 = Tr_3_4 * subs(Rz, th, th4); 
F4 = F3 * TH_3_4; 
%mesma coisa que o anterior, só que põe no frame 5 
Tr_4_5 = subs(T, [dx dy dz], [zero L4 zero]) * subs(Rx, th, -pi2) 
TH_4_5 = Tr_4_5 * subs(Rz, th, th5) 
F5 = F4 * TH_4_5 
%mesma coisa que o anterior, só que põe no frame 6 
Tr_5_6 = subs(T, [dx dy dz], [zero zero L5]) * subs(Rx, th, pi2) 
TH_5_6 = Tr_5_6 * subs(Rz, th, th6) 
F6 = F5 * TH_5_6 
%mesma coisa que o anterior, só que põe no frame 7 
Tr_6_7 = subs(T, [dx dy dz], [zero L6 zero]) * subs(Rx, th, -pi2) 
TH_6_7 = Tr_6_7 * subs(Rz, th, th7) 
F7 = F6 * TH_6_7 
%mesma coisa que o anterior, só que põe no frame 8 
Tr_7_8 = subs(T, [dx dy dz], [zero zero L7]) 
F8 = F7 * Tr_7_8 
% --------- Parâmetros numéricos --------- 
% comprimentos (strings -> simbólico) substituição de valores simbólicos por valores de 
comprimento numéricos 
l1s = sym('0.18'); l2s = sym('0.169');  l3s = sym('0.159'); 
l4s = sym('0.14825'); l5s = sym('0.12825'); l6s = sym('0.12585'); 
l7s = sym('0.04585'); 
% ângulos em rad (simbólicos) 
t1s = deg2rad_sym(0); t2s = deg2rad_sym(0); t3s = deg2rad_sym(0); 
t4s = deg2rad_sym(0); t5s = deg2rad_sym(0); t6s = deg2rad_sym(0); 
t7s = deg2rad_sym(45); % pose exemplo 
% --------- Substituições -> vpa -> double --------- 
% 
F0 = eye(4); %deine F0 como uma matriz numérica 
F1 = double(vpa(subs(F1, th1, t1s), 12)); %substitui, de F1 a F8, variáveis simbólicas, avalia 
a expressão simbólica, coverte o resultado de alta precisão para um número de ponto 
flutuante 
F2 = double(vpa(subs(F2, [L1 th1 th2], [l1s t1s t2s]), 12)); % Substitui as variáveis 
simbólicas L1, th1, th2 na matriz F2 pelos seus valores numéricos (l1s, t1s, t2s), calcula o 
resultado com 12 dígitos de precisão e converte para o tipo double. 
F3 = double(vpa(subs(F3, [L2 L1 th1 th2 th3], [l2s l1s t1s t2s t3s]), 12)); % Substitui as 
variáveis simbólicas na matriz F3 pelos seus valores numéricos, calcula com 12 dígitos de 
precisão e converte para double. 
F4 = double(vpa(subs(F4, [L3 L2 L1 th1 th2 th3 th4], [l3s l2s l1s t1s t2s t3s t4s]), 12)); % 
Substitui as variáveis simbólicas na matriz F4 pelos seus valores numéricos, calcula com 12 
dígitos de precisão e converte para double. 
F5 = double(vpa(subs(F5, [L4 L3 L2 L1 th1 th2 th3 th4 th5], [l4s l3s l2s l1s t1s t2s t3s t4s 
t5s]), 12)); % Substitui as variáveis simbólicas na matriz F5 pelos seus valores numéricos, 
calcula com 12 dígitos de precisão e converte para double. 
F6 = double(vpa(subs(F6, [L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6], [l5s l4s l3s l2s l1s t1s t2s 
t3s t4s t5s t6s]), 12)); % Substitui as variáveis simbólicas na matriz F6 pelos seus valores 
numéricos, calcula com 12 dígitos de precisão e converte para double. 
F7 = double(vpa(subs(F7, [L6 L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6 th7], [l6s l5s l4s l3s l2s 
l1s t1s t2s t3s t4s t5s t6s t7s]), 12)); % Substitui as variáveis simbólicas na matriz F7 pelos 
seus valores numéricos, calcula com 12 dígitos de precisão e converte para double. 
F8 = double(vpa(subs(F8, [L7 L6 L5 L4 L3 L2 L1 th1 th2 th3 th4 th5 th6 th7], [l7s l6s l5s l4s 
l3s l2s l1s t1s t2s t3s t4s t5s t6s t7s]), 12)); % Substitui as variáveis simbólicas na matriz F8 
pelos seus valores numéricos, calcula com 12 dígitos de precisão e converte para double. 
% ==== Plot ==== 
figure(1); clf; % Cria a figura de número 1 (ou a torna ativa se já existir) e limpa seu 
conteúdo atual (clf = clear figure). 
axis equal; grid on; view(3); % Define que os eixos terão a mesma escala, ativa a grade do 
gráfico e define a visualização para 3D. 
xlabel('x'); ylabel('y'); zlabel('z'); hold on; % Nomeia os eixos X, Y e Z e mantém o gráfico 
atual para que novos plots sejam adicionados a ele, em vez de substituí-lo. 
esc = 0.1; % Define uma variável de escala para o comprimento dos eixos dos referenciais a 
serem plotados. 
mark = 5; % Define uma variável para o tamanho dos marcadores que representam as 
origens dos referenciais. 
% ---------- Frame {0} ---------- 
plot3(F0(1,4), F0(2,4), F0(3,4), 'om', 'linewidth', 2, 'markersize', mark); % Plota a origem do 
referencial {0} (coordenadas da 4ª coluna de F0) como um círculo ('o') magenta ('m'). 
plot3([F0(1,4) F0(1,4)+esc*F0(1,1)], [F0(2,4) F0(2,4)+esc*F0(2,1)], [F0(3,4) 
F0(3,4)+esc*F0(3,1)], 'b', 'linewidth', 2); % Plota o eixo X do referencial {0} (vetor da 1ª 
coluna de F0) como uma linha azul ('b'). 
text( F0(1,4)+esc*F0(1,1), F0(2,4)+esc*F0(2,1), F0(3,4)+esc*F0(3,1), 'x_{\{0\}}'); % Adiciona 
o texto 'x_{0}' na ponta do eixo X do referencial {0}. 
plot3([F0(1,4) F0(1,4)+esc*F0(1,2)], [F0(2,4) F0(2,4)+esc*F0(2,2)], [F0(3,4) 
F0(3,4)+esc*F0(3,2)], 'g', 'linewidth', 2); % Plota o eixo Y do referencial {0} (vetor da 2ª 
coluna de F0) como uma linha verde ('g'). 
text( F0(1,4)+esc*F0(1,2), F0(2,4)+esc*F0(2,2), F0(3,4)+esc*F0(3,2), 'y_{\{0\}}'); % Adiciona 
o texto 'y_{0}' na ponta do eixo Y do referencial {0}. 
plot3([F0(1,4) F0(1,4)+esc*F0(1,3)], [F0(2,4) F0(2,4)+esc*F0(2,3)], [F0(3,4) 
F0(3,4)+esc*F0(3,3)], 'r', 'linewidth', 2); % Plota o eixo Z do referencial {0} (vetor da 3ª 
coluna de F0) como uma linha vermelha ('r'). 
text( F0(1,4)+esc*F0(1,3), F0(2,4)+esc*F0(2,3), F0(3,4)+esc*F0(3,3), 'z_{\{0\}}'); % Adiciona 
o texto 'z_{0}' na ponta do eixo Z do referencial {0}. 
plot3([F0(1,4) F1(1,4)], [F0(2,4) F1(2,4)], [F0(3,4) F1(3,4)], 'k'); % Plota uma linha preta ('k') 
conectando a origem do referencial {0} à origem do referencial {1}. 
% ---------- Frame {1} ---------- 
plot3(F1(1,4), F1(2,4), F1(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {1} como um círculo magenta. 
text(F1(1,4), F1(2,4), F1(3,4)-0.2, '\{1\}'); % Adiciona o texto '{1}' um pouco abaixo da origem 
do referencial {1}. 
plot3([F1(1,4) F1(1,4)+esc*F1(1,1)], [F1(2,4) F1(2,4)+esc*F1(2,1)], [F1(3,4) 
F1(3,4)+esc*F1(3,1)], 'b','linewidth',2); % Plota o eixo X do referencial {1} como uma linha 
azul. 
text(F1(1,4)+esc*F1(1,1), F1(2,4)+esc*F1(2,1), F1(3,4)+esc*F1(3,1), 'x_{\{1\}}'); % Adiciona 
o texto 'x_{1}' na ponta do eixo X do referencial {1}. 
plot3([F1(1,4) F1(1,4)+esc*F1(1,2)], [F1(2,4) F1(2,4)+esc*F1(2,2)], [F1(3,4) 
F1(3,4)+esc*F1(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {1} como uma linha 
verde. 
text(F1(1,4)+esc*F1(1,2), F1(2,4)+esc*F1(2,2), F1(3,4)+esc*F1(3,2), 'y_{\{1\}}'); % Adiciona 
o texto 'y_{1}' na ponta do eixo Y do referencial {1}. 
plot3([F1(1,4) F1(1,4)+esc*F1(1,3)], [F1(2,4) F1(2,4)+esc*F1(2,3)], [F1(3,4) 
F1(3,4)+esc*F1(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {1} como uma linha 
vermelha. 
text(F1(1,4)+esc*F1(1,3), F1(2,4)+esc*F1(2,3), F1(3,4)+esc*F1(3,3), 'z_{\{1\}}'); % Adiciona 
o texto 'z_{1}' na ponta do eixo Z do referencial {1}. 
plot3([F1(1,4) F2(1,4)], [F1(2,4) F2(2,4)], [F1(3,4) F2(3,4)], 'k'); % Plota uma linha preta 
conectando a origem do referencial {1} à origem do referencial {2}. 
% ---------- Frame {2} ---------- 
plot3(F2(1,4), F2(2,4), F2(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {2} como um círculo magenta. 
text(F2(1,4), F2(2,4), F2(3,4)-0.2, '\{2\}'); % Adiciona o texto '{2}' um pouco abaixo da origem 
do referencial {2}. 
plot3([F2(1,4) F2(1,4)+esc*F2(1,1)], [F2(2,4) F2(2,4)+esc*F2(2,1)], [F2(3,4) 
F2(3,4)+esc*F2(3,1)], 'b','linewidth',2); % Plota o eixo X do referencial {2} como uma linha 
azul. 
text(F2(1,4)+esc*F2(1,1), F2(2,4)+esc*F2(2,1), F2(3,4)+esc*F2(3,1), 'x_{\{2\}}'); % Adiciona 
o texto 'x_{2}' na ponta do eixo X do referencial {2}. 
plot3([F2(1,4) F2(1,4)+esc*F2(1,2)], [F2(2,4) F2(2,4)+esc*F2(2,2)], [F2(3,4) 
F2(3,4)+esc*F2(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {2} como uma linha 
verde. 
text(F2(1,4)+esc*F2(1,2), F2(2,4)+esc*F2(2,2), F2(3,4)+esc*F2(3,2), 'y_{\{2\}}'); % Adiciona 
o texto 'y_{2}' na ponta do eixo Y do referencial {2}. 
plot3([F2(1,4) F2(1,4)+esc*F2(1,3)], [F2(2,4) F2(2,4)+esc*F2(2,3)], [F2(3,4) 
F2(3,4)+esc*F2(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {2} como uma linha 
vermelha. 
text(F2(1,4)+esc*F2(1,3), F2(2,4)+esc*F2(2,3), F2(3,4)+esc*F2(3,3), 'z_{\{2\}}'); % Adiciona 
o texto 'z_{2}' na ponta do eixo Z do referencial {2}. 
plot3([F2(1,4) F3(1,4)], [F2(2,4) F3(2,4)], [F2(3,4) F3(3,4)], 'k'); % Plota uma linha preta 
conectando a origem do referencial {2} à origem do referencial {3}. 
% ---------- Frame {3} ---------- 
plot3(F3(1,4), F3(2,4), F3(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {3} como um círculo magenta. 
text(F3(1,4), F3(2,4), F3(3,4)-0.2, '\{3\}'); % Adiciona o texto '{3}' um pouco abaixo da origem 
do referencial {3}. 
plot3([F3(1,4) F3(1,4)+esc*F3(1,1)], [F3(2,4) F3(2,4)+esc*F3(2,1)], [F3(3,4) 
F3(3,4)+esc*F3(3,1)], 'b','linewidth',2); % Plota o eixo X do referencial {3} como uma linha 
azul. 
text(F3(1,4)+esc*F3(1,1), F3(2,4)+esc*F3(2,1), F3(3,4)+esc*F3(3,1), 'x_{\{3\}}'); % Adiciona 
o texto 'x_{3}' na ponta do eixo X do referencial {3}. 
plot3([F3(1,4) F3(1,4)+esc*F3(1,2)], [F3(2,4) F3(2,4)+esc*F3(2,2)], [F3(3,4) 
F3(3,4)+esc*F3(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {3} como uma linha 
verde. 
text(F3(1,4)+esc*F3(1,2), F3(2,4)+esc*F3(2,2), F3(3,4)+esc*F3(3,2), 'y_{\{3\}}'); % Adiciona 
o texto 'y_{3}' na ponta do eixo Y do referencial {3}. 
plot3([F3(1,4) F3(1,4)+esc*F3(1,3)], [F3(2,4) F3(2,4)+esc*F3(2,3)], [F3(3,4) 
F3(3,4)+esc*F3(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {3} como uma linha 
vermelha. 
text(F3(1,4)+esc*F3(1,3), F3(2,4)+esc*F3(2,3), F3(3,4)+esc*F3(3,3), 'z_{\{3\}}'); % Adiciona 
o texto 'z_{3}' na ponta do eixo Z do referencial {3}. 
plot3([F3(1,4) F4(1,4)], [F3(2,4) F4(2,4)], [F3(3,4) F4(3,4)], 'k'); % Plota uma linha preta 
conectando a origem do referencial {3} à origem do referencial {4}. 
% ---------- Frame {4} ---------- 
plot3(F4(1,4), F4(2,4), F4(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {4} como um círculo magenta. 
text(F4(1,4), F4(2,4), F4(3,4)-0.2, '\{4\}'); % Adiciona o texto '{4}' um pouco abaixo da origem 
do referencial {4}. 
plot3([F4(1,4) F4(1,4)+esc*F4(1,1)], [F4(2,4) F4(2,4)+esc*F4(2,1)], [F4(3,4) 
F4(3,4)+esc*F4(3,1)], 'b','linewidth',2); % Plota o eixo X do referencial {4} como uma linha 
azul. 
text(F4(1,4)+esc*F4(1,1), F4(2,4)+esc*F4(2,1), F4(3,4)+esc*F4(3,1), 'x_{\{4\}}'); % Adiciona 
o texto 'x_{4}' na ponta do eixo X do referencial {4}. 
plot3([F4(1,4) F4(1,4)+esc*F4(1,2)], [F4(2,4) F4(2,4)+esc*F4(2,2)], [F4(3,4) 
F4(3,4)+esc*F4(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {4} como uma linha 
verde. 
text(F4(1,4)+esc*F4(1,2), F4(2,4)+esc*F4(2,2), F4(3,4)+esc*F4(3,2), 'y_{\{4\}}'); % Adiciona 
o texto 'y_{4}' na ponta do eixo Y do referencial {4}. 
plot3([F4(1,4) F4(1,4)+esc*F4(1,3)], [F4(2,4) F4(2,4)+esc*F4(2,3)], [F4(3,4) 
F4(3,4)+esc*F4(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {4} como uma linha 
vermelha. 
text(F4(1,4)+esc*F4(1,3), F4(2,4)+esc*F4(2,3), F4(3,4)+esc*F4(3,3), 'z_{\{4\}}'); % Adiciona 
o texto 'z_{4}' na ponta do eixo Z do referencial {4}. 
plot3([F4(1,4) F5(1,4)], [F4(2,4) F5(2,4)], [F4(3,4) F5(3,4)], 'k'); % Plota uma linha preta 
conectando a origem do referencial {4} à origem do referencial {5}. 
% ---------- Frame {5} ---------- 
plot3(F5(1,4), F5(2,4), F5(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {5} como um círculo magenta. 
text(F5(1,4), F5(2,4), F5(3,4)-0.2, '\{5\}'); % Adiciona o texto '{5}' um pouco abaixo da origem 
do referencial {5}. 
plot3([F5(1,4) F5(1,4)+esc*F5(1,1)], [F5(2,4) F5(2,4)+esc*F5(2,1)], [F5(3,4) 
F5(3,4)+esc*F5(3,1)],'b','linewidth',2); % Plota o eixo X do referencial {5} como uma linha 
azul. 
text(F5(1,4)+esc*F5(1,1), F5(2,4)+esc*F5(2,1), F5(3,4)+esc*F5(3,1), 'x_{\{5\}}'); % Adiciona 
o texto 'x_{5}' na ponta do eixo X do referencial {5}. 
plot3([F5(1,4) F5(1,4)+esc*F5(1,2)], [F5(2,4) F5(2,4)+esc*F5(2,2)], [F5(3,4) 
F5(3,4)+esc*F5(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {5} como uma linha 
verde. 
text(F5(1,4)+esc*F5(1,2), F5(2,4)+esc*F5(2,2), F5(3,4)+esc*F5(3,2), 'y_{\{5\}}'); % Adiciona 
o texto 'y_{5}' na ponta do eixo Y do referencial {5}. 
plot3([F5(1,4) F5(1,4)+esc*F5(1,3)], [F5(2,4) F5(2,4)+esc*F5(2,3)], [F5(3,4) 
F5(3,4)+esc*F5(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {5} como uma linha 
vermelha. 
text(F5(1,4)+esc*F5(1,3), F5(2,4)+esc*F5(2,3), F5(3,4)+esc*F5(3,3), 'z_{\{5\}}'); % Adiciona 
o texto 'z_{5}' na ponta do eixo Z do referencial {5}. 
plot3([F5(1,4) F6(1,4)], [F5(2,4) F6(2,4)], [F5(3,4) F6(3,4)], 'k'); % Plota uma linha preta 
conectando a origem do referencial {5} à origem do referencial {6}. 
% ---------- Frame {6} ---------- 
plot3(F6(1,4), F6(2,4), F6(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {6} como um círculo magenta. 
text(F6(1,4), F6(2,4), F6(3,4)-0.2, '\{6\}'); % Adiciona o texto '{6}' um pouco abaixo da origem 
do referencial {6}. 
plot3([F6(1,4) F6(1,4)+esc*F6(1,1)], [F6(2,4) F6(2,4)+esc*F6(2,1)], [F6(3,4) 
F6(3,4)+esc*F6(3,1)], 'b','linewidth',2); % Plota o eixo X do referencial {6} como uma linha 
azul. 
text(F6(1,4)+esc*F6(1,1), F6(2,4)+esc*F6(2,1), F6(3,4)+esc*F6(3,1), 'x_{\{6\}}'); % Adiciona 
o texto 'x_{6}' na ponta do eixo X do referencial {6}. 
plot3([F6(1,4) F6(1,4)+esc*F6(1,2)], [F6(2,4) F6(2,4)+esc*F6(2,2)], [F6(3,4) 
F6(3,4)+esc*F6(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {6} como uma linha 
verde. 
text(F6(1,4)+esc*F6(1,2), F6(2,4)+esc*F6(2,2), F6(3,4)+esc*F6(3,2), 'y_{\{6\}}'); % Adiciona 
o texto 'y_{6}' na ponta do eixo Y do referencial {6}. 
plot3([F6(1,4) F6(1,4)+esc*F6(1,3)], [F6(2,4) F6(2,4)+esc*F6(2,3)], [F6(3,4) 
F6(3,4)+esc*F6(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {6} como uma linha 
vermelha. 
text(F6(1,4)+esc*F6(1,3), F6(2,4)+esc*F6(2,3), F6(3,4)+esc*F6(3,3), 'z_{\{6\}}'); % Adiciona 
o texto 'z_{6}' na ponta do eixo Z do referencial {6}. 
plot3([F6(1,4) F7(1,4)], [F6(2,4) F7(2,4)], [F6(3,4) F7(3,4)], 'k'); % Plota uma linha preta 
conectando a origem do referencial {6} à origem do referencial {7}. 
text(F6(1,4)+esc*F6(1,2), F6(2,4)+esc*F6(2,2), F6(3,4)+esc*F6(3,2), 'y_{\{6\}}') 
plot3([F6(1,4) F6(1,4)+esc*F6(1,3)], [F6(2,4) F6(2,4)+esc*F6(2,3)], [F6(3,4) 
F6(3,4)+esc*F6(3,3)], 'r','linewidth',2) 
text(F6(1,4)+esc*F6(1,3), F6(2,4)+esc*F6(2,3), F6(3,4)+esc*F6(3,3), 'z_{\{6\}}') 
plot3([F6(1,4) F7(1,4)], [F6(2,4) F7(2,4)], [F6(3,4) F7(3,4)], 'k') 
% ---------- Frame {7} ---------- 
plot3(F7(1,4), F7(2,4), F7(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {7} (coordenadas da 4ª coluna de F7) como um círculo ('o') magenta ('m'). 
text(F7(1,4), F7(2,4), F7(3,4)-0.2, '\{7\}'); % Adiciona o texto '{7}' um pouco abaixo (Z-0.2) 
da origem do referencial {7}. 
plot3([F7(1,4) F7(1,4)+esc*F7(1,1)], [F7(2,4) F7(2,4)+esc*F7(2,1)], [F7(3,4) 
F7(3,4)+esc*F7(3,1)], 'b','linewidth',2); % Plota o eixo X do referencial {7} (vetor da 1ª coluna 
de F7) como uma linha azul ('b'). 
text(F7(1,4)+esc*F7(1,1), F7(2,4)+esc*F7(2,1), F7(3,4)+esc*F7(3,1), 'x_{\{7\}}'); % Adiciona 
o texto 'x_{7}' na ponta do eixo X do referencial {7}. 
plot3([F7(1,4) F7(1,4)+esc*F7(1,2)], [F7(2,4) F7(2,4)+esc*F7(2,2)], [F7(3,4) 
F7(3,4)+esc*F7(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {7} (vetor da 2ª coluna 
de F7) como uma linha verde ('g'). 
text(F7(1,4)+esc*F7(1,2), F7(2,4)+esc*F7(2,2), F7(3,4)+esc*F7(3,2), 'y_{\{7\}}'); % Adiciona 
o texto 'y_{7}' na ponta do eixo Y do referencial {7}. 
plot3([F7(1,4) F7(1,4)+esc*F7(1,3)], [F7(2,4) F7(2,4)+esc*F7(2,3)], [F7(3,4) 
F7(3,4)+esc*F7(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {7} (vetor da 3ª coluna 
de F7) como uma linha vermelha ('r'). 
text(F7(1,4)+esc*F7(1,3), F7(2,4)+esc*F7(2,3), F7(3,4)+esc*F7(3,3), 'z_{\{7\}}'); % Adiciona 
o texto 'z_{7}' na ponta do eixo Z do referencial {7}. 
plot3([F7(1,4) F8(1,4)], [F7(2,4) F8(2,4)], [F7(3,4) F8(3,4)], 'k'); % Plota uma linha preta ('k') 
conectando a origem do referencial {7} à origem do referencial {8}. 
% ---------- Frame {8} ---------- 
plot3(F8(1,4), F8(2,4), F8(3,4), 'om','linewidth',2,'markersize',mark); % Plota a origem do 
referencial {8} (coordenadas da 4ª coluna de F8) como um círculo ('o') magenta ('m'). 
text(F8(1,4), F8(2,4), F8(3,4)-0.2, '\{8\}'); % Adiciona o texto '{8}' um pouco abaixo (Z-0.2) 
da origem do referencial {8}. 
plot3([F8(1,4) F8(1,4)+esc*F8(1,1)], [F8(2,4) F8(2,4)+esc*F8(2,1)], [F8(3,4) 
F8(3,4)+esc*F8(3,1)], 'b','linewidth',2); % Plota o eixo X do referencial {8} (vetor da 1ª coluna 
de F8) como uma linha azul ('b'). 
text(F8(1,4)+esc*F8(1,1), F8(2,4)+esc*F8(2,1), F8(3,4)+esc*F8(3,1), 'x_{\{8\}}'); % Adiciona 
o texto 'x_{8}' na ponta do eixo X do referencial {8}. 
plot3([F8(1,4) F8(1,4)+esc*F8(1,2)], [F8(2,4) F8(2,4)+esc*F8(2,2)], [F8(3,4) 
F8(3,4)+esc*F8(3,2)], 'g','linewidth',2); % Plota o eixo Y do referencial {8} (vetor da 2ª coluna 
de F8) como uma linha verde ('g'). 
text(F8(1,4)+esc*F8(1,2), F8(2,4)+esc*F8(2,2), F8(3,4)+esc*F8(3,2), 'y_{\{8\}}'); % Adiciona 
o texto 'y_{8}' na ponta do eixo Y do referencial {8}. 
plot3([F8(1,4) F8(1,4)+esc*F8(1,3)], [F8(2,4) F8(2,4)+esc*F8(2,3)], [F8(3,4) 
F8(3,4)+esc*F8(3,3)], 'r','linewidth',2); % Plota o eixo Z do referencial {8} (vetor da 3ª coluna 
de F8) como uma linha vermelha ('r'). 
text(F8(1,4)+esc*F8(1,3), F8(2,4)+esc*F8(2,3), F8(3,4)+esc*F8(3,3), 'z_{\{8\}}'); % Adiciona 
o texto 'z_{8}' na ponta do eixo Z do referencial {8}. 