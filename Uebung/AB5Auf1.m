clear
clc


%approx short period
% CP = S² - a1*s + a0
%mit a1 = -Mq - Z_alpha - M_alpha_punkt
%und a0 = Z_alpha * Mq - M_alpha


ALT = [0 25 50]; %[kft]
rho = [1.225 0.55 0.1875];
V   = 210; %[m/s]
S   = 24.16; 
m   = 7974; %[kg]
lambda = 3.2;
e   = 0.81;
Cw0 = 0.017;
CA  = (2*9.81*m)./(rho * V.^2 * S);
lmu = 3.3;
Cmq = -4.3;
Cm_apha_punkt = -1.7;
Iy  = 35115.68;
Cw  = Cw0 + CA.^2/(pi*lambda*e);
CA_alpha = 4;
Cm_apha = -0.4;

% Z_alpha
Kz = rho .* (V * S) ./ (2 * m);
Z_alpha = -Kz .* (CA_alpha + Cw);

%Mq
t1 = lmu / V;
q  = rho .* V^2 /2;
Km = q * S * lmu / Iy;
Mq = Km * t1 * Cmq;

%M_alpha
M_alpha = Km * Cm_apha;

%M_alpha_punkt
M_alpha_punkt = Km * t1 * Cm_apha_punkt;

%CP
a0 = Z_alpha .* Mq - M_alpha
a1 = -Mq - Z_alpha - M_alpha_punkt



%kennkreisfreq
Omega_0 = sqrt(a0);

%Dämpfungsgrad
D = a1 ./ (2 * Omega_0);


figure(1)
clf

subplot(3,1,1)
plot(ALT, Omega_0, 'ko')
xlabel("Flughöhe [ft]")
ylabel("kennkreisfreq")



subplot(3,1,2)
hold on
yline(0.3,'-.r')
yline(2,'-.r')
plot(ALT, D, 'bo')
xlabel("Flughöhe [ft]")
ylabel("Dämpfungsgrad")


subplot(3,1,3)
plot(D, Omega_0, 'ko')

offset_x = 0.001 * max([diff(xlim) diff(ylim)]);
offset_y = 0.05 * max([diff(xlim) diff(ylim)]);
str = {"FLO", "FL250", "FL500"};
text(D+offset_x, Omega_0 + offset_y, str,  'Color', [0.12 0.11 0.35],'Fontsize', 8, 'FontName', 'Trebuchet MS')
xlabel("D")
ylabel("omega 0")