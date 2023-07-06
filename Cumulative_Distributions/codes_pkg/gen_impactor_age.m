function impact_age_index = gen_impactor_age(input_histogram)

    rand_id = rand();

    search_time = true;
    k = 1;
    criteria = input_histogram(k);
    while search_time == true
    
        if(criteria >= rand_id)
            search_time = false;
            impact_age_index = k;
        else
            k = k + 1;
            criteria = criteria + input_histogram(k);
            search_time = true;
        end
    
    end


end