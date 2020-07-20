%Pía Contreras Guerrero
%P2 parte a
%Abrimos la imagen original de acuerdo al hint en la tarea
I = imread('cameraman.jpg');
%Hacemos Convolución 2D como indica el enunciado
C = double(I(:,:,1));
%Extendemos hacia afuera filas tal como dice el enunciado
C1 = [C(:,1),C(:,1),C(:,1),C,C(:,512),C(:,512),C(:,512)];
%Extendemos hacia afuera columnas tal como dice el enunciado
C2 = [C1(1,:);C1(1,:);C1(1,:);C1;C1(512,:);C1(512,:);C1(512,:)];
%El filtro a matriz, se normaliza por cero, pues la suma de sus dígitos es
%cero
f=[0 0 -1 -1 -1 0 0; 0 -1 -3 -3 -3 -1 0; -1 -3 0 7 0 -3 -1; -1 -3 7 24 7 -3 -1; -1 -3 0 7 0 -3 -1; 0 -1 -3 -3 -3 -1 0; 0 0 -1 -1 -1 0 0];
%El tamaño de la matriz resultante para poder hacer el recorrido está dado por
t=size(C2);
%Fijando la matriz A como una reserva de memoria del tamaño de C pero
%anulando sus elementos
A = C*0;
%Recorremos la matriz en sus filas y columnas para realizar la convolución
%Además recordando desde donde inicia el filtro
%tamaño en filas
for i = 4:t(1)-3;
    %tamaño en columnas
    for j = 4:t(2)-3;
        %recorriendo la imagen en sus filas y columnas
        n = C2(i-3:i+3,j-3:j+3);
        %Haciendo la multiplicacion punto a punto de cada pedacito de
        %imagen con el filtro
        convolucion = n.*f;
        %se hace una doble sumatoria (filas y columnas) de la imagen con su filtro para
        %obtener la convolución final
        conv_final = sum(sum(convolucion));
        %asignación para la matriz A
        A(i-3,j-3) = conv_final;
    end
end
%Luego de aplicar el filtrado se obtiene
A_1 = A;

%Graficando la imagen original versus la imagen pasada por filtro
figure(1), subplot(1,2,1), imshow(uint8(C)), title('Imagen Original')
figure(1), subplot(1,2,2), imshow(uint8(A_1)), title('Imagen pasada por Filtro')

