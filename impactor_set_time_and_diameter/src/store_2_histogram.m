function histogram = store_2_histogram(histogram, time_index, impactor, diameter)

    if diameter <= 100
        diameter_index = floor(diameter);
        histogram(time_index, impactor, diameter_index) = histogram(time_index, impactor, diameter_index) + 1;
    
    end

end

