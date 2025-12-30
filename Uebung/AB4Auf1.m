clear
clc

S = 845; % wing area
b = 79.8; %wingspan
CLalpha = 4.35; % lift curve slope
Ks = 100000; %Bending stiffness [Nm/deg]
I = 10866000; %Inertia [mkg²]
V = 735 / 3.6; %airspeed [m/s]
rho = 0.413; %air density [kg/m³]

% C.F.
q = 0.5 * rho * V^2;
Kw = CLalpha * q * S;

CP =  [1 (Kw*b^2)/(12 * V * I) Ks/I];


L = roots(CP)




