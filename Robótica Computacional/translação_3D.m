% Translação 3D:
clear; clc; close all;
% Ponto original no frame {0} em coordenadas generalizadas:
P_0 = [1; 1; 1; 1]; % Escolha como quiser
% Translação desejada nos eixos-x,y para o frame {1}
DeltaX = 1; DeltaY = 1; DeltaZ = 1; % Escolha como quiser
% Matriz de translação:
T = [1 0 0 DeltaX; 0 1 0 DeltaY; 0 0 1 DeltaZ; 0 0 0 1];
% Translação de P do frame {0} para o frame {1}:
P_1 = T * P_0;
% Plot:
% Ponto original:
plot3(P_0(1) , P_0(2) , P_0(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 15);
axis equal; grid on; hold on;
% Ponto transladado:
plot3(P_1(1) , P_1(2) , P_1(3) , 'xr' , 'linewidth' , 2 , 'markersize' , 15);
% Diferença entre os pontos:
plot3([P_0(1) P_1(1)] , [P_0(2) P_1(2)] , [P_0(3) P_1(3)] , ':k' , 'linewidth' , 2)
% Textos inseridos na figura:
text(P_0(1) , P_0(2) , P_0(3) , 'ponto original')
text(P_1(1) , P_1(2) , P_1(3) , 'ponto transladado')
hold off; axis([0 2 0 2 0 2]);
xlabel('x'); ylabel('y'); zlabel('z'); title('Translação 3D')
