clear;%limpa todas as variáveis da área de trabalho
close all;% Fecha as janelas de figuras abertas
clc% limpa as janelas de comando

## Pacote simbólico
pkg load symbolic% bibliotecas

% -------Simbólico base------
% As variáveis das juntas prismáticas d1, d2, d3
syms dx dy dz d1 d2 d3 real

one = sym(1); zero = sym(0);%define numeros de 0 e 1, para a matriz simbólica

T = [ one zero zero dx
      zero one zero dy
      zero zero one dz
      zero zero zero one ]; % definição da matriz de transição

syms th real;
Rx = [ one zero zero zero
       zero cos(th) -sin(th) zero
       zero sin(th) cos(th) zero
       zero zero zero one ]; % definição da matriz de rotação em x

Rz = [ cos(th) -sin(th) zero zero
       sin(th) cos(th) zero zero
       zero zero one zero
       zero zero zero one ]; % definição da matriz de rotação em z

F0 = sym(eye(4)); %define a matriz de transformação de frame base F0 como uma matriz indentidade de 4x4

% --------- Cadeia de frames (100% simbólica) ---------
% Frame 1 - Movimento d1 ao longo do eixo Z da base
F1 = subs(T, [dx dy dz], [zero zero d1]);

% Frame 2 - Movimento d2 ao longo do eixo Y do frame 1
Tr_1_2 = subs(T, [dx dy dz], [zero d2 zero]);
F2 = F1 * Tr_1_2;

% Frame 3 - Movimento d3 ao longo do eixo Z do frame 2
Tr_2_3 = subs(T, [dx dy dz], [zero zero d3]);
F3 = F2 * Tr_2_3;

% --------- Parâmetros numéricos ----------
d1s = sym('1.5');
d2s = sym('2.0');
d3s = sym('-0.5');
% Define os valores de deslocamento para cada junta

% --------- Substituições -> vpa -> double ---------
F0 = eye(4);
F1 = double(vpa(subs(F1, d1, d1s), 12));
F2 = double(vpa(subs(F2, [d1 d2], [d1s d2s]), 12));
F3 = double(vpa(subs(F3, [d1 d2 d3], [d1s d2s d3s]), 12));
% converte as matrizes de transformação simbólicas em numéricas, substituindo as variáveis das juntas por seus respectivos valores definidos.

% ==== Plot ====
figure(1); clf;
axis equal; grid on; view(3);
xlabel('x'); ylabel('y'); zlabel('z'); hold on;
axis([-1 3 -1 3 -1 3]); % Arruma o zoom para melhor entendimento do ex
esc = 0.2;
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
plot3([F0(1,4) F1(1,4)], [F0(2,4) F1(2,4)], [F0(3,4) F1(3,4)], 'k', 'linewidth', 2)
% desenha o sistema de coordenadas da base 0 e a linha que o conecta ao próximo referencial

% ---------- Frame {1} ----------
plot3(F1(1,4), F1(2,4), F1(3,4), 'om','linewidth',2,'markersize',mark);
text(F1(1,4), F1(2,4), F1(3,4)-0.2, '\{1\}');
plot3([F1(1,4) F1(1,4)+esc*F1(1,1)], [F1(2,4) F1(2,4)+esc*F1(2,1)], [F1(3,4) F1(3,4)+esc*F1(3,1)], 'b','linewidth',2)
plot3([F1(1,4) F1(1,4)+esc*F1(1,2)], [F1(2,4) F1(2,4)+esc*F1(2,2)], [F1(3,4) F1(3,4)+esc*F1(3,2)], 'g','linewidth',2)
plot3([F1(1,4) F1(1,4)+esc*F1(1,3)], [F1(2,4) F1(2,4)+esc*F1(2,3)], [F1(3,4) F1(3,4)+esc*F1(3,3)], 'r','linewidth',2)
plot3([F1(1,4) F2(1,4)], [F1(2,4) F2(2,4)], [F1(3,4) F2(3,4)], 'k', 'linewidth', 2)
% Plota as coordenadas do frame 1, com seu rótulo e eixos, e sua linha de conexão até o frame 2

% ---------- Frame {2} ----------
plot3(F2(1,4), F2(2,4), F2(3,4), 'om','linewidth',2,'markersize',mark);
text(F2(1,4), F2(2,4), F2(3,4)-0.2, '\{2\}');
plot3([F2(1,4) F2(1,4)+esc*F2(1,1)], [F2(2,4) F2(2,4)+esc*F2(2,1)], [F2(3,4) F2(3,4)+esc*F2(3,1)], 'b','linewidth',2)
plot3([F2(1,4) F2(1,4)+esc*F2(1,2)], [F2(2,4) F2(2,4)+esc*F2(2,2)], [F3(3,4) F3(3,4)+esc*F3(3,2)], 'g','linewidth',2)
plot3([F2(1,4) F2(1,4)+esc*F2(1,3)], [F2(2,4) F2(2,4)+esc*F2(2,3)], [F2(3,4) F2(3,4)+esc*F2(3,3)], 'r','linewidth',2)
plot3([F2(1,4) F3(1,4)], [F2(2,4) F3(2,4)], [F2(3,4) F3(3,4)], 'k', 'linewidth', 2)
% Plota as coordenadas do frame 2, com seu rótulo e eixos, e sua linha de conexão até o frame 3

% ---------- Frame {3} ----------
plot3(F3(1,4), F3(2,4), F3(3,4), 'om','linewidth',2,'markersize',mark);
text(F3(1,4), F3(2,4), F3(3,4)-0.2, '\{3\}');
plot3([F3(1,4) F3(1,4)+esc*F3(1,1)], [F3(2,4) F3(2,4)+esc*F3(2,1)], [F3(3,4) F3(3,4)+esc*F3(3,1)], 'b','linewidth',2)
plot3([F3(1,4) F3(1,4)+esc*F3(1,2)], [F3(2,4) F3(2,4)+esc*F3(2,2)], [F3(3,4) F3(3,4)+esc*F3(3,2)], 'g','linewidth',2)
plot3([F3(1,4) F3(1,4)+esc*F3(1,3)], [F3(2,4) F3(2,4)+esc*F3(2,3)], [F3(3,4) F3(3,4)+esc*F3(3,3)], 'r','linewidth',2)
% Plota as coordenadas finais do frame 3, com seu rótulo e seus três eixos (x, y, z)








