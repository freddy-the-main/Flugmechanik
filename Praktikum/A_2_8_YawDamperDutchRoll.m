clear
clc
% Clear workspace and command window to start with a clean environment

run ParameterInSI.m
% Load aircraft and aerodynamic parameters in SI units
% (e.g. Y_beta, Y_r, N_beta, N_r, control derivatives, airspeed U_1, etc.)

% Convention for the state vector:
% x = [ beta; psi_dot ]
% beta     = sideslip angle
% psi_dot  = yaw rate

A = [ Y_beta/U_1      (Y_r/U_1) - 1; ...
      N_beta          N_r ];
% State matrix of the simplified Dutch-roll model
% First row: sideslip dynamics
% Second row: yaw-rate dynamics

B = [ Y_delta_r/U_1; ...
      (N_delta_r + B_1*L_delta_r)/(1 + A_1*B_1) ];
% Input matrix (rudder input delta_r)
% First entry: side-force contribution of rudder
% Second entry: yaw-moment contribution of rudder
% Includes coupling terms (A_1, B_1) from the aircraft model

C = eye(2,2);
% Output matrix: both states (beta and psi_dot) are measured

D = zeros(2,1);
% No direct feedthrough from input to output

sys = ss(A, B, C, D);
% Construct the state-space system for the open-loop Dutch-roll dynamics

% --------------------------------------------------
% Characteristic polynomial (open-loop system)
% --------------------------------------------------

CP_wo_Controller = poly(A);
% Compute the characteristic polynomial of the open-loop system matrix A
% For a 2nd-order system: s^2 + a1*s + a0

D_wo_Controller = CP_wo_Controller(2) / ...
                  (2 * sqrt(CP_wo_Controller(3)))
% Compute the damping ratio (Dämpfungsgrad) from the characteristic polynomial
% For s^2 + a1*s + a0:
%   zeta = a1 / (2*sqrt(a0))

% Required: D ≥ 0.19 to satisfy Level 1 handling-quality criteria

% --------------------------------------------------
% State-space system with yaw damper (state feedback)
% --------------------------------------------------

%% Calculate feedback gain k

syms k
% Define symbolic variable for the yaw-damper gain

CP_sym = charpoly(A - B*[0 k]);
% Compute the symbolic characteristic polynomial of the closed-loop system
% Feedback law assumed:
%   delta_r = -k * psi_dot
% Hence feedback vector = [0  k]

eq = 0.19 == CP_sym(2) / (2 * sqrt(CP_sym(3)));
% Define equation enforcing the required damping ratio (zeta = 0.19)

k = double(solve(eq))
% Solve the equation for the feedback gain k and convert to numeric value

% --------------------------------------------------
% Verification of the controller design
% --------------------------------------------------

A_wi_controller = A - (B*[0 k]);
% Closed-loop system matrix with yaw-rate feedback

sys_FSF = ss(A_wi_controller, B, C, D);
% State-space model of the closed-loop system

CP_wi_Controller = poly(A_wi_controller);
% Characteristic polynomial of the closed-loop system

D_wi_Controller = CP_wi_Controller(2) / ...
                  (2 * sqrt(CP_wi_Controller(3)))
% Compute the resulting damping ratio of the closed-loop Dutch-roll mode
% Used to verify that the Level 1 requirement is satisfied
