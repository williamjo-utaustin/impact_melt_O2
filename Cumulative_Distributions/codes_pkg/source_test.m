clc;
clear;
close all;

%[freq_asteroids, d_asteroids] = gen_asteroid_diameter(1,1);
%[freq_leftovers, d_leftovers] = gen_leftover_diameter(2);

[freq_comets, d_comets] = gen_comet_diameter(2);

total = sum(freq_comets);

prob = freq_comets/total;


% [d, freq1] = gen_leftover_diameter(1);
% [d2, freq2] = gen_leftover_diameter(2);
% 
% loglog(d,freq1)
% hold on
% loglog(d2,freq2)
% hold on