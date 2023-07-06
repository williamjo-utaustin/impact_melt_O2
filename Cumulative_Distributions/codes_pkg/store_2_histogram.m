function [histogram, gt_100] = store_2_histogram(histogram, gt_100, time_index, impactor, diameter)

    if diameter <= 100
        diameter_index = floor(diameter);
        histogram(time_index, impactor, diameter_index) = histogram(time_index, impactor, diameter_index) + 1;
    
    else
        gt_100(impactor,1) = gt_100(impactor,1) + 1;
    
    end

end

