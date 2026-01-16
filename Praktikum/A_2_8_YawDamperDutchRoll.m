clear 
clc

run ParameterInSI.m

%Convention: x = [beta; psi_dot]

A = [Y_beta/U_1   (Y_r/U_1)-1;...
               N_beta       N_r];

B = [Y_delta_r/U_1; (N_delta_r+B_1*L_delta_r)/(1+A_1*B_1)];

C = eye(2,2);

D = zeros(2,1);

sys = ss(A,B,C,D);

%characteristic Polynomial
CP_wo_Controller = poly(A)
%D of the Plane without controller:
D_wo_Controller = CP_wo_Controller(2)/(2*sqrt(CP_wo_Controller(3)))
% we want this: D≥0,19 for level 1

% SS from system with controller:

%% Formula for k: 
a = -A(2,2)+B(2)

A_wi_controller = A-(B*[0 0.0721]);

sys_FSF = ss(A_wi_controller,B,C,D);

CP_wi_Controller = poly(A_wi_controller)
%D of the Plane without controller:
D_wi_Controller = CP_wi_Controller(2)/(2*sqrt(CP_wi_Controller(3)))




