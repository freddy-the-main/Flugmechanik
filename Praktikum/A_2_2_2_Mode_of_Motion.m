clear 
clc

run A_2_2_1_PolesOnSPlane.m

%% modes of motion longitudinal
% phugoid (long Period oscillations)
phugoid = [eigValLong(3,3);eigValLong(4,4)]

%short period oscillations
shortPeriod = [eigValLong(1,1);eigValLong(2,2)]


%% modes of motion Lateral
%roll subsidence
RollSubsidence = eigValLat(1,1)

%Dutch roll mode
DutchRoll = [eigValLat(2,2); eigValLat(3,3)]

%spiral divergence
SpiralDivergence = eigValLat(4,4)

