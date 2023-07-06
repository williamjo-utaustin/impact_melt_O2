clc;
clear;
close all;

csv_read = readtable("comets_10km.csv");
data = table2array(csv_read);

x = data(1:49,1);
y = data(1:49,2);

semilogy(x,y, 'Color', 'black', 'LineWidth',2)
hold on

x_fit = linspace(0,4.5, 4500);
y_fit = (x_fit * 0.7183);

semilogy(x_fit,y_fit, 'Color', 'blue', 'LineWidth',2)
hold on

x_fit = linspace(0,4.5, 4500);
a = 0.0001466;
b = 2.655;
c = 2.576e-18;
d = 10.16; 
y_fit_2 = a*exp(b*x_fit) + c*exp(d*x_fit);

hold on

semilogy(x_fit,y_fit_2, 'Color', 'red', 'LineWidth',2)
hold on

