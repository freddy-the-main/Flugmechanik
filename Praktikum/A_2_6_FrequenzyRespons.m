clear 
clc

run A_2_1_1_EoM_in_StateSpace.m
% this matrix expects the state vector to be: [beta; phi_dot; phi; Psi_dot]
% and input vectors to be: [delta_a; delta_r]
psi_dot_filter = zeros(4,4);
psi_dot_filter(4,4) = 1;

Tend = 20;
dt = 0.001;
t = 0:dt:Tend; 

freq = 0.9; %[hz]

inputSignal = deg2rad(2.5)*sin(2*pi*freq*t); %[hz]

u = [zeros(1,length(inputSignal));inputSignal];

x0 = [0,0,0,0];

sys_lat = ss(A_lat,B_lat,psi_dot_filter,zeros(4,2))

[y, t, x] = lsim(sys_lat, u, t, x0);

clf
hold on 
plot(t,inputSignal)
plot(t,x0(4)')
yline(0)

%bode plot

sys_lat = sys_lat(:,2)
sys_lat = sys_lat(4,:)

figure(2)
bode(sys_lat)

% clf
% hold on
% plot(t,x(:,1))
% plot(t,x(:,2))
% plot(t,x(:,3))
% plot(t,x(:,4))