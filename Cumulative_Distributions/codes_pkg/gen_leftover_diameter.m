function [freq_leftovers,d_leftovers] = gen_leftover_diameter(size)
    
    %rand_id = rand();

    if size == 1 % for Asteroids 1 - 10km in Diameter
        d_start = 1.0;
        d_end = 10.0;
        impactor_interval = 0.001;
    elseif size == 2 % for Asteroids > 10km in Diameter
        d_start = 10;
        d_end = 7700;
        impactor_interval = 1;
    else
        disp("Invalid Asteroid Size Category");
    end

    num_partitions = int32((d_end - d_start)/impactor_interval);
    d = linspace(d_start,d_end,num_partitions);
    freq_funct = zeros(1,num_partitions);

    % create stops from Excel for planetestimals
    stop_1 = 3.739086893; 
    stop_2 = 5.342918364;
    stop_3 = 10.0;
    stop_4 = 89.2393201;
    stop_5 = 321.131669;
    stop_6 = 980.035755;
    stop_7 = 10000.0; % ceres


    for i = 1:num_partitions

        if d(i) >= 1 && d(i) < stop_1
            
            freq_funct(1,i) = 1.349890E9 * d(i)^(-7.319162);
            
        elseif d(i) >= stop_1 && d(i) < stop_2

            freq_funct(1,i) = 4.546569E6 * d(i)^(-2.969706);

        elseif  d(i) >= stop_2 && d(i) < stop_3

            freq_funct(1,i) = 5.015132E4*d(i)^(-2.528126E-1);

        elseif  d(i) >= stop_3 && d(i) < stop_4

            freq_funct(1,i) = 3.460004E4 * exp((-2.868969E-2) * d(i));

        elseif  d(i) >= stop_4 && d(i) < stop_5

            freq_funct(1,i) = 1.512289E7 * d(i)^(-1.908559);

        elseif  d(i) >= stop_5 && d(i) < stop_6
            
            freq_funct(1,i) = 4.460122E6 * d(i)^(-1.707805);

        elseif  d(i) >= stop_6 && d(i) < stop_7
            
            freq_funct(1,i) = -1.682961E1 * log(d(i)) + 1.510195E2;

        else
            
            disp("Bounds don't work!");
        
        end


    end

    d_leftovers = d(1:num_partitions-1);
    freq_leftovers = zeros(1,num_partitions-1);

    for i = 1: num_partitions - 1
        
        freq_leftovers(i) = freq_funct(i) - freq_funct(i+1);

    end


end

