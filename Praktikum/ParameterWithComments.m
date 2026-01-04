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


%% Longitudinal Transfer Function Data

% Flugzustand / Trimmpunkt
Altitude = 5000;     %Flughöhe über NN (ft)
U_1 = 130.39;        %getrimmte Fluggeschwindigkeit U0 (knots)
W_current = 2650.0;  %aktuelles Flugzeuggewicht W (lb)
S_W = 174.00;        %Flügelreferenzfläche S (ft^2)
C_bar = 4.90;        %mittlere aerodynamische Tiefe c̄ (ft)
Iyy_B = 1346;        %Trägheitsmoment um Nickachse (slug·ft^2)

%Getrimmte aerodynamische Koeffizienten
C_m_1 = 0.0000;      %Nickmomentbeiwert im Trimmpunkt
C_L_1 = 0.3070;      %Auftriebsbeiwert im Trimmpunkt
C_D_1 = 0.0320;      %Widerstandsbeiwert im Trimmpunkt
C_T_X_1 = 0.0320;    %Schubbeiwert in x-Richtung im Trimmpunkt

%Nickmoment-Ableitungen
C_m_u = 0.0000;      %Nickmomentänderung durch Geschwindigkeitsstörung u
C_m_a = -0.6130;     %Nickmomentbeiwert pro Anstellwinkel α (1/rad)
C_m_a_dot = -7.2700; %Nickmomentbeiwert pro normierter α̇ (1/rad)
C_m_q = -12.4000;    %Nickmomentbeiwert pro Nickrate q (1/rad)

%Nickmoment durch Schub
C_m_T_1 = 0.0000;    %Nickmomentbeitrag durch Schub im Trimmpunkt
C_m_T_u = 0.0000;    %Nickmomentänderung durch Schub bei u
C_m_T_a = 0.0000;    %Nickmomentänderung durch Schub bei α

%Auftriebs-Ableitungen
C_L_u = 0.0000;      %Auftriebsänderung durch Geschwindigkeitsstörung u
C_L_a = 4.4100;      %Auftriebsanstieg pro Anstellwinkel α (1/rad)
C_L_a_dot = 1.7000;  %Auftrieb durch normierte α̇
C_L_q = 3.9000;      %Auftrieb durch Nickrate q

%Widerstands-Ableitungen
C_D_a = 0.1210;      %Widerstandsanstieg pro Anstellwinkel α (1/rad)
C_D_u = 0.0000;      %Widerstandsänderung durch u
C_T_X_u = -0.0960;   %Schubänderung in x-Richtung durch u

%Steuerderivate (Höhenruder)
C_L_d_e = 0.4300;    %Auftriebsbeiwert pro Höhenruderausschlag δe
C_D_d_e = 0.0000;    %Widerstandsbeiwert pro Höhenruderausschlag
C_m_d_e = -1.1220;   %Nickmomentbeiwert pro Höhenruderausschlag

%Weitere Flugzustandsgrößen
M_1 = 0.201;         %Machzahl im Trimmpunkt
n = 1.00;            %Lastvielfaches n (g)
q_bar = 49.60;       %Staudruck q̄ (psf)
(W/S)_TO = 15.23;    %Flächenbelastung W/S (psf)
Theta_1 = 0.00;      %Nickwinkel Θ im Trimmpunkt (deg)

%Linearisierte Kraftableitungen (Dimensional)
X_u = -0.0304;       %x-Kraftänderung durch u (1/s)
X_T_u = -0.0152;     %x-Kraft durch Schubänderung bei u
X_a = 19.4588;       %x-Kraftänderung durch α (ft/s^2)

Z_u = -0.2919;       %z-Kraftänderung durch u (1/s)
Z_a = -464.7095;     %z-Kraftänderung durch α (ft/s^2)
Z_a_dot = -1.9799;   %z-Kraft durch α̇ (ft/s)
Z_q = -4.5422;       %z-Kraft durch Nickrate q (ft/s)

%Linearisierte Momentenableitungen (Dimensional)
M_u = 0.0000;        %Nickmomentänderung durch u (1/(ft·s))
M_T_u = 0.0000;      %Nickmoment durch Schubänderung bei u
M_a = -19.2591;      %Nickmomentänderung durch α (1/s^2)
M_T_a = 0.0000;      %Nickmoment durch Schub bei α
M_a_dot = -2.5428;   %Nickmoment durch α̇ (1/s)
M_q = -4.3370;       %Nickmomentdämpfung durch Nickrate q (1/s)

%Eigenbewegungen (Moden)
w_n_SP = 5.2707;     %Eigenkreisfrequenz der Short-Period-Mode (rad/s)
z_SP = 0.8442;       %Dämpfungsgrad der Short-Period-Mode

w_n_P = 0.1711;      %Eigenkreisfrequenz der Phugoid-Mode (rad/s)
z_p = 0.1289;        %Dämpfungsgrad der Phugoid-Mode

%Steuerkraft-Ableitungen (dimensional)
X_del_e = 0.0000;    %x-Kraft durch Höhenruderausschlag δe (ft/s^2)
Z_del_e = -44.9854;  %z-Kraft durch Höhenruderausschlag δe (ft/s^2)


%% Lateral-Directinal Transfer Function Data

%Flugzustand / Geometrie / Masse
W_current = 2650.0;      % lb
Altitude  = 5000;        % ft
S_w       = 174.00;      % ft^2
U_1       = 130.39;      % kts
Theta_1   = 0.00;        % deg
Alpha     = 0.00;        % deg
b_w       = 36.00;       % ft

I_xx_B = 948;            % slug·ft^2
I_zz_B = 1967;           % slug·ft^2
I_xz_B = 0;              % slug·ft^2

%Dimensionslose laterale Stabilitätsderivate
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

%Dimensionslose Steuerderivate
C_l_d_a =  0.2290;       % 1/rad
C_l_d_r =  0.0147;       % 1/rad

C_n_d_a = -0.0216;       % 1/rad
C_n_d_r = -0.0645;       % 1/rad

C_y_d_a =  0.0000;       % 1/rad
C_y_d_r =  0.1870;       % 1/rad

%Weitere Referenzgrößen
W_S_TO = 15.23;          % psf
q_bar  = 49.60;          % psf
I_xx_S = 948;            % slug·ft^2
I_zz_S = 1967;           % slug·ft^2
I_xz_S = 0;              % slug·ft^2

%Dimensionale Kraft- und Momentenableitungen
Y_B = -41.1146;          % ft/s^2
Y_p = -0.6417;           % ft/s
Y_r =  1.8311;           % ft/s

L_B = -30.2497;          % 1/s^2
L_p = -12.9738;          % 1/s
L_r =  2.1391;           % 1/s

N_B =  9.2717;           % 1/s^2
N_T_B = 0.0000;          % 1/s^2
N_p = -0.3591;           % 1/s
N_r = -1.2105;           % 1/s

%Eigenbewegungen / Zeitkonstanten
w_n_D      = 3.2448;     % rad/s
z_D        = 0.2066;     % -
TC_SPIRAL  = 55.922;     % s
TC_ROLL    = 0.077;      % s
TC_1       = 0.077;      % s
TC_2       = 55.922;     % s

%Steuerkraft-Ableitungen (dimensional)
Y_del_a =  0.0000;       % ft/s^2
Y_del_r = 19.5634;       % ft/s^2

L_del_a = 75.0507;       % 1/s^2
L_del_r =  4.8177;       % 1/s^2

N_del_a = -3.4117;       % 1/s^2
N_del_r = -10.1879;      % 1/s^2



