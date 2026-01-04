clear
clc

%% Conversion Factors
ft_to_m = 0.3048;
ft2_to_m2 = 0.092903;
slug_to_kg = 14.5939;
slug_ft2_to_kg_m2 = 0.0421401; % slug·ft² → kg·m²
lb_to_N = 4.44822;
lb_ft2_to_N_m2 = 47.8803; % lb/ft² → N/m²
kts_to_ms = 0.514444;
deg_to_rad = pi/180;

%% Reference Geometry
S = 174 * ft2_to_m2;          % Wing reference area (m²)
T = 4.9 * ft_to_m;            % Mean aerodynamic chord (m)
b = 36 * ft_to_m;             % Wingspan (m)

%% Flight Condition Data
h = 0 * ft_to_m;              % Flight altitude (m)
M = 0.096;                    % Mach number (dimensionless)
U_l = 107.1 * ft_to_m;        % True airspeed (m/s)
q_bar = 13.6 * lb_ft2_to_N_m2; % Dynamic pressure (N/m²)
c_bar = 0.264;                % CG position x_cg/c̄ (dimensionless)
alpha_l = 4 * deg_to_rad;     % Angle of attack (rad)

%% Mass Data
W = 2650 * lb_to_N;           % Aircraft weight (N)
I_xx = 948 * slug_ft2_to_kg_m2; % Roll moment of inertia (kg·m²)
I_yy = 1346 * slug_ft2_to_kg_m2; % Pitch moment of inertia (kg·m²)
I_zz = 1967 * slug_ft2_to_kg_m2; % Yaw moment of inertia (kg·m²)
I_xz = 0 * slug_ft2_to_kg_m2;    % Product of inertia (kg·m²)

%% Steady-State Aerodynamic Coefficients
C_L = 1.120;    % Lift coefficient in trim
C_D = 0.132;    % Drag coefficient in trim
C_T_x = 0.132;  % Thrust coefficient in x-direction
C_m = 0;        % Pitch moment coefficient in trim
C_m_T = 0;      % Pitch moment contribution from thrust

%% Longitudinal Stability Derivatives (Stability Axes)
C_D_0 = 0.0605;     % Zero-lift drag coefficient
C_D_u = 0;          % Drag derivative with respect to u

C_C_alpha = 0.547;  % Axial force coefficient per angle of attack

C_T_x_u = -0.396;   % Thrust coefficient derivative with respect to u

C_L_0 = 0.807;      % Lift coefficient at α = 0
C_L_u = 0;          % Lift change due to u
C_L_alpha = 4.41;   % Lift curve slope (1/rad)
C_L_alphap = 1.7;   % Lift per normalized α rate
C_L_q = 3.9;        % Lift per pitch rate q

C_m_0 = 0.09;       % Pitch moment coefficient at α = 0
C_m_u = 0;          % Pitch moment change due to u
C_m_alpha = -0.611; % Pitch moment slope (1/rad)
C_m_alphap = -5.40; % Pitch moment per normalized α rate
C_m_q = -11.4;      % Pitch moment per pitch rate q

C_m_T_u = 0;        % Pitch moment from thrust change due to u
C_m_T_alpha = 0;    % Pitch moment from thrust due to α change

%% Longitudinal Control Derivatives
C_D_delta_e = 0;        % Drag coefficient per elevator deflection δe
C_L_delta_e = 0.43;     % Lift coefficient per elevator deflection
C_m_delta_e = -1.029;   % Pitch moment coefficient per elevator deflection

%% Longitudinal Hinge-Moment Derivatives
C_h_q = -0.0549;        % Elevator hinge moment per pitch rate q
C_h_delat_u = -0.594;   % Elevator hinge moment per velocity disturbance u

%% Lateral-Directional Stability Derivatives
C_l_beta = -0.0969;     % Roll moment per sideslip angle β
C_l_p = -0.494;         % Roll damping per roll rate p
C_l_r = 0.2039;         % Roll moment per yaw rate r

C_y_beta = -0.303;      % Side force per sideslip angle β
C_y_p = -0.213;         % Side force per roll rate p
C_y_r = 0.201;          % Side force per yaw rate r

C_n_beta = 0.0701;      % Yaw moment per sideslip angle
C_n_T_beta = 0;         % Yaw moment from thrust due to β
C_n_p = -0.0960;        % Yaw moment per roll rate p
C_n_r = -0.1151;        % Yaw damping per yaw rate r

%% Lateral-Directional Control and Hinge Moment Derivatives
C_l_delta_a = 0.229;    % Roll moment coefficient per aileron deflection δa
C_l_delta_r = 0.0147;   % Roll moment coefficient per rudder deflection δr

C_y_delta_a = 0;        % Side force coefficient per aileron deflection
C_y_delta_r = 0.187;    % Side force coefficient per rudder deflection

C_n_delta_a = -0.0786;  % Yaw moment coefficient per aileron deflection
C_n_delta_r = -0.0604;  % Yaw moment coefficient per rudder deflection

C_h_alpha_a = NaN;      % Aileron hinge moment per angle of attack α
C_h_delta_a = -0.369;   % Aileron hinge moment per aileron deflection
C_h_beta_v = 0.0819;    % Rudder hinge moment per sideslip angle β
C_h_delta_r = -0.579;   % Rudder hinge moment per rudder deflection

%% Longitudinal Transfer Function Data
Altitude = 5000 * ft_to_m;     % Flight altitude (m)
U_1 = 130.39 * kts_to_ms;      % Trimmed flight speed (m/s)
W_current = 2650 * lb_to_N;    % Current aircraft weight (N)
S_W = 174 * ft2_to_m2;         % Wing reference area (m²)
C_bar = 4.9 * ft_to_m;         % Mean aerodynamic chord (m)
Iyy_B = 1346 * slug_ft2_to_kg_m2; % Pitch moment of inertia (kg·m²)

% Trimmed aerodynamic coefficients
C_m_1 = 0.0000;      % Pitch moment coefficient in trim
C_L_1 = 0.3070;      % Lift coefficient in trim
C_D_1 = 0.0320;      % Drag coefficient in trim
C_T_X_1 = 0.0320;    % Thrust coefficient in x-direction in trim

% Pitch moment derivatives
C_m_u = 0.0000;      % Pitch moment change due to u
C_m_a = -0.6130;     % Pitch moment coefficient per α (1/rad)
C_m_a_dot = -7.2700; % Pitch moment coefficient per normalized α̇ (1/rad)
C_m_q = -12.4000;    % Pitch moment coefficient per pitch rate q (1/rad)

% Pitch moment from thrust
C_m_T_1 = 0.0000;    % Pitch moment contribution from thrust in trim
C_m_T_u = 0.0000;    % Pitch moment change from thrust due to u
C_m_T_a = 0.0000;    % Pitch moment change from thrust due to α

% Lift derivatives
C_L_u = 0.0000;      % Lift change due to u
C_L_a = 4.4100;      % Lift curve slope (1/rad)
C_L_a_dot = 1.7000;  % Lift per normalized α̇
C_L_q = 3.9000;      % Lift per pitch rate q

% Drag derivatives
C_D_a = 0.1210;      % Drag increase per α (1/rad)
C_D_u = 0.0000;      % Drag change due to u
C_T_X_u = -0.0960;   % Thrust change in x-direction due to u

% Control derivatives (elevator)
C_L_d_e = 0.4300;    % Lift coefficient per elevator deflection δe
C_D_d_e = 0.0000;    % Drag coefficient per elevator deflection
C_m_d_e = -1.1220;   % Pitch moment coefficient per elevator deflection

% Additional flight condition parameters
M_1 = 0.201;         % Mach number in trim
n = 1.00;            % Load factor n (g)
q_bar = 49.60 * lb_ft2_to_N_m2; % Dynamic pressure (N/m²)
bracket_W_S_bracket_TO = 15.23 * lb_ft2_to_N_m2; % Wing loading (N/m²)
Theta_1 = 0.00 * deg_to_rad; % Pitch angle in trim (rad)

% Linearized force derivatives (dimensional)
X_u = -0.0304;       % x-force change due to u (1/s)
X_T_u = -0.0152;     % x-force from thrust change due to u
X_a = 19.4588 * ft_to_m; % x-force change due to α (m/s²)

Z_u = -0.2919;       % z-force change due to u (1/s)
Z_a = -464.7095 * ft_to_m; % z-force change due to α (m/s²)
Z_a_dot = -1.9799 * ft_to_m; % z-force per α̇ (m/s)
Z_q = -4.5422 * ft_to_m; % z-force per pitch rate q (m/s)

% Linearized moment derivatives (dimensional)
M_u = 0.0000;        % Pitch moment change due to u (1/(m·s))
M_T_u = 0.0000;      % Pitch moment from thrust change due to u
M_a = -19.2591;      % Pitch moment change due to α (1/s²)
M_T_a = 0.0000;      % Pitch moment from thrust due to α
M_a_dot = -2.5428;   % Pitch moment per α̇ (1/s)
M_q = -4.3370;       % Pitch damping per pitch rate q (1/s)

% Eigenmodes
w_n_SP = 5.2707;     % Short-period natural frequency (rad/s)
z_SP = 0.8442;       % Short-period damping ratio

w_n_P = 0.1711;      % Phugoid natural frequency (rad/s)
z_p = 0.1289;        % Phugoid damping ratio

% Control force derivatives (dimensional)
X_del_e = 0.0000;    % x-force per elevator deflection δe (m/s²)
Z_del_e = -44.9854 * ft_to_m; % z-force per elevator deflection δe (m/s²)

%% Lateral-Directinal Transfer Function Data
W_current = 2650 * lb_to_N;      % N
Altitude  = 5000 * ft_to_m;      % m
S_w       = 174 * ft2_to_m2;     % m²
U_1       = 130.39 * kts_to_ms;  % m/s
Theta_1   = 0.00 * deg_to_rad;   % rad
Alpha     = 0.00 * deg_to_rad;   % rad
b_w       = 36 * ft_to_m;        % m

I_xx_B = 948 * slug_ft2_to_kg_m2;     % kg·m²
I_zz_B = 1967 * slug_ft2_to_kg_m2;    % kg·m²
I_xz_B = 0 * slug_ft2_to_kg_m2;       % kg·m²

% Dimensionless lateral stability derivatives
C_l_B   = -0.0923;       % 1/rad
C_l_p   = -0.4840;       % 1/rad
C_l_r   =  0.0798;       % 1/rad

C_n_B   =  0.0587;       % 1/rad
C_n_T_B =  0.0000;       % 1/rad
C_n_p   = -0.0278;       % 1/rad
C_n_r   = -0.0937;       % 1/rad

C_y_B   = -0.3930;       % 1/rad
C_y_p   = -0.0750;       % 1/rad
C_y_r   =  0.2140;       % 1/rad

% Dimensionless control derivatives
C_l_d_a =  0.2290;       % 1/rad
C_l_d_r =  0.0147;       % 1/rad

C_n_d_a = -0.0216;       % 1/rad
C_n_d_r = -0.0645;       % 1/rad

C_y_d_a =  0.0000;       % 1/rad
C_y_d_r =  0.1870;       % 1/rad

% Additional reference parameters
W_S_TO = 15.23 * lb_ft2_to_N_m2;    % N/m²
q_bar  = 49.60 * lb_ft2_to_N_m2;    % N/m²
I_xx_S = 948 * slug_ft2_to_kg_m2;   % kg·m²
I_zz_S = 1967 * slug_ft2_to_kg_m2;  % kg·m²
I_xz_S = 0 * slug_ft2_to_kg_m2;     % kg·m²

% Dimensional force and moment derivatives
Y_B = -41.1146 * ft_to_m;          % m/s²
Y_p = -0.6417 * ft_to_m;           % m/s
Y_r =  1.8311 * ft_to_m;           % m/s

L_B = -30.2497;                    % 1/s²
L_p = -12.9738;                    % 1/s
L_r =  2.1391;                     % 1/s

N_B =  9.2717;                     % 1/s²
N_T_B = 0.0000;                    % 1/s²
N_p = -0.3591;                     % 1/s
N_r = -1.2105;                     % 1/s

% Eigenmodes / Time constants
w_n_D      = 3.2448;               % rad/s
z_D        = 0.2066;               % -
TC_SPIRAL  = 55.922;               % s
TC_ROLL    = 0.077;                % s
TC_1       = 0.077;                % s
TC_2       = 55.922;               % s

% Control force derivatives (dimensional)
Y_del_a =  0.0000 * ft_to_m;       % m/s²
Y_del_r = 19.5634 * ft_to_m;       % m/s²

L_del_a = 75.0507;                 % 1/s²
L_del_r =  4.8177;                 % 1/s²

N_del_a = -3.4117;                 % 1/s²
N_del_r = -10.1879;                % 1/s²

% Display SI units summary
disp('=== CONVERSION TO SI UNITS COMPLETE ===');
disp(['Wing area: ' num2str(S) ' m²']);
disp(['Wingspan: ' num2str(b) ' m']);
disp(['Weight: ' num2str(W) ' N']);
disp(['Dynamic pressure: ' num2str(q_bar) ' N/m²']);
disp(['Flight speed: ' num2str(U_1) ' m/s']);
disp(['Altitude: ' num2str(Altitude) ' m']);