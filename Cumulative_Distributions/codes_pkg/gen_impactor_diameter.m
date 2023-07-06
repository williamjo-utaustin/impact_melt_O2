function impactor_diameter = gen_impactor_diameter(d,freq)
    
    rand_id = rand();

    total = sum(freq);
    histogram = freq/total;
    
    search_diameter = true;
    k = 1;
    criteria = histogram(k);
    while search_diameter == true
    
        if(criteria >= rand_id)
            search_diameter = false;
            impactor_diameter = d(k);
        else
            k = k + 1;
            criteria = criteria + histogram(k);
            search_diameter = true;
        end
    
    end
end

