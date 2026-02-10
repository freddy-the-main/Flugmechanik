clear
clc


tf_ail2bank = tf(minreal(linsys1))


[P, I, D, N] = piddata(C)