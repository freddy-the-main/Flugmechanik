clear
clc



%% Reference Geometry

S = 174;        %Flügelreferenzfläche S (ft^2)
T = 4.9;        %mittlere aerodynamische Tiefe c̄ (ft)
b = 36;         %Spannweite b (ft)


%% Flight Condition Data
h = 0;          %Flughöhe h (ft)
M = 0.096;      %Machzahl M
U_l = 107.1;    %wahre Fluggeschwindigkeit (TAS) U0 (ft/s)
q_bar = 13.6;   %Staudruck q̄ = ½ρU0² (lb/ft²)
c_bar = 0.264;  %Schwerpunktlage x_cg/c̄ (dimensionslos)
alpha_l = 4;    %Anstellwinkel α (deg)


%% Mass DataMass Data
W = 2650;       %Flugzeuggewicht W (lb)
I_xx = 948;     %Massenträgheitsmoment um x-Achse (Roll) (slug·ft²)
I_yy = 1346;    %Massenträgheitsmoment um y-Achse (Pitch) (slug·ft²)
I_zz = 1967;    %Massenträgheitsmoment um z-Achse (Yaw) (slug·ft²)
I_xz = 0;       %Produkträgheitsmoment I_xz (slug·ft²)


%% Steady-State Aerodynamic Coefficients
C_L = 1.120;    %Auftriebsbeiwert im Trimm
C_D = 0.132;    %Widerstandsbeiwert im Trimm
C_T_x = 0.132;  %Schubbeiwert in x-Richtung
C_m = 0;        %Nickmomentbeiwert im Trimm
C_m_T = 0;      %Nickmomentbeitrag durch Schub


%% Longitudinal Stability Derivatives (Stability Axes)
C_D_0 = 0.0605;     %Nullwiderstandsbeiwert (parasitären Widerstand)
C_D_u = 0;          %Ableitung des Widerstands nach Geschwindigkeitsstörung u

C_C_alpha = 0.547;  %axialer Kraftbeiwert pro Anstellwinkel (Stability Axes)

C_T_x_u = -0.396;   %Schubbeiwert-Ableitung nach u

C_L_0 = 0.807;      %Auftriebsbeiwert bei α = 0
C_L_u = 0;          %Auftriebsänderung durch Geschwindigkeitsstörung
C_L_alpha = 4.41;   %Auftriebsanstieg pro Anstellwinkel (1/rad)
C_L_alphap = 1.7;   %Auftrieb pro normierter α-Rate (α̇)
C_L_q = 3.9;        %Auftrieb pro Nickrate q

C_m_0 = 0.09;       %Nickmomentbeiwert bei α = 0
C_m_u = 0;          %Nickmomentänderung durch u
C_m_alpha = -0.611; %Nickmomentanstieg pro Anstellwinkel
C_m_alphap = -5.40; %Nickmoment pro normierter α-Rate
C_m_q = -11.4;      %Nickmoment pro Nickrate q

C_m_T_u = 0;        %Nickmoment durch Schubänderung u
C_m_T_alpha = 0;    %Nickmoment durch Schub bei α-Änderung


%% Longitudinal Control Derivatives
C_D_delta_e = 0;        %Widerstandsbeiwert pro Höhenruderausschlag δe
C_L_delta_e = 0.43;    %Auftriebsbeiwert pro Höhenruderausschlag
C_m_delta_e = -1.029;  %Nickmomentbeiwert pro Höhenruderausschlag


%% Longitudinal Hinge-Moment Derivatives
C_h_q = -0.0549;       %Höhenruderscharniermoment pro Nickrate q
C_h_delat_u = -0.594;  %Höhenruderscharniermoment pro Geschwindigkeitsstörung u


%% Lateral-Directional Stability Derivatives
C_l_beta = -0.0969;    %Rollmoment pro Schiebewinkel β (Dihedral-Effekt)
C_l_p = -0.494;        %Rollmomentdämpfung durch Rollrate p
C_l_r = 0.2039;        %Rollmoment durch Gierbewegung r

C_y_beta = -0.303;     %Seitenkraft pro Schiebewinkel β
C_y_p = -0.213;        %Seitenkraft durch Rollrate p
C_y_r = 0.201;         %Seitenkraft durch Gierbewegung r

C_n_beta = 0.0701;     %Giermoment pro Schiebewinkel (Richtungsstabilität)
C_n_T_beta = 0;        %Giermoment durch Schub bei β
C_n_p = -0.0960;       %Giermoment durch Rollrate p
C_n_r = -0.1151;       %Gierdämpfung durch Gierbewegung r


%% Lateral-Directional Control and Hinge Moment Derivatives

C_l_delta_a = 0.229;   %Rollmomentbeiwert pro Querruderausschlag δa
C_l_delta_r = 0.0147;  %Rollmomentbeiwert pro Seitenruderausschlag δr

C_y_delta_a = 0;       %Seitenkraftbeiwert pro Querruderausschlag
C_y_delta_r = 0.187;   %Seitenkraftbeiwert pro Seitenruderausschlag

C_n_delta_a = -0.0786; %Giermomentbeiwert pro Querruderausschlag (adverse yaw)
C_n_delta_r = -0.0604; %Giermomentbeiwert pro Seitenruderausschlag

C_h_alpha_a = NaN;     %Querruderscharniermoment pro Anstellwinkel α
C_h_delta_a = -0.369;  %Querruderscharniermoment pro Querruderausschlag
C_h_beta_v = 0.0819;   %Seitenruderscharniermoment pro Schiebewinkel β
C_h_delta_r = -0.579;  %Seitenruderscharniermoment pro Seitenruderausschlag






Altitude = 5000; % ft
U_1

M_1
0.201
130.39 kts
n 1.00 g
W_current = 2650.0 lb
q_bar
49.60 psf
S_W
174.00 ft^2
(W/S)_TO
15.23 psf
Theta_1
0.00 deg
X_u
-0.0304 1/s
C_bar
4.90 ft
X_T_u
-0.0152 1/s
Iyy_B
=
1346 slgft2
X_a
19.4588 ft/s^2
C_m_1
0.0000
2_u
-0.2919 1/s
C_m_u
=
0.0000
2_a
=
C_m_a
-0.6130 1/rad
Z_a_dot
C_m_a.dot =
-7.2700 1/rad
29
=
C_m_q
=
-12.4000 1/rad
M_u
C_m_T_1
0.0000
M_T_u
-464.7095 ft/s^2
-1.9799 ft/s
-4.5422 ft/s
0.0000 1/ft/s
0.0000 1/ft/s
C_m_T_u 0.0000
M_a
=
-19.2591 1/s^2
C_m_T_a =
0.0000
C_L_1
0.3070
M_T_a
M_a_dot
0.0000 1/s^2
-2.5428
1/s
C_L_u =
0.0000
M_q
-4.3370 1/s
C_L_a
=
4.4100 1/rad
C_L_a.dot =
1.7000 1/rad
C_L_q
=
3.9000 1/rad
C_D_1
0.0320
C_D_a
= 0.1210 1/rad
w_n_SP
5.2707 rad/s
C_D_u
0.0000
Z_SP
0.8442
C_T_X_1
0.0320
w_n_P
0.1711 rad/s
C_T_X_u =
-0.0960
0.1289
C_L_d_e
0.4300 1/rad
X_del_e
=
0.0000 ft/s^2
C_D_d_e
=
0.0000 1/rad
Z_del_e
-44.9854 ft/s^2
C_m_d_e
=
-1.1220 1/rad
M_del_e
-35.2508 1/s^2









