clear 
clc

Y_beta = -2.3775;
Y_r = 0.7529;
N_beta = 0.64;
N_r = -0.34;
u0 = 47;
Y_del_rud = -1.6;
N_del_rud = 0.616;

A = [Y_beta/u0 -(1-Y_r/u0); N_beta N_r];

B = [Y_del_rud;N_del_rud];

C = eye(size(A));

D = zeros(size(B));


[EV, L] = eig(A);

%Anfangswerte
beta_0 = deg2rad(6); %sideslip

r_0 = deg2rad(2); %yaw rate


%Konstate Ci
B_eq = [beta_0; r_0]
% A_eq = EV
C_eq = EV \ B_eq

% grafische Darstellung
dauer = 20; %sim dauer in sek
delta = 0.001; % dt

t = 0:delta:dauer;

beta = rad2deg(C_eq(1) * EV(1,1) * exp(L(1,1)*t) + C_eq(2) * EV(1,2) * exp(L(2,2)*t)); 
r    = rad2deg(C_eq(1) * EV(2,1) * exp(L(1,1)*t) + C_eq(2) * EV(2,2) * exp(L(2,2)*t)) ;


%plot
subplot(2,1,1)
plot(t,beta,'-.r')
xlabel("zeit [s]")
ylabel("Beta [deg]")
subplot(2,1,2)
plot(t,r,'--k')
xlabel("zeit [s]")
ylabel("r [x]")




