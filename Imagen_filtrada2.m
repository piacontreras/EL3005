%Pía Contreras Guerrero
%P2 parte b
%Abrimos la imagen original de acuerdo al hint de la tarea
I = imread('cameraman.jpg');
%Hacemos convolucion 2D como indica el enunciado
C = double(I(:,:,1));
%Extendemos hacia afuera las filas como indica el enunciado
C1 = [C(:,1),C(:,1),C(:,1),C,C(:,512),C(:,512),C(:,512)];
%Extendemos hacia afuera las columnas como indica el enunciado
C2 = [C1(1,:);C1(1,:);C1(1,:);C1;C1(512,:);C1(512,:);C1(512,:)];
%Normalizamos el filtro dado en el enunciado
filtro=[1 1 2 2 2 1 1; 1 2 2 4 2 2 1; 2 2 4 8 4 2 2; 2 4 8 16 8 4 2; 2 2 4 8 4 2 2; 1 2 2 4 2 2 1; 1 1 2 2 2 1 1]/140;
%Se normaliza por 140 ya que es la suma de los dígitos del filtro utilizado
%El tamaño de la matriz resultante extendiendo filas y columnas para poder hacer el recorrido es
t=size(C2);
%Fijando la matriz B como una reserva de memoria del mismo tamaño de C pero
%anulando sus elementos
B = C*0;
%Recorremos la matriz en sus filas y columnas para realizar la convolucion
%al igual que la parte anterior, además recordando desde donde inicia el
%filtro
%tamaño en filas
for i = 4:t(1)-3;
    %tamaño en columnas
    for j = 4:t(2)-3;
        %recorriendo la imagen en sus filas y columnas
        n = C2(i-3:i+3,j-3:j+3);
        %Haciendo la multiplicación punto a punto de cada pedacito de
        %imagen con el filtro
        convolucion = n.*filtro;
        %se hace una doble sumatoria (filas y columnas) de la imagen con su filtro para
        %obtener la convolucion final
        conv_final = sum(sum(convolucion));
        %Asignación para la matriz B
        B(i-3,j-3) = conv_final;
    end
end
%Luego de aplicar el filtro se obtiene
B_1 = B;
%Graficando la imagen original versus la imagen pasada por filtro
figure(1), subplot(1,2,1), imshow(uint8(C)), title('Imagen Original')
figure(1), subplot(1,2,2), imshow(uint8(B_1)), title('Imagen pasada por Filtro')
