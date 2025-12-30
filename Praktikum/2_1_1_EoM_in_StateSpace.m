clear 
clc


%% system Matrix (A_long) and input Matrix (C_long) for longitudinal motion
M_q = ;
Z_q = ;
U_1 = ;
Z_alphap = ;
M_alpha =  ;
Thetha_R = ;
g = ;
M_Talpha = ;
X_alpha = ;
X_u = ;
X_Tu = ;
M_u = ; 
M_Tu = ;
Z_u = ;

M_delta_e = ;
Z_delta_e = ;



A_long = [(M_q + (Z_q+U_1)/(U_1-Z_alphap) * M_alpha)    ((-sin(Theta_R)*g*M_alpha)/(U_1-Z_alphap))  (M_alpha + M_Talpha + (Z_alpha*M_alpha)/(U_1-Z_alphap))     (M_u + M_Tu + (Z_u *M_alpha)/(U_1 - Z_alphap)); ...
          1 0 0 0;...
          ((Z_q + U_1)/(U_1 - Z_alphap))                -((sin(Theta_R)*g)/(U_1 - Z_alphap))        (Z_alpha/(U_1 - Z_alpha))                                   (Z_u/(U_1 - Z_alphap));...
          0                                             -(cos(Theta_R)*g)                           X_alpha                                                     (X_u + X_Tu)]



c_long = [(M_delta_e + (Z_delta_e * M_alpha)/(U_1 - Z_alphap));...
          0;...
          Z_delta_e;...
          0]
        


%% System Matrix (A_side) and input Matrix (C_side) for side motion

I_xz = ;
I_zz = ; 
I_xx = ;

A_1 = I_xz/I_xx;
B_1 = I_xz/I_zz;
U_1 = ;
Theta_1 = ;
Y_beta = ;
Y_p = ;














