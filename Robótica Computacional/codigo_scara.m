  clear;%limpa todas as variáveis da área de trabalho
close all;% Fecha as janelas de figuras abertas
clc% limpa as janelas de comando

## Pacote simbólico
pkg load symbolic %biblioteca

% -------Simbólico base------
syms th dx dy dz th1 th2 d3 real
syms a1_fixo a2_fixo real

one = sym(1); zero = sym(0);% valores simbólicos de 0 e 1
deg2rad_sym = @(d) sym(d) * sym(pi) / sym(180);% muda de ângulo para radianos

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
% Frame {1}: Rotação da base th1 e translação pelo primeiro braço a1_fixo
R_0_1 = subs(Rz, th, th1);
Tr_0_1 = subs(T, [dx dy dz], [a1_fixo zero zero]);
F1 = F0 * R_0_1 * Tr_0_1;

% Frame {2}: Rotação do cotovelo th2 e translação pelo segundo braço a2_fixo
R_1_2 = subs(Rz, th, th2);
Tr_1_2 = subs(T, [dx dy dz], [a2_fixo zero zero]);
F2 = F1 * R_1_2 * Tr_1_2;

% Frame {3}: Movimento vertical da junta prismática d3
Tr_2_3 = subs(T, [dx dy dz], [zero zero d3]);
F3 = F2 * Tr_2_3;

% --------- Parâmetros numéricos ----------
% Parâmetros fixos
a1_fixo_s = sym('1.0');
a2_fixo_s = sym('1.5');

% Valores das juntas
th1s = deg2rad_sym(30);  % ângulo da base
th2s = deg2rad_sym(50);  % ângulo do cotovelo
d3s = sym('-0.5');      % deslocamento vertical (negativo para baixo)

% --------- Substituições -> vpa -> double ---------
F0 = eye(4); %define F0 como uma matriz numérica

% Substitui as variáveis simbólicas pelos valores numéricos em cada frame
F1_num = double(vpa(subs(F1, {th1, a1_fixo}, {th1s, a1_fixo_s}), 12));
F2_num = double(vpa(subs(F2, {th1, th2, a1_fixo, a2_fixo}, {th1s, th2s, a1_fixo_s, a2_fixo_s}), 12));
F3_num = double(vpa(subs(F3, {th1, th2, d3, a1_fixo, a2_fixo}, {th1s, th2s, d3s, a1_fixo_s, a2_fixo_s}), 12));
% converte as matrizes de transformação simbólicas em numéricas, substituindo as variáveis das juntas por seus respectivos valores definidos.

% ==== Plot ====
figure(1); clf;
axis equal; grid on; view(3);
xlabel('x'); ylabel('y'); zlabel('z'); hold on;
axis([-2 3 -1 3 -1 1]); % Ajusta o zoom da visualização

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
plot3([F0(1,4) F1_num(1,4)], [F0(2,4) F1_num(2,4)], [F0(3,4) F1_num(3,4)], 'k', 'linewidth', 3) % Primeiro braço
% Desenha o sistema de coordenadas da base 0 e a linha que o conecta ao próximo referencial

% ---------- Frame {1} ----------
plot3(F1_num(1,4), F1_num(2,4), F1_num(3,4), 'om','linewidth',2,'markersize',mark);
text(F1_num(1,4), F1_num(2,4), F1_num(3,4)-0.2, '\{1\}');
plot3([F1_num(1,4) F1_num(1,4)+esc*F1_num(1,1)], [F1_num(2,4) F1_num(2,4)+esc*F1_num(2,1)], [F1_num(3,4) F1_num(3,4)+esc*F1_num(3,1)], 'b','linewidth',2)
plot3([F1_num(1,4) F1_num(1,4)+esc*F1_num(1,2)], [F1_num(2,4) F1_num(2,4)+esc*F1_num(2,2)], [F1_num(3,4) F1_num(3,4)+esc*F1_num(3,2)], 'g','linewidth',2)
plot3([F1_num(1,4) F1_num(1,4)+esc*F1_num(1,3)], [F1_num(2,4) F1_num(2,4)+esc*F1_num(2,3)], [F1_num(3,4) F1_num(3,4)+esc*F1_num(3,3)], 'r','linewidth',2)
plot3([F1_num(1,4) F2_num(1,4)], [F1_num(2,4) F2_num(2,4)], [F1_num(3,4) F2_num(3,4)], 'k', 'linewidth', 3) % Segundo braço
% Plota as coordenadas do frame 1, com seu rótulo e eixos, e sua linha de conexão até o frame 2

% ---------- Frame {2} ----------
plot3(F2_num(1,4), F2_num(2,4), F2_num(3,4), 'om','linewidth',2,'markersize',mark);
text(F2_num(1,4), F2_num(2,4), F2_num(3,4)-0.2, '\{2\}');
plot3([F2_num(1,4) F2_num(1,4)+esc*F2_num(1,1)], [F2_num(2,4) F2_num(2,4)+esc*F2_num(2,1)], [F2_num(3,4) F2_num(3,4)+esc*F2_num(3,1)], 'b','linewidth',2)
plot3([F2_num(1,4) F2_num(1,4)+esc*F2_num(1,2)], [F2_num(2,4) F2_num(2,4)+esc*F2_num(2,2)], [F2_num(3,4) F2_num(3,4)+esc*F2_num(3,2)], 'g','linewidth',2)
plot3([F2_num(1,4) F2_num(1,4)+esc*F2_num(1,3)], [F2_num(2,4) F2_num(2,4)+esc*F2_num(2,3)], [F2_num(3,4) F2_num(3,4)+esc*F2_num(3,3)], 'r','linewidth',2)
plot3([F2_num(1,4) F3_num(1,4)], [F2_num(2,4) F3_num(2,4)], [F2_num(3,4) F3_num(3,4)], 'k', 'linewidth', 3) % Elo vertical
% Plota as coordenadas do frame 2, com seu rótulo e eixos, e sua linha de conexão até o frame 3

% ---------- Frame {3} ----------
plot3(F3_num(1,4), F3_num(2,4), F3_num(3,4), 'om','linewidth',2,'markersize',mark);
text(F3_num(1,4), F3_num(2,4), F3_num(3,4)-0.2, '\{3\}');
plot3([F3_num(1,4) F3_num(1,4)+esc*F3_num(1,1)], [F3_num(2,4) F3_num(2,4)+esc*F3_num(2,1)], [F3_num(3,4) F3_num(3,4)+esc*F3_num(3,1)], 'b','linewidth',2)
plot3([F3_num(1,4) F3_num(1,4)+esc*F3_num(1,2)], [F3_num(2,4) F3_num(2,4)+esc*F3_num(2,2)], [F3_num(3,4) F3_num(3,4)+esc*F3_num(3,2)], 'g','linewidth',2)
plot3([F3_num(1,4) F3_num(1,4)+esc*F3_num(1,3)], [F3_num(2,4) F3_num(2,4)+esc*F3_num(2,3)], [F3_num(3,4) F3_num(3,4)+esc*F3_num(3,3)], 'r','linewidth',2)
% Plota as coordenadas finais do frame 3, com seu rótulo e seus três eixos (x, y, z)

hold off;
