clear 
clc



%% Reference Geometry
S = 174;        %(ft2)
T = 4.9;        %(ft)
b = 36;          %(ft)


%% Flight Condition Data
h = 0;          %Altitude, h (ft)
M = 0.096;      %Mach Number,M
U_l = 107.1;    %TAS, U_l (ft/sec)
q_bar = 13.6;   %Dynamic pressure, q_bar (Ibs/ft2)
c_bar = 0.264;  %C.G. location, fraction ©
alpha_l = 4;    %angle of attack, o, (deg)


%% Mass Data
W = 2650;       %(Ibs)
I_xx = 948;     %(slugft2)
I_yy = 1346;    %(slugfi2)
I_zz = 1967;    %(slugft2)
I_xz = 0;       %(slugft2)



%% Flight Condition

%% steady state Coefficients
C_L = 1.120;
C_D = 0.132;
C_T_x = 0.132;
C_m = 0;
C_m_T = 0;

%% Longitudinal Coefficients and Stability Derivatives (Stability Axes, Dimensionless)
C_D_0 = 0.0605; %daneben stand C_W_0? aber warum??
C_D_u = 0;
C_C_alpha = 0.547;
C_T_x_u = -0.396;
C_L_0 = 0.807;
C_L_u = 0;
C_L_alpha = 4.41;
C_L_alphap = 1.7;
C_L_q = 3.9;
C_m_0 = 0.09;
C_m_u = 0;
C_m_alpha = -0.611;
C_m_alphap = -5.40;
C_m_q = -11.4;
C_m_T_u = 0;
C_m_T_alpha = 0;

%% Longitudinal Control and Hinge Moment Derivatives (Stability Axes, 1/rad)
C_D_delta_e = 0;
C_L_delta_e = 0.43;
C_m_delta_e = -1.029;

%% Longitudinal Control and Hinge Moment Derivatives: Cont'd (Stability Axes, 1/rad)
C_h_q = -0.0549; % konnte es nicht genau lesen obs q oder alpha ist
C_h_delat_u = -0.594; %konnte auch nich genau lesen was das jetzt war


%% Lateral-Directional Stability Derivatives (Stability Axes, Dimensionless)
C_l_beta = -0.0969;  
C_l_p = -0.494; % sehr schwer lesbar, weiss nicht ob roh oder p
C_l_r = 0.2039; % sehr schwer lesbar, weiss nicht ob
C_y_beta = -0.303;
C_y_p = -0.213;
C_y_r = 0.201;
C_n_beta = 0.0701;
C_n_T_beta = 0;
C_n_p = -0.0960;
C_n_r = -0.1151;


%% Lateral-Directional Control and Hinge Moment Derivatives (Stability Axes, Dimensionless)
C_l_delta_a​​ = 0.229; %Rollmomentbeiwert pro Querruderausschlag (Aileron)
C_l_delta_r = 0.0147; %Rollmomentbeiwert pro Seitenruderausschlag (Rudder)??????????
C_y_delta_a = 0; %Seitenkraftbeiwert pro QuerruderausschlagSeitenkraftbeiwert pro Querruderausschlag??????????
C_y_delta_r = 0.187; %Seitenkraftbeiwert pro Seitenruderausschlag??????????
C_n_delta_a = -0.0786; %Giermomentbeiwert pro Querruderausschlag??????????
C_n_delta_r = -0.0604; %Giermomentbeiwert pro Seitenruderausschlag??????????
C_h_alpha_a = nan; %Scharniermomentbeiwert des Querruders pro Querruderausschlag??????????
C_h_delta_a = -0.369; %Scharniermomentbeiwert pro Schiebewinkel beta??????????
C_h_beta_v= 0.0819; %???????????
C_h_delta_r = -0.579; %Scharniermomentbeiwert pro Seitenruderausschlag??????????




%% Longitudinal Transfer Function Data

Altitude = 5000; % ft
U_1 = 130.39 %kts
W_current = 2650.0 %lb
S_W = 174.00 %ft^2
C_bar = 4.90 %ft
Iyy_B = 1346 %slgft2
C_m_1 = 0.0000
C_m_u = 0.0000
C_m_a = -0.6130 %1/rad
C_m_a.dot = -7.2700 %1/rad
C_m_q = -12.4000 %1/rad
C_m_T_1 = 0.0000
C_m_T_u = 0.0000
C_m_T_a = 0.0000
C_L_1 = 0.3070
C_L_u = 0.0000
C_L_a = 4.4100 %1/rad
C_L_a.dot = 1.7000 %1/rad
C_L_q = 3.9000 %1/rad
C_D_1 = 0.0320
C_D_a = 0.1210 %1/rad
C_D_u = 0.0000
C_T_X_1 = 0.0320
C_T_X_u = -0.0960
C_L_d_e = 0.4300 %1/rad
C_D_d_e = 0.0000 %1/rad
C_m_d_e = -1.1220 %1/rad

M_1 = 0.201
n = 1.00 %g
q_bar = 49.60 %psf
(W/S)_TO = 15.23 %psf
Theta_1 = 0.00 %deg
X_u = -0.0304 %1/s
X_T_u = -0.0152 %1/s
X_a = 19.4588 %ft/s^2
Z_u = -0.2919 %1/s
Z_a = -464.7095 %ft/s^2
Z_a_dot = -1.9799 %ft/s
Z_q = -4.5422 %ft/s
M_u = 0.0000 %1/ft/s
M_T_u = 0.0000 %1/ft/s
M_a = -19.2591 %1/s^2
M_T_a = 0.0000 %1/s^2
M_a_dot = -2.5428 %1/s
M_q = -4.3370 %1/s

w_n_SP = 5.2707 %rad/s
z_SP = 0.8442
w_n_P = 0.1711 %rad/s
z_p = 0.1289
X_del_e = 0.0000 %ft/s^2
Z_del_e = -44.9854 %ft/s^2











