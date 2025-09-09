% Translacao:
clear; clc; close all;
% Origem do frame {0} em coord. generalizadas
o_0 = [0; 0; 0; 1];
% Eixos-x,y,z do frame {0} em coord. generalizadas
x_0 = [1; 0; 0; 1];
y_0 = [0; 1; 0; 1];
z_0 = [0; 0; 1; 1];
% Ponto qualquer no frame {0} em coord. generalizadas
P_0 = [1; 1; 1; 1];
% Matriz de translacao do frame {0} para {1}
DeltaX = 2; % Deslocamento em x
DeltaY = 2; % Deslocamento em y
DeltaZ = 2; % Deslocamento em z
T_0_1 = [1 0 0 DeltaX;
0 1 0 DeltaY;
0 0 1 DeltaZ;
0 0 0 1];
% Sistema transladado para o novo frame {1}
o_1 = T_0_1 * o_0; % Translação da origem
x_1 = T_0_1 * x_0; % Translação do eixo-x
y_1 = T_0_1 * y_0; % Translação do eixo-y
z_1 = T_0_1 * z_0; % Translação do eixo-z
P_1 = T_0_1 * P_0; % Translação do ponto P
% Plot
% Origem do frame {0}
plot3(o_0(1) , o_0(2) , o_0(3) , 'sk' , 'linewidth' , 3 , 'markersize' , 10)
axis equal; grid on; hold on;
% Eixo-x do frame {0}
plot3([o_0(1) x_0(1)] , [o_0(2) x_0(2)] , [o_0(1) x_0(3)] , 'b' , 'linewidth' , 2)
text(x_0(1) , x_0(2) , x_0(3) , 'x_{0}')
% Eixo-y do frame {0}
plot3([o_0(1) y_0(1)] , [o_0(2) y_0(2)] , [o_0(1) y_0(3)] , 'r' , 'linewidth' , 2)
text(y_0(1) , y_0(2) , y_0(3) , 'y_{0}')
% Eixo-z do frame {0}
plot3([o_0(1) z_0(1)] , [o_0(2) z_0(2)] , [o_0(1) z_0(3)] , 'g' , 'linewidth' , 2)
text(z_0(1) , z_0(2) , z_0(3) , 'z_{0}')
% Ponto P no frame {0}
plot3(P_0(1) , P_0(2) , P_0(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
plot3([o_0(1) P_0(1)] , [o_0(2) P_0(2)] , [o_0(1) P_0(3)] , '--k' , 'linewidth' , 2)
text(P_0(1) , P_0(2) , P_0(3) , 'P_{0}')
% Origem do frame {1}
plot3(o_1(1) , o_1(2) , o_1(3) , 'sk' , 'linewidth' , 3 , 'markersize' , 10)
% Eixo-x do frame {1}
plot3([o_1(1) x_1(1)] , [o_1(2) x_1(2)] , [o_1(1) x_1(3)] , 'b' , 'linewidth' , 2)
text(x_1(1) , x_1(2) , x_1(3) , 'x_{1}')
% Eixo-y do frame {1}
plot3([o_1(1) y_1(1)] , [o_1(2) y_1(2)] , [o_1(1) y_1(3)] , 'r' , 'linewidth' , 2)
text(y_1(1) , y_1(2) , y_1(3) , 'y_{1}')
% Eixo-z do frame {1}
plot3([o_1(1) z_1(1)] , [o_1(2) z_1(2)] , [o_1(1) z_1(3)] , 'g' , 'linewidth' , 2)
text(z_1(1) , z_1(2) , z_1(3) , 'z_{1}')
% Ponto P no frame {1}
plot3(P_1(1) , P_1(2) , P_1(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
plot3([o_1(1) P_1(1)] , [o_1(2) P_1(2)] , [o_1(1) P_1(3)] , '--k' , 'linewidth' , 2)
text(P_1(1) , P_1(2) , P_1(3) , 'P_{1}')
hold off; xlabel('x'); ylabel('y'); zlabel('z')
title('Translação de pontos e eixos 3D')