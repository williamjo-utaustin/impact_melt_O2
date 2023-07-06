function mass_melt = gen_impact_melt(d_proj, vel_proj, ang_proj, imp_type)
    
    % the inputs for d_proj and vel_proj will be in km and km/s
    % convert here to m and m/s



    d_proj = d_proj  * 1000;
    vel_proj = vel_proj * 1000;

    % use target material as gabbro anothorsite
    den_tar = 3000;
    

    if imp_type == 1
        % assume chondrite for asteroids, but there's stony and metallic as well
        %Krasinsky et al
        den_chondrite_asteroids = 1380; % 75 percent of known asteroids
        den_stony_asteroids = 2710; % 17 percent of known asteroids
        den_metallic_asteroids = 5320; % % 8 percent of known asteroids
    
        chance = rand(1);
    
        if chance <= 0.75
            den_proj = den_chondrite_asteroids;
        elseif chance > 0.75 && chance <= 0.92
            den_proj = den_stony_asteroids;
        else
            den_proj = den_metallic_asteroids;
        end

    elseif imp_type == 2

        den_proj = 600;

    else

        den_proj = 2000; % kokubo and ida (2012)

    end

    % assume impactor angle of impact is 45 degrees, gravity is Earth
    theta_proj = ang_proj;
    g = 9.81;

    % assuming spherical projectile as the impactor
    vol_proj = (4/3)*pi*(d_proj/2)^3; % convert diameter from km to m
    mass_proj = den_proj * vol_proj;
    w_proj = 0.5 * mass_proj * vel_proj^2; % total kinetic energy of projectile

    % find the target transient diameter created by the projectile
    d_tar_trans = 1.8 * den_proj^0.11 * den_tar^(-1/3) * g^(-0.22) * (d_proj)^0.13 * w_proj^0.22;

    % find the mass displaced in the crater by the projectile
    mass_disp = mass_proj * (1.6 * (1.61 * g * (d_proj)/vel_proj^2)^(-0.22) * ((pi/8)*(1/2.7)* sin(theta_proj))^(-1/3))^3;

    % find the mass of the impact melt generated
    mass_melt = mass_disp * (1.6*10^(-7)) * (g*d_tar_trans)^0.83 * vel_proj ^ 0.33;

end

