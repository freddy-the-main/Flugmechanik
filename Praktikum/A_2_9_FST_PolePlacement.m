clear
clc

run A_2_2_2_Mode_of_Motion.m
% Loads aerodynamic derivatives and eigenvalues of the full model
% In particular, the variable "DutchRoll" contains the complex DR poles

% -------------------------------------------------------------------------
% Approximate Dutch-roll state-space model
% State vector: x = [beta; r]
% -------------------------------------------------------------------------

A_aprx = [ Y_beta/U_1      (Y_r/U_1) - 1; ...
           N_beta          N_r ];
% System matrix of the approximated Dutch-roll dynamics

B_aprx = [ Y_delta_r/U_1; ...
          (N_delta_r + B_1*L_delta_r)/(1 + A_1*B_1) ];
% Input matrix (rudder input delta_r)

% -------------------------------------------------------------------------
% Extract modal properties from full-model Dutch-roll eigenvalues
% -------------------------------------------------------------------------

omega_0 = sqrt(real(DutchRoll(1))^2 + imag(DutchRoll(1))^2);
% Undamped natural frequency:
% omega_0 = sqrt(sigma^2 + omega_d^2)

D_damping = -real(DutchRoll(1))/omega_0;
% Damping ratio:
% zeta = -sigma / omega_0


% -------------------------------------------------------------------------
% Full-state feedback design (ZVR)
% K = [k1 k2]
% -------------------------------------------------------------------------

syms k1 k2

CP_sym = charpoly(A_aprx - B_aprx*[k1 k2]);
% Characteristic polynomial of the closed-loop system:
% s^2 + CP_sym(2)*s + CP_sym(3)

eq1 = omega_0^2 == CP_sym(3);
% Match constant term: omega_0^2

eq2 = 2*D_damping*omega_0 == CP_sym(2);
% Match linear term: 2*zeta*omega_0

[k1, k2] = solve([eq1 eq2],[k1 k2]);

k1 = double(k1)
k2 = double(k2)


% check if the k values a correct:

DutchRoll

eigValuesAprxDR = eig(A_aprx - B_aprx*[k1 k2])