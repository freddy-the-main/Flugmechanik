clear 
clc

run ParameterInSI.m

%% system Matrix (A_long) and input Matrix (C_long) for longitudinal motion
% this matirx expects the state vector to be: [Theta_dot; Theta; alpha; u]
% and input vectors to be: [delta_e]


A_long = [(M_q + (Z_q+U_1)/(U_1-Z_alpha_dot) * M_alpha)    ((-sin(Theta_1)*g*M_alpha)/(U_1-Z_alpha_dot))  (M_alpha + M_T_alpha + (Z_alpha*M_alpha)/(U_1-Z_alpha_dot))  (M_u + M_T_u + (Z_u *M_alpha)/(U_1 - Z_alpha_dot)); ...
          1 0 0 0;...
          ((Z_q + U_1)/(U_1 - Z_alpha_dot))                -((sin(Theta_1)*g)/(U_1 - Z_alpha_dot))        (Z_alpha/(U_1 - Z_alpha))                                    (Z_u/(U_1 - Z_alpha_dot));...
          0                                                -(cos(Theta_1)*g)                              X_alpha                                                      (X_u + X_T_u)]



B_long = [(M_delta_e + (Z_delta_e * M_alpha)/(U_1 - Z_alpha_dot));...
          0;...
          Z_delta_e;...
          0]
        


%% System Matrix (A_side) and input Matrix (C_side) for side motion
% this matirx expects the state vector to be: [beta; Theta_dot; Theta; Psi_dot; Psi]
% and input vectors to be: [delta_a; delta_r]

A_1 = I_xz / I_xx;
B_1 = I_xz / I_zz;

A_lat = [ Y_beta/U_1,                                             Y_p/U_1,                           g*cos(Theta_1)/U_1,   (Y_r-U_1)/U_1,                 0; ...
          (L_beta + A_1*N_beta + A_1*N_T_beta)/(1 + A_1*B_1),     (L_p + A_1*N_p)/(1 + A_1*B_1),     0,                    (L_r + A_1*N_r)/(1 + A_1*B_1), 0; ...
          0,                                                      1,                                 0,                    0,                             0; ...
          (N_beta + N_T_beta + B_1*L_beta)/(1 + A_1*B_1),         (N_p + B_1*L_p)/(1 + A_1*B_1),     0,                    (N_r + B_1*L_r)/(1 + A_1*B_1), 0; ...
          0,                                                      0,                                 0,                    0,                             0 ]


B_lat = [ Y_delta_a/U_1,                               Y_delta_r/U_1; ...
          (L_delta_a + A_1*N_delta_a)/(1 + A_1*B_1),   (L_delta_r + A_1*N_delta_r)/(1 + A_1*B_1); ...
          0,                                           0;
          (N_delta_a + B_1*L_delta_a)/(1 + A_1*B_1),   (N_delta_r + B_1*L_delta_r)/(1 + A_1*B_1); ...
          0,                                           0 ]











