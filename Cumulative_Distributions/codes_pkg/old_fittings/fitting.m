clc;
clear;
close all;
csv_read = readtable("Terrestrial_1km.csv");
data = table2array(csv_read);

earth_SA = 5.101e8;
scaling_factor = 0.0036095;
x = data(:,1);
y = data(:,2);

f1 = fit(x,y,'exp1');

x_fit = linspace(0,4.5, 4500);
y_fit = scaling_factor*(x_fit * 0.000905) * earth_SA;

x_fit_2 = linspace(0,4.5,4500);
y_fit_2 = scaling_factor*(9.195e-13 * exp(6.312*x_fit_2)) * earth_SA;

x_fit_3 = linspace(0,4.5,4500);
y_fit_3 = scaling_factor* earth_SA*(x_fit_3 * 0.000905 + 9.195e-13 * exp(6.312*x_fit_3));

% obtain the count of craters on earth > 1km per every million years
count_per_mya = zeros(4499,1);
for i = 1:4499
    count_per_mya(i,1) = y_fit_3(i+1) - y_fit_3(i);
end

total_count = sum(count_per_mya);

% compute a histogram 
percent_per_mya = count_per_mya/total_count;



t = linspace(0,4500,4500);

F_1_1km = 3e4;
F_2_1km = 1.6667;

F = F_1_1km * exp(-(t/65).^0.6) + F_2_1km * (4570 - t);
F_1 = F_1_1km * exp(-(t/65).^0.6);
F_2 = F_2_1km * (4570 - t);
semilogy((4500-t)/1000 ,F, 'Color', 'black', 'LineWidth',2)
hold on
semilogy((4500-t)/1000, F_1, 'Color', 'green', 'LineWidth', 2, 'LineStyle','--')
hold on
semilogy((4500-t)/1000, F_2, 'Color', 'blue', 'LineWidth', 2, 'LineStyle',':')
hold on



%semilogy(x,y * earth_SA, 'Color', 'black', 'LineWidth',2)
%hold on
% semilogy(x_fit, y_fit, 'Color', 'green', 'LineWidth', 2, 'LineStyle','--')
% hold on
% semilogy(x_fit_2, y_fit_2, 'Color', 'blue', 'LineWidth', 2, 'LineStyle',':')
% hold on
semilogy(x_fit_3, y_fit_3, 'Color', 'red', 'LineWidth', 3);
hold on

xlim([1,4.5])
ylim([1e1,1e10])
grid on
