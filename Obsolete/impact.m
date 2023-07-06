clc;
clear;

F_1d = 225;
F_2d = 3E-3;


SA_Earth = 5.1E8;


t = linspace(0,4570);
tau = 65;
alpha = 0.6;
T = 4570 - t;
F_1 = F_1d * exp(-(t/tau).^alpha);
F_2 = F_2d * T;

F = (F_1 + F_2);

set(gca, 'YScale', 'log')

semilogy(T,F/SA_Earth)
hold on
semilogy(T,F_1/SA_Earth)
hold on
semilogy(T, F_2/SA_Earth)


