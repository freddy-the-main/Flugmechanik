clear 
clc


V = 108; %[m/s]

X_v = -0.01266; %[
X_theta = -9.806;

Z_v = -0.00168;
Z_theta = 0.0;

a0 = -X_v * Z_theta + Z_v * X_theta;

a1 = -X_v + Z_theta;


% c.p.
cp = [1 a1 a0];

%eigen:
L = roots(cp);

%kennkreisfreq
omega_0 = sqrt(imag(L(1))^2+real(L(1))^2);
DisTex = 'Kennkreisfrequenz = %f HZ \n';
fprintf(DisTex,omega_0);
disp(' ');

%daempfungskoeff
sigma = real(L(1));
DisTex = 'abklingkoeff = %f HZ \n';
fprintf(DisTex,sigma);
%disp()

%daempfungsgrad
D = -real(L(1)) / omega_0;
DisTex = 'dämpfungsgrad = %f HZ \n';
fprintf(DisTex,D);
%disp()









