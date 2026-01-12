clear
clc

run A_2_1_2_Eigenwerte_CP.m


subplot(2,1,1)
plot(real(eigVecLong),imag(eigValLong),"o")
yline(0)
xline(0)
ylabel("imag")
xlabel("real")
title("longitudinal")

subplot(2,1,2)
plot(real(eigVecLat),imag(eigVecLat),"o")
yline(0)
xline(0)
ylabel("imag")
xlabel("real")
title("lateral")




