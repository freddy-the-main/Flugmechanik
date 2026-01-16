clear 
clc


run A_2_5_StateSpace2TransferFunction.m


%aileron: t0 = 0, t1 = 0.8 deg
%ruder: t0 = 0, t1 = 1.2 deg

ruderStep = deg2rad(1.2);
aileronStep = deg2rad(0.8);

%% TFs:
% this matrix expects the state vector to be: [beta; phi_dot; phi; Psi_dot]
% and input vectors to be: [delta_a; delta_r]
[TF_lat_delta_a_num TF_lat_delta_a_denom]= ss2tf(A_lat,B_lat,eye(4,4),zeros(4,2),1);
TF_delta_a2psi_dot = tf(TF_lat_delta_a_num(4,:),TF_lat_delta_a_denom);


[TF_lat_delta_r_num TF_lat_delta_r_denom]= ss2tf(A_lat,B_lat,eye(4,4),zeros(4,2),2);
TF_delta_r2psi_dot = tf(TF_lat_delta_r_num(4,:),TF_lat_delta_r_denom);



A_2_7_TFBasedSimulationslx

