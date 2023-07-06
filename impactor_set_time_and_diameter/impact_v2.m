clc;
clear;
close all;

addpath src/
addpath data_files/

n_start = 2;
n_end = 50;
seed_init = 4224053;
%seed_init = 4224052;


disp("------------------------- Begin Program  --------------------------------------")
disp(" ")
tic
disp("Loading Terrestrial Impact Flux Files -----")
disp(" ")
% download and convert terrestrial impact fluxes to vectors
csv_asteroid_01 = readtable("/data_files/asteroid_01km_count_per_mya_20_45.csv");
csv_asteroid_10 = readtable("/data_files/asteroid_10km_count_per_mya_20_45.csv");
csv_comet_01 = readtable("/data_files/comet_01km_count_per_mya_20_45.csv");
csv_comet_10 = readtable("/data_files/comet_10km_count_per_mya_20_45.csv");
csv_leftover_01 = readtable("/data_files/leftover_01km_count_per_mya_20_45.csv");
csv_leftover_10 = readtable("/data_files/leftover_10km_count_per_mya_20_45.csv");

asteroid_01 = table2array(csv_asteroid_01);
comet_01 = table2array(csv_comet_01);
leftover_01 = table2array(csv_leftover_01);

asteroid_10 = table2array(csv_asteroid_10);
comet_10 = table2array(csv_comet_10);
leftover_10 = table2array(csv_leftover_10);

for sim_count = n_start : n_end

    disp("Calling Seed: "+ sim_count+"/"+n_end+" -----")

    % create seed ID
    seed_count = (sim_count - 1) * 23 + seed_init;
    
    % declare filenames from seedname
    %file_ID = append('large_impactors_',num2str(seed_init,'%08i'),'.txt'); 
    %large_impactors = fopen(file_ID,'wt');

    file_ID_2 = append('output/impactor_sim_',num2str(seed_count,'%08i'),'.mat');
    file_ID_3 = append('output/large_impactor_',num2str(seed_count,'%08i'),'.mat');
    
    % send seed ID to computer
    rng(seed_count);

    % the number of impacts per every 1mya for asteroids,
    % comets, and leftovers from 2 to 4GYA
    %
    asteroid_sim = zeros(1,2500);
    comet_sim = zeros(1,2500);
    leftover_sim = zeros(1,2500);

    % Simulate asteroid counts at every mya using monte carlo with poisson
    % processing

    % generate impactors of size 1 - 10 km in diameter
    disp("Monte Carlo RNG impact counts, impactor diameters -----")
    for i = 1:2500
        asteroid_sim(i) = set_poisson_time(asteroid_01(i,1));
        comet_sim(i) = set_poisson_time(comet_01(i,1));
        leftover_sim(i) = set_poisson_time(leftover_01(i,1));
    end

    % generate size distributions ------------------------------------
    % generate asteroid diameter distributions
    % only considering MBA Asteroids
    [freq_asteroids_1_1, d_asteroid_1_1] = gen_asteroid_diameter(1,1);

    % generate asteroid diameter distributions
    [freq_comets_1, d_comets_1] = gen_comet_diameter(1);

    % generate leftover diameter distributions
    [freq_leftovers_1, d_leftovers_1] = gen_leftover_diameter(1);

    % store the impactor data into an array
    histogram_impactor = zeros(4500,3,100);
    impactor_gt_100km = zeros(10000,3);
    k = 1;
    disp(" ")
    disp("Begin Impacts --------------------------------------------")
    % generate sizes per mya and storage ------------------------------
    for i = 2500:-1:1
    %for i = 100:-1:1 % quick sim

        if mod(i,10)==0
            disp("Time (MYA): " + num2str(i+2000))
        end

        for j = 1: max([asteroid_sim(i),comet_sim(i),leftover_sim(i)])

            if j <= asteroid_sim(i)
                d_asteroid = gen_impactor_diameter(d_asteroid_1_1,freq_asteroids_1_1);

                if d_asteroid > 100
                    %fprintf(file_ID,'%4i %5.3f %1i\n', i, d_asteroid, 1);
                    impactor_gt_100km(k,1) = i+2000;
                    impactor_gt_100km(k,2) = d_asteroid;
                    impactor_gt_100km(k,3) = 1;
                    k = k + 1;
                end

                histogram_impactor = store_2_histogram(histogram_impactor, i+2000, 1, d_asteroid);

            end

            if j <= comet_sim(i)
                d_comet = gen_impactor_diameter(d_comets_1,freq_comets_1);
                if d_comet > 100
                    %fprintf(file_ID,'%4i %5.3f %1i\n', i, d_comet, 2);
                    impactor_gt_100km(k,1) = i+2000;
                    impactor_gt_100km(k,2) = d_comet;
                    impactor_gt_100km(k,3) = 2;
                    k = k + 1;
                end
                histogram_impactor = store_2_histogram(histogram_impactor, i+2000, 2, d_comet);

            end

            if j<=leftover_sim(i)
                d_leftover = gen_impactor_diameter(d_leftovers_1,freq_leftovers_1);

                if d_leftover > 100
                    %disp(i+" "+3+" "+d_leftover)
                    %fprintf(file_ID,'%4i %5.3f %1i\n', i, d_leftover, 3);
                    impactor_gt_100km(k,1) = i+2000;
                    impactor_gt_100km(k,2) = d_leftover;
                    impactor_gt_100km(k,3) = 3;
                    k = k + 1;
                end

                histogram_impactor = store_2_histogram(histogram_impactor, i+2000, 3, d_leftover);

            end

        end

    end

    disp("Time (MYA): " + num2str(i+2000))
    save(file_ID_2,'histogram_impactor')
    save(file_ID_3,'impactor_gt_100km')
    %fclose('all');
    disp("End Impacts --------------------------------------------")
    disp(" ")

end
toc
disp("------------------------- End Program  --------------------------------------")




% % rng(4224053);
% % fileID = fopen('gt_100.txt','w');
% 
% 
% % the number of impacts per every 1mya for asteroids, 
% % comets, and leftovers from 2 to 4GYA
% % 
% asteroid_sim = zeros(1,2500);
% comet_sim = zeros(1,2500);
% leftover_sim = zeros(1,2500);
% 
% % Simulate asteroid counts at every mya using monte carlo with poisson
% % processing
% 
% % generate impactors of size 1 - 10 km in diameter
% disp("Generating impact counts at each MYA in MYA intervals -------------")
% for i = 1:2500
%     asteroid_sim(i) = set_poisson_time(asteroid_01(i,1));
%     comet_sim(i) = set_poisson_time(comet_01(i,1));
%     leftover_sim(i) = set_poisson_time(leftover_01(i,1));
% end
% 
% 
% disp(" ")
% disp("Generating size distributions for asteroids, comets, planetestimals -------------")
% % generate size distributions ------------------------------------
% % generate asteroid diameter distributions
% % only considering MBA Asteroids
% [freq_asteroids_1_1, d_asteroid_1_1] = gen_asteroid_diameter(1,1);
% 
% % generate asteroid diameter distributions
% [freq_comets_1, d_comets_1] = gen_comet_diameter(1);
% 
% % generate leftover diameter distributions
% [freq_leftovers_1, d_leftovers_1] = gen_leftover_diameter(1);
% 
% % store the impactor data into an array
% histogram_impactor = zeros(4500,3,100);
% impactor_gt_100km = zeros(3,1);
% 
% disp("Begin Simulation --------------------------------------------")
% % generate sizes per mya and storage ------------------------------
% for i = 2500:-1:1
%     
%     if mod(i,10)==0
%         disp("Time (MYA): " + num2str(i+2000))
%     end
%         
%     for j = 1: max([asteroid_sim(i),comet_sim(i),leftover_sim(i)])
%     
%         if j <= asteroid_sim(i)
%             d_asteroid = gen_impactor_diameter(d_asteroid_1_1,freq_asteroids_1_1); 
%             
%             if d_asteroid > 100
%                 disp(i+" "+1+" "+d_asteroid)
%             end      
%             
%             [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, i+2000, 1, d_asteroid);
%        
%         end
% 
%         if j <= comet_sim(i)
%             d_comet = gen_impactor_diameter(d_comets_1,freq_comets_1); 
%             if d_comet > 100
%                 disp(i+" "+2+" "+d_comet)
%             end
%             [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, i+2000, 2, d_comet);
%         end
% 
%         if j<=leftover_sim(i)
%             d_leftover = gen_impactor_diameter(d_leftovers_1,freq_leftovers_1); 
% 
%             if d_leftover > 100
%                 disp(i+" "+3+" "+d_leftover)
%             end
% 
%             [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, i+2000, 3, d_leftover);
%         end
%     
%     end
% 
%    
% end
% 
% toc