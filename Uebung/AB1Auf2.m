clear 
clc

% aufgabe 2 auf aufgabenblatt1

m = 1; %[kg]
k = 200; %[N/m]
k1 = k; 
k2 = 2*k;
k3 = 6*k;
m1 = m;
m2 = 2*m;



%sys mat
A = [0        -(k1+k2)/m1     0            k2/m1;... 
     1        0               0            0;...
     0        k2/m2           0            -(k2+k3)/m2;...
     0        0               1            0];



%eigenwerte und -vektoren
[EV, L1] = eig(A);

L2 = eig(A);

%Zeitvektor
t = 0:0.01:5;

x = zeros(4,length(t));

c1 = 1;
c2 = 1;


%zustaende berechnen
x(1,:) = c1 * EV(1,1) * exp(L2(1)*t) + c1 * EV(1,2) * exp(L2(2)*t) + c1 * EV(1,3) * exp(L2(3)*t) + c1 * EV(1,4) * exp(L2(4)*t);
x(2,:) = c1 * EV(2,1) * exp(L2(1)*t) + c1 * EV(2,2) * exp(L2(2)*t) + c1 * EV(2,3) * exp(L2(3)*t) + c1 * EV(2,4) * exp(L2(4)*t);
x(3,:) = c1 * EV(3,1) * exp(L2(1)*t) + c1 * EV(3,2) * exp(L2(2)*t) + c1 * EV(3,3) * exp(L2(3)*t) + c1 * EV(3,4) * exp(L2(4)*t);
x(4,:) = c1 * EV(4,1) * exp(L2(1)*t) + c1 * EV(4,2) * exp(L2(2)*t) + c1 * EV(4,3) * exp(L2(3)*t) + c1 * EV(4,4) * exp(L2(4)*t);


figure(1)
clf

subplot(4,1,1)
plot(t,x(1,:))
title("x(1)")

subplot(4,1,2)
plot(t,x(2,:))
title("x(2)")

subplot(4,1,3)
plot(t,x(3,:))
title("x(3)")

subplot(4,1,4)
plot(t,x(4,:))
title("x(4)")


figure(2)
clf
hold on

plot(t,x(1,:))
plot(t,x(3,:))
legend("mass 1", "mass 2",'Location', 'best')
xlabel("time [s]")
ylabel("speed [m/s]")
title("speeds")

subplot(2,1,2)
clf
hold on

plot(t,x(2,:))
plot(t,x(4,:))
legend("mass 1", "mass 2",'Location', 'best')
xlabel("time [s]")
ylabel("distance [m/s]")
title("distance")









