clc;
clear;
close all;

% Declare a seed for repeatability
rng(4224053);

% download and convert terrestrial impact fluxes to vectors
csv_asteroid_01 = readtable("data_files/asteroid_01km_count_per_mya_20_45.csv");
csv_asteroid_10 = readtable("data_files/asteroid_10km_count_per_mya_20_45.csv");
csv_comet_01 = readtable("data_files/comet_01km_count_per_mya_20_45.csv");
csv_comet_10 = readtable("data_files/comet_10km_count_per_mya_20_45.csv");
csv_leftover_01 = readtable("data_files/leftover_01km_count_per_mya_20_45.csv");
csv_leftover_10 = readtable("data_files/leftover_10km_count_per_mya_20_45.csv");

asteroid_01 = table2array(csv_asteroid_01);
asteroid_10 = table2array(csv_asteroid_10);
comet_01 = table2array(csv_comet_01);
comet_10 = table2array(csv_comet_10);
leftover_01 = table2array(csv_leftover_01);
leftover_10 = table2array(csv_leftover_10);

% compute the total number of asteroids, comets and leftovers
% and the total number of entities that hit the earth
total_asteroid_gt01_20_45 = sum(asteroid_01);
total_comet_gt01_20_45 = sum(comet_01);
total_leftover_gt01_20_45 = sum(leftover_01);
total_entities = total_asteroid_gt01_20_45 + total_comet_gt01_20_45 + total_leftover_gt01_20_45;

% the number of impacts per every 1mya for asteroids, 
% comets, and leftovers from 2 to 4GYA
asteroid_01_10 = asteroid_01 - asteroid_10;
comet_01_10 = comet_01 - comet_10;
leftover_01_10 = leftover_01 - leftover_10;

% the total number of impacts for 2 categories (1-10km and > 10km
% from 2 to 4GYA for asteroids, comets, and leftovers
total_asteroid_01_10 = sum(asteroid_01_10);
total_asteroid_gt_10 = sum(asteroid_10);

total_comet_01_10 = sum(comet_01_10);
total_comet_gt_10 = sum(comet_10);

total_leftover_01_10 = sum(leftover_01_10);
total_leftover_gt_10 = sum(leftover_10);

% time histogram of impacts of impacts for 2 categories (1-10km and > 10km
% from 2 to 4GYA for asteroids, comets, and leftovers. 
% This is used to compute for the age of the impact.

time_hist_asteroid_01_10 = asteroid_01_10/total_asteroid_01_10;
time_hist_asteroid_gt_10 = asteroid_10/total_asteroid_gt_10;

time_hist_comet_01_10 = comet_01_10/total_comet_01_10;
time_hist_comet_gt_10 = comet_10/total_comet_gt_10;

time_hist_leftover_01_10 = leftover_01_10/total_leftover_01_10;
time_hist_leftover_gt_10 = leftover_10/total_leftover_gt_10;

% the ratio of asteroids, comets, and leftovers 1-10km and > 10km to the
% total number of impactors between 2 - 4 GYA
% This is used to compute the type of impactor
ratio_asteroid_01_10 = total_asteroid_01_10/total_entities;
ratio_asteroid_gt_10 = total_asteroid_gt_10/total_entities;
ratio_comet_01_10 = total_comet_01_10/total_entities;
ratio_comet_gt_10 = total_comet_gt_10/total_entities;
ratio_leftover_01_10 = total_leftover_01_10/total_entities;
ratio_leftover_gt_10 = total_leftover_gt_10/total_entities;

% create stops for Monte Carlo determination of the impactor type and range
% of sizes
stop_1 = ratio_asteroid_01_10;
stop_2 = stop_1 + ratio_asteroid_gt_10;
stop_3 = stop_2 + ratio_comet_01_10;
stop_4 = stop_3 + ratio_comet_gt_10;
stop_5 = stop_4 + ratio_leftover_01_10;
stop_6 = stop_5 + ratio_leftover_gt_10;

counts = zeros(6,1);

time_asteroid_hist_01_10_mc = zeros(4500,1);
time_comet_hist_01_10_mc = zeros(4500,1);
time_leftover_hist_01_10_mc = zeros(4500,1);

time_asteroid_hist_gt_10_mc = zeros(4500,1);
time_comet_hist_gt_10_mc = zeros(4500,1);
time_leftover_hist_gt_10_mc = zeros(4500,1);

time_asteroid_hist_mc = zeros(4500,1);
time_comet_hist_mc = zeros(4500,1);
time_leftover_hist_mc = zeros(4500,1);

% create the SFDs for asteroids, comets, and
% leftovers
[freq_asteroids_1_1, d_asteroid_1_1] = gen_asteroid_diameter(1,1);
[freq_asteroids_1_2, d_asteroid_1_2] = gen_asteroid_diameter(1,2);
[freq_asteroids_2_1, d_asteroid_2_1] = gen_asteroid_diameter(2,1);
[freq_asteroids_2_2, d_asteroid_2_2] = gen_asteroid_diameter(2,2);

[freq_leftovers_1, d_leftovers_1] = gen_leftover_diameter(1);
[freq_leftovers_2, d_leftovers_2] = gen_leftover_diameter(2);

[freq_comets_1, d_comets_1] = gen_comet_diameter(1);
[freq_comets_2, d_comets_2] = gen_comet_diameter(2);


% create impactor-diameter histogram w.r.t time
histogram_impactor = zeros(4500,3,100);
impactor_gt_100km = zeros(3,1);


for i = 1: int32(total_entities)
%for i = 1: 10
    
    % ensures that the code is running properly
    % turn off when running real code
    if mod(i,10000) == 0
        disp(i)
    end

    rand_id = rand();

    if(mod(i,1)==0)
        if (rand_id > 0 && rand_id <= stop_1) %disp("Asteroid 1 - 10km")
            
            counts(1,1) = counts(1,1) + 1;
            
            % determine age of impact for the asteroid
            t_asteroid_index = gen_impactor_age(time_hist_asteroid_01_10)+2000;
            time_asteroid_hist_01_10_mc(t_asteroid_index) = time_asteroid_hist_01_10_mc(t_asteroid_index) + 1;

            % determine diameter of asteroid impact 1-10km
            d_asteroid = gen_impactor_diameter(d_asteroid_1_1,freq_asteroids_1_1); 

            % store time and size and impactor to histogram
            [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, t_asteroid_index, 1, d_asteroid);

        elseif (rand_id > stop_1 && rand_id <= stop_2) %disp("Asteroid > 10km")
            
            counts(2,1) = counts(2,1) + 1;
        
            % determine age of impact for the asteroid
            t_asteroid_index = gen_impactor_age(time_hist_asteroid_gt_10)+2000;
            time_asteroid_hist_gt_10_mc(t_asteroid_index) = time_asteroid_hist_gt_10_mc(t_asteroid_index) + 1;

            % determine diameter of asteroid impact > 10km
            d_asteroid = gen_impactor_diameter(d_asteroid_1_2,freq_asteroids_1_2);

            [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, t_asteroid_index, 1, d_asteroid);

        elseif (rand_id > stop_2 && rand_id <= stop_3)
            %disp("Comet 1 - 10km")
            counts(3,1) = counts(3,1) + 1;

            % determine age of impact for the asteroid
            t_comet_index = gen_impactor_age(time_hist_comet_01_10)+2000;
            time_comet_hist_01_10_mc(t_comet_index) = time_comet_hist_01_10_mc(t_comet_index) + 1;

            % determine diameter of the comet impact 1-10km
            d_comet = gen_impactor_diameter(d_comets_1, freq_comets_1);

            % store time and size and impactor to histogram
            [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, t_comet_index, 2, d_comet);

        elseif (rand_id > stop_3 && rand_id <= stop_4)
            %disp("Comet > 10km")
            counts(4,1) = counts(4,1) + 1;
            
            % determine age of impact of the comet
            t_comet_index = gen_impactor_age(time_hist_comet_gt_10)+2000;
            time_comet_hist_gt_10_mc(t_comet_index) = time_comet_hist_gt_10_mc(t_comet_index) + 1;

            % determine diameter of the comet impact > 10km
            d_comet = gen_impactor_diameter(d_comets_2, freq_comets_2);

            % store time and size and impactor to histogram
            [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, t_comet_index, 2, d_comet);

        elseif (rand_id > stop_4 && rand_id <= stop_5)
            %disp("Planetestimal 1 - 10km")
            counts(5,1) = counts(5,1) + 1;

            % determine age of impact of the leftover
            t_leftover_index = gen_impactor_age(time_hist_leftover_01_10)+2000;
            time_leftover_hist_01_10_mc(t_leftover_index) = time_leftover_hist_01_10_mc(t_leftover_index) + 1;

            % determine diameter of the leftover
            d_leftover = gen_impactor_diameter(d_leftovers_1, freq_leftovers_1);
            %disp(d_leftover)

            % store time and size and impactor to histogram
            [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, t_leftover_index, 3, d_leftover);

        elseif (rand_id > stop_5 && rand_id <= stop_6)
            %disp("Planetestimal > 10km")
            counts(6,1) = counts(6,1) + 1;

            % determine age of impact of the leftover
            t_leftover_index = gen_impactor_age(time_hist_leftover_gt_10)+2000;
            time_leftover_hist_gt_10_mc(t_leftover_index) = time_leftover_hist_gt_10_mc(t_leftover_index) + 1;

            % determine diameter of the leftover
            d_leftover = gen_impactor_diameter(d_leftovers_2, freq_leftovers_2);
            %disp(d_leftover)

            % store time and size and impactor to histogram
            [histogram_impactor, impactor_gt_100km] = store_2_histogram(histogram_impactor, impactor_gt_100km, t_leftover_index, 3, d_leftover);

        else
            disp("Not a real random number")
        end

    end

    time_leftover_hist_mc = time_leftover_hist_gt_10_mc + time_leftover_hist_01_10_mc ;
    time_asteroid_hist_mc = time_asteroid_hist_01_10_mc + time_asteroid_hist_gt_10_mc;
    time_comet_hist_mc = time_comet_hist_gt_10_mc + time_comet_hist_01_10_mc;

end



