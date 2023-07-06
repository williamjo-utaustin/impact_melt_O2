clc;
clear;
close all;

rng(23980293);

rate = 1; % # per hour
t_interval = 1; % # number of hours

lambda = rate * t_interval;

k = linspace(0,20,21);
poisson = zeros(1,21);

% create distribution
for i = 1:21
    poisson(i) = lambda^k(i) * exp(-lambda)/factorial(k(i));
end


n_sims = 1000;
sim_results = zeros(1,n_sims);

for sim = 1:n_sims

    rng = rand(1);
    exit_loop = false;
    bound = poisson(1);
    i = 1;
    while exit_loop == false

        if rng > bound
            exit_loop = false;
            i = i + 1;
            bound = bound + poisson(i);

        elseif rng <= bound
            exit_loop = true;
            sim_results(sim) = k(i);
            disp(k(i))
        else
            disp("Does not work")
        end

    end

end

histogram(sim_results)


