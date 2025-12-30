clear
clc



rho = 1.225;
Vw = 4; %windspeed

%[general aircraft, Jet]
m = [1248 57153];
V = [137 247];
S = [17 184.8];
CLa = [4.44 4.52];
q = 0.5 * rho * V.^2;

tau = (V.*m) ./ (CLa .* q .* S)
