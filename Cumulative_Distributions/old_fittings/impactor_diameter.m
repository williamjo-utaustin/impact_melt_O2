clc;
clear;
close all;

D_fin = 1*1000;

v_imp_earth = 22000;
g_moon = 9.81;
D_sc_earth = 4000;
theta = pi/4;
g_earth = 9.81;


D_imp = (D_fin / (1.52 * v_imp_earth^(0.5) * g_earth^(-0.25) * D_sc_earth^(-0.13) * (sin(theta))^0.38))^(1/0.88);
