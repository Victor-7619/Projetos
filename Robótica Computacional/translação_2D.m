>> % Ponto original no frame {0} em coordenadas generalizadas:
>> P_0 = [1
1
1];
>> % Translação desejada nos eixos-x,y para o frame {1}
>> DeltaX = 1; % Escolha como quiser
>> DeltaY = 1; % Escolha como quiser
>> % Matriz de translação:
>> T = [1 0 DeltaX
0 1 DeltaY
0 0 1];
>> % Translação de P do frame {0} para o frame {1}:
>> P_1 = T * P_0;
>> % Plot:
>> % Ponto original:
>> plot(P_0(1) , P_0(2) , 'ob' , 'linewidth' , 2 , 'markersize' , 15);
>> axis equal; grid on; hold on;
>> % Ponto transladado:
>> plot(P_1(1) , P_1(2) , 'xr' , 'linewidth' , 2 , 'markersize' , 15);
>> % Diferença entre os pontos:
>> plot([P_0(1) P_1(1)] , [P_0(2) P_1(2)] , ':k' , 'linewidth' , 2)
>> % Textos inseridos na figura:
>> text(P_0(1) , P_0(2) , 'ponto original')
>> text(P_1(1) , P_1(2) , 'ponto transladado')
>> hold off; axis([0 2 0 2]);
>> xlabel('x'); ylabel('y'); title('Translação 2D') 13
error: parse error:

  syntax error

>>> xlabel('x'); ylabel('y'); title('Translação 2D') 13
                                                        ^
(i-search)`': error: save: unable to open output file 'C:/test'
>>