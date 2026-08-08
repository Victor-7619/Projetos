clear;%limpa todas as variáveis da área de trabalho
close all;% Fecha as janelas de figuras abertas
clc% limpa as janelas de comando

## Pacote simbólico
pkg load symbolic% biblioteca

% -------Simbólico base------
syms th dx dy dz th1 d2 d3 real

one = sym(1); zero = sym(0); % define valores simbólicos de 0 e 1
deg2rad_sym = @(d) sym(d) * sym(pi) / sym(180); %converte graus em radianos

T = [ one zero zero dx
      zero one zero dy
      zero zero one dz
      zero zero zero one ]; % definição da matriz de transição

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
% Frame {1}: Rotação da base th1. O frame gira mas não se move.
R_0_1 = subs(Rz, th, th1);
F1 = F0 * R_0_1;

% Frame {2}: Movimento vertical d2 (ao longo do eixo Z do frame anterior)
Tr_1_2 = subs(T, [dx dy dz], [zero zero d2]);
F2 = F1 * Tr_1_2;

% Frame {3}: Movimento radial d3 (ao longo do eixo X do frame anterior)
Tr_2_3 = subs(T, [dx dy dz], [d3 zero zero]);
F3 = F2 * Tr_2_3;

% --------- Parâmetros numéricos ----------
th1s = deg2rad_sym(30); % ângulo da base em radianos
d2s = sym('1.5');      % deslocamento vertical
d3s = sym('1.0');      % deslocamento radial

% --------- Substituições -> vpa -> double ---------
F0 = eye(4); %define F0 como uma matriz numérica

F1_num = double(vpa(subs(F1, th1, th1s), 12));
F2_num = double(vpa(subs(F2, {th1, d2}, {th1s, d2s}), 12));
F3_num = double(vpa(subs(F3, {th1, d2, d3}, {th1s, d2s, d3s}), 12));
% converte as matrizes de transformação simbólicas em numéricas, substituindo as variáveis das juntas por seus respectivos valores definidos.

% ==== Plot ====
figure(1); clf;
axis equal; grid on; view(3);
xlabel('x'); ylabel('y'); zlabel('z'); hold on;
axis([-2 2 -2 2 0 3]);

esc = 0.2;
mark = 7;
% Configura e formata a janela para a plotagem do gráfico 3D

% ---------- Frame {0} ----------
plot3(F0(1,4), F0(2,4), F0(3,4), 'om', 'linewidth', 2, 'markersize', mark);
plot3([F0(1,4) F0(1,4)+esc*F0(1,1)], [F0(2,4) F0(2,4)+esc*F0(2,1)], [F0(3,4) F0(3,4)+esc*F0(3,1)], 'b', 'linewidth', 2)
text( F0(1,4)+esc*F0(1,1), F0(2,4)+esc*F0(2,1), F0(3,4)+esc*F0(3,1), 'x_{\{0\}}')
plot3([F0(1,4) F0(1,4)+esc*F0(1,2)], [F0(2,4) F0(2,4)+esc*F0(2,2)], [F0(3,4) F0(3,4)+esc*F0(3,2)], 'g', 'linewidth', 2)
text( F0(1,4)+esc*F0(1,2), F0(2,4)+esc*F0(2,2), F0(3,4)+esc*F0(3,2), 'y_{\{0\}}')
plot3([F0(1,4) F0(1,4)+esc*F0(1,3)], [F0(2,4) F0(2,4)+esc*F0(2,3)], [F0(3,4) F0(3,4)+esc*F0(3,3)], 'r', 'linewidth', 2)
text( F0(1,4)+esc*F0(1,3), F0(2,4)+esc*F0(2,3), F0(3,4)+esc*F0(3,3), 'z_{\{0\}}')
% Desenha o sistema de coordenadas da base 0 e a linha que o conecta ao próximo referencial
% O link entre 0 e 1 tem comprimento zero, então não é desenhado.

% ---------- Frame {1} ----------
plot3(F1_num(1,4), F1_num(2,4), F1_num(3,4), 'om','linewidth',2,'markersize',mark);
text(F1_num(1,4), F1_num(2,4), F1_num(3,4)-0.2, '\{1\}');
plot3([F1_num(1,4) F1_num(1,4)+esc*F1_num(1,1)], [F1_num(2,4) F1_num(2,4)+esc*F1_num(2,1)], [F1_num(3,4) F1_num(3,4)+esc*F1_num(3,1)], 'b','linewidth',2)
text(F1_num(1,4)+esc*F1_num(1,1), F1_num(2,4)+esc*F1_num(2,1), F1_num(3,4)+esc*F1_num(3,1), 'x_{\{1\}}')
plot3([F1_num(1,4) F1_num(1,4)+esc*F1_num(1,2)], [F1_num(2,4) F1_num(2,4)+esc*F1_num(2,2)], [F1_num(3,4) F1_num(3,4)+esc*F1_num(3,2)], 'g','linewidth',2)
text(F1_num(1,4)+esc*F1_num(1,2), F1_num(2,4)+esc*F1_num(2,2), F1_num(3,4)+esc*F1_num(3,2), 'y_{\{1\}}')
plot3([F1_num(1,4) F1_num(1,4)+esc*F1_num(1,3)], [F1_num(2,4) F1_num(2,4)+esc*F1_num(2,3)], [F1_num(3,4) F1_num(3,4)+esc*F1_num(3,3)], 'r','linewidth',2)
text(F1_num(1,4)+esc*F1_num(1,3), F1_num(2,4)+esc*F1_num(2,3), F1_num(3,4)+esc*F1_num(3,3), 'z_{\{1\}}')
plot3([F1_num(1,4) F2_num(1,4)], [F1_num(2,4) F2_num(2,4)], [F1_num(3,4) F2_num(3,4)], 'k', 'linewidth', 3) % Elo vertical
% Plota as coordenadas do frame 1, com seu rótulo e eixos, e sua linha de conexão até o frame 2

% ---------- Frame {2} ----------
plot3(F2_num(1,4), F2_num(2,4), F2_num(3,4), 'om','linewidth',2,'markersize',mark);
text(F2_num(1,4), F2_num(2,4), F2_num(3,4)-0.2, '\{2\}');
plot3([F2_num(1,4) F2_num(1,4)+esc*F2_num(1,1)], [F2_num(2,4) F2_num(2,4)+esc*F2_num(2,1)], [F2_num(3,4) F2_num(3,4)+esc*F2_num(3,1)], 'b','linewidth',2)
text(F2_num(1,4)+esc*F2_num(1,1), F2_num(2,4)+esc*F2_num(2,1), F2_num(3,4)+esc*F2_num(3,1), 'x_{\{2\}}')
plot3([F2_num(1,4) F2_num(1,4)+esc*F2_num(1,2)], [F2_num(2,4) F2_num(2,4)+esc*F2_num(2,2)], [F2_num(3,4) F2_num(3,4)+esc*F2_num(3,2)], 'g','linewidth',2)
text(F2_num(1,4)+esc*F2_num(1,2), F2_num(2,4)+esc*F2_num(2,2), F2_num(3,4)+esc*F2_num(3,2), 'y_{\{2\}}')
plot3([F2_num(1,4) F2_num(1,4)+esc*F2_num(1,3)], [F2_num(2,4) F2_num(2,4)+esc*F2_num(2,3)], [F2_num(3,4) F2_num(3,4)+esc*F2_num(3,3)], 'r','linewidth',2)
text(F2_num(1,4)+esc*F2_num(1,3), F2_num(2,4)+esc*F2_num(2,3), F2_num(3,4)+esc*F2_num(3,3), 'z_{\{2\}}')
plot3([F2_num(1,4) F3_num(1,4)], [F2_num(2,4) F3_num(2,4)], [F2_num(3,4) F3_num(3,4)], 'k', 'linewidth', 3) % Elo radial
% Plota as coordenadas do frame 2, com seu rótulo e eixos, e sua linha de conexão até o frame 3

% ---------- Frame {3} ----------
plot3(F3_num(1,4), F3_num(2,4), F3_num(3,4), 'om','linewidth',2,'markersize',mark);
text(F3_num(1,4), F3_num(2,4), F3_num(3,4)-0.2, '\{3\}');
plot3([F3_num(1,4) F3_num(1,4)+esc*F3_num(1,1)], [F3_num(2,4) F3_num(2,4)+esc*F3_num(2,1)], [F3_num(3,4) F3_num(3,4)+esc*F3_num(3,1)], 'b','linewidth',2)
text(F3_num(1,4)+esc*F3_num(1,1), F3_num(2,4)+esc*F3_num(2,1), F3_num(3,4)+esc*F3_num(3,1), 'x_{\{3\}}')
plot3([F3_num(1,4) F3_num(1,4)+esc*F3_num(1,2)], [F3_num(2,4) F3_num(2,4)+esc*F3_num(2,2)], [F3_num(3,4) F3_num(3,4)+esc*F3_num(3,2)], 'g','linewidth',2)
text(F3_num(1,4)+esc*F3_num(1,2), F3_num(2,4)+esc*F3_num(2,2), F3_num(3,4)+esc*F3_num(3,2), 'y_{\{3\}}')
plot3([F3_num(1,4) F3_num(1,4)+esc*F3_num(1,3)], [F3_num(2,4) F3_num(2,4)+esc*F3_num(2,3)], [F3_num(3,4) F3_num(3,4)+esc*F3_num(3,3)], 'r','linewidth',2)
text(F3_num(1,4)+esc*F3_num(1,3), F3_num(2,4)+esc*F3_num(2,3), F3_num(3,4)+esc*F3_num(3,3), 'z_{\{3\}}')
% Plota as coordenadas finais do frame 3, com seu rótulo e seus três eixos (x, y, z)

hold off;
