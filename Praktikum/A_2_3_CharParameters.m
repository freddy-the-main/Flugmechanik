clear 
clc

run A_2_2_2_Mode_of_Motion.m


DampingCoefficent = real(DutchRoll(1))

omega = imag(DutchRoll(1))

omega_0 = sqrt(DampingCoefficent^2 + omega^2)

DampingFactor = -DampingCoefficent/omega_0;

Period = 2 * pi /  omega 