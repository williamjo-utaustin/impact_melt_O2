clc;
clear;


t = linspace(0,4500,4500);

F_1_1km = 3e4;
F_2_1km = 1.6667;

F = F_1_1km * exp(-(t/65).^0.6) + F_2_1km * (4570 - t);
F_1 = F_1_1km * exp(-(t/65).^0.6);
F_2 = F_2_1km * (4570 - t);
semilogy(4500-t ,F, 'Color', 'black', 'LineWidth',2)
hold on
semilogy(4500-t, F_1, 'Color', 'green', 'LineWidth', 2, 'LineStyle','--')
hold on
semilogy(4500-t, F_2, 'Color', 'blue', 'LineWidth', 2, 'LineStyle',':')
hold on