function [histogram,bin_velocity] = gen_com_vel_dist()


    y = @(x) ((2.21549E-4)*x.^2 - (3.29505E-3)*x + 6.92613E-2)/24.016287318;
    
    bin_velocity = 16:1:73;
    bin_area = zeros(length(bin_velocity),1);
    for i = 1:length(bin_velocity)
        bin_area(i,1) = integral(y,bin_velocity(i)-0.5,bin_velocity(i)+0.5);
    
    end
    
    total_area = sum(bin_area);
    histogram = bin_area/total_area;

end

