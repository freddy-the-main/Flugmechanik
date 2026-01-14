clear
clc

run A_2_1_1_EoM_in_StateSpace.m

%% longitudinal
% this matirx expects the state vector to be: [phi_dot; phi; alpha; u]
% and input vectors to be: [delta_e]
[TF2_long_num TF_long_denom]= ss2tf(A_long,B_long,eye(4,4),zeros(4,1));
TF_delta_e2alpha = tf(TF2_long_num(3,:),TF_long_denom)


%% Lateral
% this matrix expects the state vector to be: [beta; phi_dot; phi; Psi_dot]
% and input vectors to be: [delta_a; delta_r]
[TF2_lat_delta_a_num TF_lat_delta_a_denom]= ss2tf(A_lat,B_lat,eye(4,4),zeros(4,2),1);
TF_delta_a2phi = tf(TF2_lat_delta_a_num(3,:),TF_lat_delta_a_denom)


[TF2_lat_delta_r_num TF_lat_delta_r_denom]= ss2tf(A_lat,B_lat,eye(4,4),zeros(4,2),2);
TF_delta_r2beta = tf(TF2_lat_delta_r_num(1,:),TF_lat_delta_r_denom)


