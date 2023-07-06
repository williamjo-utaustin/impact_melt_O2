function [freq_asteroids, d_asteroids] = gen_asteroid_diameter(type, size)

    if size == 1 % for Asteroids 1 - 10km in Diameter
        d_start = 1.0;
        d_end = 10.0;
        impactor_interval = 0.001;
    elseif size == 2 % for Asteroids > 10km in Diameter
        d_start = 10;
        d_end = 10000;
        impactor_interval = 1;
    else
        disp("Invalid Asteroid Size Category");
    end
    
    num_partitions = int32((d_end - d_start)/impactor_interval);
    freq_d = linspace(d_start,d_end,num_partitions);
    
    if type == 1 % for MBA Asteroids
        freq_funct = 2.030453E6*freq_d.^(-2.146389);
    elseif type == 2 % for NEO Asteroids
        freq_funct = 9.959719E2*freq_d.^(-2.260365);
    else
        disp("Invalid Asteroid Type Category")
    end

    d_asteroids = freq_d(1:num_partitions-1);
    freq_asteroids = zeros(1,num_partitions-1);

    for i = 1: num_partitions - 1
        
        freq_asteroids(i) = freq_funct(i) - freq_funct(i+1);

    end

end


