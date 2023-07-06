function impactor_velocity = gen_impact_vel(histogram, bin_velocity)
    
    rand_id = rand(1);
    search_velocity = true;
    k = 1;
    criteria = histogram(k);

    while search_velocity == true

        if(criteria >= rand_id)
            search_velocity = false;
            impactor_velocity = bin_velocity(k);
        else
            k = k + 1;
            criteria = criteria + histogram(k);
            search_velocity = true;
        end

    end

end

