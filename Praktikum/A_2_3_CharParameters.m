clear
clc

run A_2_2_2_Mode_of_Motion.m
% Execute the script that computes the motion modes and eigenvalues
% In particular, it defines the variable "DutchRoll",
% which contains the complex eigenvalues of the Dutch roll mode

DampingCoefficent = real(DutchRoll(1));
% Extract the real part of the Dutch roll eigenvalue
% This corresponds to the exponential decay (damping) term σ

omega = imag(DutchRoll(1));
% Extract the imaginary part of the Dutch roll eigenvalue
% This corresponds to the oscillation frequency ω_d (damped natural frequency)

omega_0 = sqrt(DampingCoefficent^2 + omega^2);
% Compute the undamped natural frequency ω_0
% Relation: ω_0 = sqrt(σ^2 + ω_d^2)

DampingFactor = -DampingCoefficent / omega_0;
% Compute the damping ratio ζ
% Negative sign ensures a positive damping ratio for stable modes

Period = 2 * pi / omega;
% Compute the oscillation period of the Dutch roll mode
% T = 2π / ω_d
