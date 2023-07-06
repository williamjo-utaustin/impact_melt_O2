function [histogram,bin_velocity] = gen_lft_vel_dist()

    % from bottke et al. 2010
    % See references and notes (43)
    bin_velocity = 12:1:18;
    bin_area = zeros(length(bin_velocity),1);
    for i = 1:length(bin_velocity)
        bin_area(i,1) = 1;
    
    end
    
    total_area = sum(bin_area);
    histogram = bin_area/total_area;

end

