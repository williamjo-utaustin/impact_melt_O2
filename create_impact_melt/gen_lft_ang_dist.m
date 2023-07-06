function [imp_ang_dist, imp_ang_index] = gen_lft_ang_dist()

    y = @(x) sin(2*x);

    theta = 0:1:90;
    imp_ang_dist = zeros(90,1);
    imp_ang_index = zeros(90,1);
    for i = 1:90
        imp_ang_index(i,1) = (pi/180)*((theta(i) + theta(i+1))/2);
        imp_ang_dist(i,1) = 1;
    end

    imp_ang_dist = imp_ang_dist/sum(imp_ang_dist);
end

