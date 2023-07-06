function impactor_angle = gen_impact_ang(histogram, bin_angle)
    
    rand_id = rand(1);
    search_angle = true;
    k = 1;
    criteria = histogram(k);

    while search_angle == true

        if(criteria >= rand_id)
            search_angle = false;
            impactor_angle = bin_angle(k);
        else
            k = k + 1;
            criteria = criteria + histogram(k);
            search_angle = true;
        end

    end

end

