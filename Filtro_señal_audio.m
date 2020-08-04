%Pía Contreras Guerrero
%Pregunta 1
%Carga del archivo
load('audio_signal.mat', 'audio')
%Definicion de la variables
audio=audio;
fs=44100; %frecuencia de muestreo
T=1/fs; %periodo de muestreo
retardo=2000;
soundsc(audio,fs);
%armando el filtro discreto (cm)
l=-retardo/2:1:retardo/2;
%calculo coeficientes de la ventana rectangular
coef_1=(5050/fs)*2; 
coef_2=(4950/fs)*2; 
%en la ecuación
cm=coef_2.*sinc(coef_2.*l)+sinc(l)-coef_1.*sinc(coef_1.*l);
%calculo coeficientes ventana de hamming
h=length(l) ;
%multiplicando los coef de la ventana rectangular por la formula de hamming
a=0.54;
b=0.46;
%la ventana de hamming esta dada por
v_h=a+b.*cos(2*pi.*l./h);
%multiplicando la ventana rectangular con la ventana de hamming
cm_H=cm.*v_h;

%fft para ventana rectangular
R=fft(cm); 
dom_R=linspace(0,1/(2*T),2001/2); 
%ploteando
figure
hold on
plot(dom_R,abs(R(1:2001/2))) 
grid
title 'Respuesta en frecuencia para ventana rectangular'
xlabel 'Frecuencia [Hz]'
ylabel '|fft|'
hold off

%fft para ventana de hamming
H=fft(cm_H); 
dom_H=linspace(0,1/(2*T),2001/2); 
%ploteando
figure
hold on
plot(dom_H,abs(H(1:2001/2)));
grid
title 'Respuesta en frecuencia para ventana de Hamming'
xlabel 'Frecuencia [Hz]'
ylabel '|fft|'
hold off

%señal sin filtro
fvtool(audio)
title 'FFT de la señal sin filtro'
xlabel 'Frecuencia [Hz]'
ylabel '|fft|'

%señal filtrada con ventana rectangular
a_R=filter(cm,1,audio);
%señal filtrada con ventana de hamming
a_H=filter(cm_H,1,audio);

%señal filtrada con ventana rectangular
fvtool(a_R)
title 'FFT de la señal con filtro rectangular'
xlabel 'Frecuencia [Hz]'
ylabel '|fft|'

%señal filtrada con ventana hamming
fvtool(a_H)
title 'FFT de la señal con filtro hamming'
xlabel 'Frecuencia [Hz]'
ylabel '|fft|'

%canción sin ruido
soundsc(a_H,fs);



