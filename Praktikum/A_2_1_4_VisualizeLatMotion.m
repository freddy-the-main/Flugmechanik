clear
clc
clf

run A_2_1_2_Eigenwerte_CP.m

% convention: [Theta_dot; Theta; alpha; u]

u_0 = 1.7;
alpha_0 = deg2rad(1.4);
Theta_dot_0 = deg2rad(2.1);
Theta_0 = deg2rad(-1.2);


B_eq = [Theta_0; Theta_0; alpha_0; u_0];

C_eq = eigVecLong\B_eq;

time = 20;
dt = 0.0001;

t = 0:dt:time;


Theta_dot = C_eq(1) * eigVecLong(1,1) * exp(eigValLat(1,1)*t) + C_eq(2) * eigVecLong(1,2) * exp(eigValLong(2,2)*t) + C_eq(3) * eigVecLong(1,3) * exp(eigValLong(3,3)*t) + C_eq(4) * eigVecLong(1,4) * exp(eigValLong(4,4)*t);
Theta = C_eq(1) * eigVecLong(2,1) * exp(eigValLat(1,1)*t) + C_eq(2) * eigVecLong(2,2) * exp(eigValLong(2,2)*t) + C_eq(3) * eigVecLong(2,3) * exp(eigValLong(3,3)*t) + C_eq(4) * eigVecLong(2,4) * exp(eigValLong(4,4)*t);
alpha = C_eq(1) * eigVecLong(3,1) * exp(eigValLat(1,1)*t) + C_eq(2) * eigVecLong(3,2) * exp(eigValLong(2,2)*t) + C_eq(3) * eigVecLong(3,3) * exp(eigValLong(3,3)*t) + C_eq(4) * eigVecLong(3,4) * exp(eigValLong(4,4)*t);
u = C_eq(1) * eigVecLong(4,1) * exp(eigValLat(1,1)*t) + C_eq(2) * eigVecLong(4,2) * exp(eigValLong(2,2)*t) + C_eq(3) * eigVecLong(4,3) * exp(eigValLong(3,3)*t) + C_eq(4) * eigVecLong(4,4) * exp(eigValLong(4,4)*t);

%% plotting 

clf
subplot(4,1,1)
plot(t,Theta)
title("Theta in rad")

subplot(4,1,2)
plot(t,Theta_dot)
title("Theta dot in rad/s")

subplot(4,1,3)
plot(t,alpha)
title("alpha in rad")

subplot(4,1,4)
plot(t,u)
title("u in m/s")






