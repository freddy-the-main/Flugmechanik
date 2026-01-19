clear; clc
%  Parameters
Fmax    = 2500;         % maximum engine thrust [N]
mu      = 3.2;       	% engine bypass ratio
rho_0   = 1.225;     	% air density at sea level [kg/m³]
P_0     = 101325;     	% static air pressure at sea level [Pa]

% Variables 
D       = 85;           % throttle lever position [%]  
rho     = 0.37;         % air density at flight level [kg/m³]
Ma      = 0.64;         % Mach number
P       = 92000;        % static pressure at flight altitude [Pa]

% Code
% engine thrust [N]
F = Fmax * (D / 100) * (rho / rho_0) * exp(-0.35 * Ma * (P / P_0) * sqrt(mu));