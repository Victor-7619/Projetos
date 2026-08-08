clear;%limpa todas as variáveis da área de trabalho
close all;% Fecha as janelas de figuras abertas
clc% limpa as janelas de comando

## Pacote simbólico
pkg load symbolic% bibliotecas

% -------Simbólico base------
syms th dx dy dz d1 a2 a3 real% declara variáveis
syms th1 real% ângulos das juntas

one = sym(1); zero = sym(0)%define numeros de 0 e 1, para a matriz simbólica
deg2rad_sym = @(d) sym(d) * sym(pi) / sym(180)% converte graus em radianos

T = [ one zero zero dx
      zero one zero dy
      zero zero one dz
      zero zero zero one ] % definição da matriz de transição

Rx = [ one zero zero zero
       zero cos(th) -sin(th) zero
       zero sym(th) cos(th) zero
       zero zero zero one ] % definição da matriz de rotação em x

Rz = [ cos(th) -sin(th) zero zero
       sin(th) cos(th) zero zero
       zero zero one zero
       zero zero zero one ] % definição da matriz de rotação em z

F0 = sym(eye(4)) %define a matriz de transformação de frame base F0 como uma matriz indentidade de 4x4

% --------- Cadeia de frames (100% simbólica) ---------
Tr_0_1 = subs(T, [dx dy dz], [zero zero d1])%define a translação do frame o para 1
TH_0_1 = subs(Rx, th , deg2rad_sym(-90)) % define a rotação do frame 0 para 1
F1 = F0 * Tr_0_1 * TH_0_1 % define a matriz resultante

pi2= sym(pi)/2;%pi2 que armazena o valor matemático de pi/2 radianos (90°)

Tr_1_2 = subs(T, [dx dy dz],[a2 zero zero])% subtitui os proximos ângulos e aloca em tr
F2 = F1*Tr_1_2% pega o frame 1 e multiplica pelos ângulos em TH e põe no frame 2

TH_2_3 = subs (Rz, th, deg2rad_sym(45) )
Tr_2_3 = subs(T, [dx dy dz], [a3 zero zero])
F3= F2 * TH_2_3 * Tr_2_3

% --------- Parâmetros numéricos ----------
d1s = sym('1.0');
a2s = sym('1.0');
a3s = sym('2.0');
% Define os valores de deslocamento para cada junta

% --------- Substituições -> vpa -> double ---------

F0 = eye(4); %deine F0 como uma matriz numérica
F1 = double(vpa(subs(F1, d1, d1s), 12));
F2 = double(vpa(subs(F2, [d1 a2], [d1s a2s]), 12));
F3 = double(vpa(subs(F3, [d1 a2 a3], [d1s a2s a3s]), 12));
% converte as matrizes de transformação simbólicas em numéricas, substituindo as variáveis das juntas por seus respectivos valores definidos.

% ==== Plot ====
figure(1); clf;
axis equal; grid on; view(3);
xlabel('x'); ylabel('y'); zlabel('z'); hold on;

esc = 0.1;
mark = 5;
% Configura e formata a janela para a plotagem do gráfico 3D

% ---------- Frame {0} ----------
plot3(F0(1,4), F0(2,4), F0(3,4), 'om', 'linewidth', 2, 'markersize', mark);
plot3([F0(1,4) F0(1,4)+esc*F0(1,1)], [F0(2,4) F0(2,4)+esc*F0(2,1)], [F0(3,4) F0(3,4)+esc*F0(3,1)], 'b', 'linewidth', 2)
text( F0(1,4)+esc*F0(1,1), F0(2,4)+esc*F0(2,1), F0(3,4)+esc*F0(3,1), 'x_{\{0\}}')
plot3([F0(1,4) F0(1,4)+esc*F0(1,2)], [F0(2,4) F0(2,4)+esc*F0(2,2)], [F0(3,4) F0(3,4)+esc*F0(3,2)], 'g', 'linewidth', 2)
text( F0(1,4)+esc*F0(1,2), F0(2,4)+esc*F0(2,2), F0(3,4)+esc*F0(3,2), 'y_{\{0\}}')
plot3([F0(1,4) F0(1,4)+esc*F0(1,3)], [F0(2,4) F0(2,4)+esc*F0(2,3)], [F0(3,4) F0(3,4)+esc*F0(3,3)], 'r', 'linewidth', 2)
text( F0(1,4)+esc*F0(1,3), F0(2,4)+esc*F0(2,3), F0(3,4)+esc*F0(3,3), 'z_{\{0\}}')
plot3([F0(1,4) F1(1,4)], [F0(2,4) F1(2,4)], [F0(3,4) F1(3,4)], 'k')
% desenha o sistema de coordenadas da base 0 e a linha que o conecta ao próximo referencial

% ---------- Frame {1} ----------
plot3(F1(1,4), F1(2,4), F1(3,4), 'om','linewidth',2,'markersize',mark);
text(F1(1,4), F1(2,4), F1(3,4)-0.2, '\{1\}');
plot3([F1(1,4) F1(1,4)+esc*F1(1,1)], [F1(2,4) F1(2,4)+esc*F1(2,1)], [F1(3,4) F1(3,4)+esc*F1(3,1)], 'b','linewidth',2)
text(F1(1,4)+esc*F1(1,1), F1(2,4)+esc*F1(2,1), F1(3,4)+esc*F1(3,1), 'x_{\{1\}}')
plot3([F1(1,4) F1(1,4)+esc*F1(1,2)], [F1(2,4) F1(2,4)+esc*F1(2,2)], [F1(3,4) F1(3,4)+esc*F1(3,2)], 'g','linewidth',2)
text(F1(1,4)+esc*F1(1,2), F1(2,4)+esc*F1(2,2), F1(3,4)+esc*F1(3,2), 'y_{\{1\}}')
plot3([F1(1,4) F1(1,4)+esc*F1(1,3)], [F1(2,4) F1(2,4)+esc*F1(2,3)], [F1(3,4) F1(3,4)+esc*F1(3,3)], 'r','linewidth',2)
text(F1(1,4)+esc*F1(1,3), F1(2,4)+esc*F1(2,3), F1(3,4)+esc*F1(3,3), 'z_{\{1\}}')
plot3([F1(1,4) F2(1,4)], [F1(2,4) F2(2,4)], [F1(3,4) F2(3,4)], 'k')
% Plota as coordenadas do frame 1, com seu rótulo e eixos, e sua linha de conexão até o frame 2

% ---------- Frame {2} ----------
plot3(F2(1,4), F2(2,4), F2(3,4), 'om','linewidth',2,'markersize',mark);
text(F2(1,4), F2(2,4), F2(3,4)-0.2, '\{2\}');
plot3([F2(1,4) F2(1,4)+esc*F2(1,1)], [F2(2,4) F2(2,4)+esc*F2(2,1)], [F2(3,4) F2(3,4)+esc*F2(3,1)], 'b','linewidth',2)
text(F2(1,4)+esc*F2(1,1), F2(2,4)+esc*F2(2,1), F2(3,4)+esc*F2(3,1), 'x_{\{2\}}')
plot3([F2(1,4) F2(1,4)+esc*F2(1,2)], [F2(2,4) F2(2,4)+esc*F2(2,2)], [F2(3,4) F2(3,4)+esc*F2(3,2)], 'g','linewidth',2)
text(F2(1,4)+esc*F2(1,2), F2(2,4)+esc*F2(2,2), F2(3,4)+esc*F2(3,2), 'y_{\{2\}}')
plot3([F2(1,4) F2(1,4)+esc*F2(1,3)], [F2(2,4) F2(2,4)+esc*F2(2,3)], [F2(3,4) F2(3,4)+esc*F2(3,3)], 'r','linewidth',2)
text(F2(1,4)+esc*F2(1,3), F2(2,4)+esc*F2(2,3), F2(3,4)+esc*F2(3,3), 'z_{\{2\}}')
plot3([F2(1,4) F3(1,4)], [F2(2,4) F3(2,4)], [F2(3,4) F3(3,4)], 'k')
% Plota as coordenadas do frame 2, com seu rótulo e eixos, e sua linha de conexão até o frame 3

% ---------- Frame {3} ----------
plot3(F3(1,4), F3(2,4), F3(3,4), 'om','linewidth',2,'markersize',mark);
text(F3(1,4), F3(2,4), F3(3,4)-0.2, '\{3\}');
plot3([F3(1,4) F3(1,4)+esc*F3(1,1)], [F3(2,4) F3(2,4)+esc*F3(2,1)], [F3(3,4) F3(3,4)+esc*F3(3,1)], 'b','linewidth',2)
text(F3(1,4)+esc*F3(1,1), F3(2,4)+esc*F3(2,1), F3(3,4)+esc*F3(3,1), 'x_{\{3\}}')
plot3([F3(1,4) F3(1,4)+esc*F3(1,2)], [F3(2,4) F3(2,4)+esc*F3(2,2)], [F3(3,4) F3(3,4)+esc*F3(3,2)], 'g','linewidth',2)
text(F3(1,4)+esc*F3(1,2), F3(2,4)+esc*F3(2,2), F3(3,4)+esc*F3(3,2), 'y_{\{3\}}')
plot3([F3(1,4) F3(1,4)+esc*F3(1,3)], [F3(2,4) F3(2,4)+esc*F3(2,3)], [F3(3,4) F3(3,4)+esc*F3(3,3)], 'r','linewidth',2)
text(F3(1,4)+esc*F3(1,3), F3(2,4)+esc*F3(2,3), F3(3,4)+esc*F3(3,3), 'z_{\{3\}}')
% Plota as coordenadas finais do frame 3, com seu rótulo e seus três eixos (x, y, z)

