clear
clc

run A_2_1_2_Eigenwerte_CP.m


subplot(1,2,1)
eigValLong(eigValLong==0) = nan;
plot(real(eigValLong),imag(eigValLong),"o",LineWidth=3)
yline(0)
xline(0)
ylabel("imag")
xlabel("real")
title("longitudinal")
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
R = max(max(abs(real(eigValLong))))+2;
I = max(max(abs(imag(eigValLong))))+2;
L = max(R, I);
xlim([-L, L])
ylim([-L, L])
axis square


subplot(1,2,2)
eigValLat(eigValLat==0) = nan;
plot(real(eigValLat),imag(eigValLat),"o",LineWidth=3)
yline(0)
xline(0)
ylabel("imag")
xlabel("real")
title("lateral")
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
R = max(max(abs(real(eigValLat))))+2;
I = max(max(abs(imag(eigValLat))))+2;
L = max(R, I);
xlim([-L, L])
ylim([-L, L])
axis square


