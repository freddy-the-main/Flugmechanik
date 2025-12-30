clear 
clc





num_TF =  [-4.9e-4 -1.6573];
den_TF = [1 1.03 1.07];


G = tf(num_TF, den_TF);

P = bodeoptions;
P.FreqUnits = 'Hz';
P.MagUnits = 'abs';
P.Grid = 'on';
P.Xlim = [0.001 100];

bodeplot(G,P);

freq_hz = 1;

omega = freq_hz *2*pi;

s = omega * 1i;


%TF im Freqbereich

G_freq = (-4.9e-4 * s - 1.6573) / (s^2 + 1.03 * s + 1.07);

% Betrag der tF =  Amplitudenverhältnis
AV = abs(G_freq)

%Amplitude von alpha
A_eta = 10;
A_alpha  = AV * A_eta;


%Phasenverschiebung
PV = angle(G_freq)*180 /pi














