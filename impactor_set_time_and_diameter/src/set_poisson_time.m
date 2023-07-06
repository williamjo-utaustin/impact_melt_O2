function n_impact = set_poisson_time(lambda)

    % input the expected count of asteroids, 
    if lambda > 7500
        k_pot = 0:15000;
    elseif lambda > 1000 && lambda <= 7500
        k_pot = 0:10000;
    elseif lambda > 100 && lambda <= 1000
        k_pot = 0:2500;
    elseif lambda > 10 && lambda <= 100
        k_pot = 0:500;
    elseif lambda <= 10
        k_pot = 0:50;
    end

    prob = poisspdf(k_pot,lambda);
    rand_num = rand(1);
    search_k = true;
    k = 1;
    
    while search_k == true
    
        if rand_num < sum(prob(1,1:k))
            n_impact = k_pot(k);
            search_k = false;
        else
            k = k + 1;
        end
    
    end
end

