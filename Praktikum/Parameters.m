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
C_m_delta_e = -1.029:

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
C_l
0.229
0.229
0.229
C l r
0.0147
0.0147
0.0147
0
C y 2
0
0
C y r
0.187
0.187
0.187
C n d 2
-0.0504
-0.0216
-0.0786
C n delta t
-0.0805
-0.0645
-0.0604
C b 2
???
???
???
Ch
-0.369
-0.363
-0.369
C h v
0.0819
0.0819
0.0819
C h t
-0.579
-0.567
-0.579
















