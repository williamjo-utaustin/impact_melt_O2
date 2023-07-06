clc;
clear;

den = 2000;
L = 10000;

m_proj = den * (4/3) * pi * (L/2)^3;

g = 9.81;

v_i = 17000;

theta = pi/4;

m_ej = 0.25 * m_proj * (1.6*((1.61*g*L)/v_i^2)^-0.22 * ((pi/8)*(1/2.7))^(-1/3) * (sin(theta))^(-1/3))^3;