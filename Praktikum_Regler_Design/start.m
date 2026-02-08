

%% Conversation factors
cLBS2KG         = 0.453592;                 % conversion factor lbs to kg
cFT2M           = 0.3048;
cFTsq2Msq       = 0.3048 * 0.3048;
cSLUGFTsg2KGMsq = 1.3558179619;             % conversion slug ft² to kg m²
cFTpS2MpS       = 0.3048;                   % conversion ft/s to m/s

%% initializing values
INI.VELbod      = [107.1*cFTpS2MpS 0 0];      % [m/s]
INI.POS(1)      = 0.6564488822984131;       % [rad]
INI.POS(2)      = -2.135559848047296;       % [rad]
INI.POS(3)      = 1500;                    % [m]
INI.EULER       = [0 0 -1.0890];            % [rad]
INI.PQR         = [0 0 0];                  % [rad/s]
INI.mass        = 2650*cLBS2KG;            % [kg]
Ixx             = 948*cSLUGFTsg2KGMsq;    % [kgm²]
Iyy             = 1346*cSLUGFTsg2KGMsq;    % [kgm²]
Izz             = 1967*cSLUGFTsg2KGMsq;    % [kgm²]
Ixz             = 0*cSLUGFTsg2KGMsq;     % [kgm²]
INI.Inertia     = [Ixx 0 -Ixz;0 Iyy 0; -Ixz 0 Izz]; % [kgm²]

%% earth gravity
g = 9.807;

%% simulation sample time [s]
sampletime = 1/100.0;


open('Aufgabe2_10.slx')