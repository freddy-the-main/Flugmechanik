clear 
clc

run A_2_1_1_EoM_in_StateSpace.m;


% Eigenwerte

[eigVecLong, eigValLong] = eig(A_long)
[eigVecLat, eigValLat] = eig(A_lat)

% CP
charPolyLong = poly(A_long)
charPolyLat = poly(A_lat)





