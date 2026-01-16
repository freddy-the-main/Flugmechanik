clear 
clc

run ParameterInSI.m

%Convetion: x = [beta; r]

A_DutchRoll = [Y_beta/U_1   (Y_r/U_1)-1;...
               N_beta       N_r];

B_DutchRoll = [1;1];

C_DutchRoll = eye(2,2);

D_DutchRoll = zeros(2,1);

sys_DutchRoll = ss(A_DutchRoll,B_DutchRoll,C_DutchRoll,D_DutchRoll);

%characteristical Polinomial
CP = poly(A_DutchRoll)
% we want this: D≥0,19 for level 1






