clc;
clear;
close all;

n_sims = 3;

seed_init = 4224053;

asteroid_total = zeros(4500,100);
comets_total = zeros(4500,100);
planetestimals_total = zeros(4500,100);

for sim_count = 1:n_sims
    seed_init = (sim_count - 1) * 23 + seed_init;

    histogram_impactor = [];
    load(append('output/impactor_sim_',num2str(seed_init,'%08i'),'.mat'))
    
    asteroids = reshape(histogram_impactor(:, 1, :),[4500 100]);
    comets = reshape(histogram_impactor(:, 2, :),[4500 100]);
    planetestimals = reshape(histogram_impactor(:, 3, :),[4500 100]);

    asteroid_total = asteroid_total + asteroids;
    comets_total = comets_total + comets;
    planetestimals_total = planetestimals_total + planetestimals;

end

asteroid_avg = asteroid_total/n_sims;
comets_avg = comets_total/n_sims;
planetestimals_avg = planetestimals_total/n_sims;



