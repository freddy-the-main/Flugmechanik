clear
clc


run A_2_1_1_EoM_in_StateSpace.m


% The state vector is defined as:
% x = [ beta; phi_dot; phi; Psi_dot ]
%
% The input vector is defined as:
% u = [ delta_a; delta_r ]

psi_dot_filter = zeros(4,4);
psi_dot_filter(4,4) = 1;
% Output selection matrix (C-matrix):
% Selects only the 4th state (yaw rate Psi_dot) as the system output

Tend = 20;
dt = 0.001;
t = 0:dt:Tend;
% Simulation time parameters:
% Tend = total simulation time [s]
% dt   = simulation time step [s]
% t    = time vector

freq = 0.9; % [Hz]
% Excitation frequency of the input signal

inputSignal = deg2rad(2.5) * sin(2*pi*freq*t); % [rad]
% Sinusoidal rudder deflection:
% amplitude = 2.5 degrees (converted to radians)
% frequency = 0.9 Hz

u = [zeros(1, length(inputSignal)); inputSignal];
% Construct the 2-input signal matrix:
% input 1 (aileron, delta_a) = 0
% input 2 (rudder, delta_r)  = sinusoidal excitation

x0 = [0, 0, 0, 0];
% Initial conditions for all state variables

sys_lat = ss(A_lat, B_lat, psi_dot_filter, zeros(4,2));
% Create the lateral-directional state-space system:
% dynamics defined by A_lat and B_lat
% output is yaw rate (Psi_dot)
% no direct feedthrough (D = 0)

[y, t, x] = lsim(sys_lat, u, t, x0);
% Simulate the time response of the system:
% y = output (yaw rate)
% x = full state trajectory


figure(60)

clf
hold on
plot(t, inputSignal)
plot(t, y(:,4))
yline(0)
grid on
xlabel('Time [s]')
ylabel('Signal')
legend('Rudder input \delta_r', 'Yaw rate \psi̇ dot')
% Plot the input signal and the resulting yaw-rate response

%% Bode plot

sys_lat = sys_lat(:,2);
% Select the second input only (rudder input delta_r)

sys_lat = sys_lat(4,:);
% Select the fourth output only (yaw rate Psi_dot)

figure(61)
bode(sys_lat,linspace(0.01, 2*pi*3, 500))
grid on
% Generate the Bode plot of the transfer function:
% rudder deflection (delta_r) → yaw rate (Psi_dot)
