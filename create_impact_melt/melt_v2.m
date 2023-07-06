clc;
clear;
close all;

color_map = true;
n_sims = 50;

[impact_ast_vel_dist, impact_ast_vel_index] = gen_ast_vel_dist();
[impact_ast_ang_dist, impact_ast_ang_index] = gen_ast_ang_dist();

[impact_com_vel_dist, impact_com_vel_index] = gen_com_vel_dist();
[impact_com_ang_dist, impact_com_ang_index] = gen_com_ang_dist();

[impact_lft_vel_dist, impact_lft_vel_index] = gen_lft_vel_dist();
[impact_lft_ang_dist, impact_lft_ang_index] = gen_lft_ang_dist();

seed_init = 4224053;

avg_ast_melt_per_mya = zeros(4500,1);
avg_com_melt_per_mya = zeros(4500,1);
avg_lft_melt_per_mya = zeros(4500,1);

asteroids_avg = zeros(4500,100);
comets_avg = zeros(4500,100);
planetestimals_avg = zeros(4500,100);

for sim_count = 1:n_sims

    disp("----- seed "+sim_count+" -----")
    seed_count = (sim_count - 1) * 23 + seed_init;

    disp(seed_count)

    histogram_impactor = [];
    load(append('../output/new_JFC/impactor_sim_',num2str(seed_count,'%08i'),'.mat'));

    impactor_gt_100km = [];
    load(append('../output/new_JFC/large_impactor_',num2str(seed_count,'%08i'),'.mat'));

    impact_ast_melt = zeros(4500,100);
    impact_com_melt = zeros(4500,100);
    impact_lft_melt = zeros(4500,100);

    asteroids = reshape(histogram_impactor(:, 1, :),[4500 100]);
    comets = reshape(histogram_impactor(:, 2, :),[4500 100]);
    planetestimals = reshape(histogram_impactor(:, 3, :),[4500 100]);

    asteroids_avg = asteroids_avg + asteroids;
    comets_avg = comets_avg + comets;
    planetestimals_avg = planetestimals_avg + planetestimals;
    
    for i = 4500:-1:2001

        if mod(i,100) == 0
            disp("-----YEAR: " +i+" -----")
        end

        for j = 1:100

            % this is the asteroid count for a year for a certain size (m)
            total_asteroid_count = asteroids(i,j);

            if total_asteroid_count > 0
                count = 0;
                while count <= total_asteroid_count

                    impact_ast_velocity = gen_impact_vel(impact_ast_vel_dist,impact_ast_vel_index);
                    impact_ast_angle = gen_impact_ang(impact_ast_ang_dist, impact_ast_ang_index);
                    impact_ast_melt(i,j) = gen_impact_melt(j,impact_ast_velocity, impact_ast_angle,1);

                    count = count + 1;
                end
            end

            % this is the comet count for a year for a certain size (m)
            total_comet_count = comets(i,j);

            if total_comet_count > 0
                count = 0;
                while count <= total_comet_count

                    impact_com_velocity = gen_impact_vel(impact_com_vel_dist,impact_com_vel_index);
                    impact_com_angle = gen_impact_ang(impact_com_ang_dist, impact_com_ang_index);
                    impact_com_melt(i,j) = gen_impact_melt(j,impact_com_velocity, impact_com_angle,2);

                    count = count + 1;
                end
            end


            % this is the planetestimal count for a year for a certain size (m)
            total_lft_count = planetestimals(i,j);

            if total_lft_count > 0
                count = 0;
                while count <= total_lft_count

                    impact_lft_velocity = gen_impact_vel(impact_lft_vel_dist,impact_lft_vel_index);
                    impact_lft_angle = gen_impact_ang(impact_lft_ang_dist, impact_lft_ang_index);
                    impact_lft_melt(i,j) = gen_impact_melt(j,impact_lft_velocity, impact_lft_angle,3);

                    count = count + 1;
                end
            end
        end
    end



    % generate impact melt for impactors > 100 km
    
    search_100km = true;
    k = 1;
    
    impact_ast_melt_extra = zeros(4500,1);
    impact_com_melt_extra = zeros(4500,1);
    impact_lft_melt_extra = zeros(4500,1);

    while search_100km == true

        time = impactor_gt_100km(k,1);
        diameter = impactor_gt_100km(k,2);

        if impactor_gt_100km(k,3) > 0
            
            if impactor_gt_100km(k,3) == 1

                impact_ast_velocity = gen_impact_vel(impact_ast_vel_dist,impact_ast_vel_index);
                impact_ast_angle = gen_impact_ang(impact_ast_ang_dist, impact_ast_ang_index);
                impact_ast_melt_extra(time,1) = impact_ast_melt_extra(time,1) + gen_impact_melt(diameter, impact_ast_velocity, impact_ast_angle,1);

            elseif impactor_gt_100km(k,3) == 2

                impact_com_velocity = gen_impact_vel(impact_com_vel_dist,impact_com_vel_index);
                impact_com_angle = gen_impact_ang(impact_com_ang_dist, impact_com_ang_index);
                impact_com_melt_extra(time,1) = impact_com_melt_extra(time,1) + gen_impact_melt(diameter, impact_com_velocity, impact_com_angle,2);

            else

                impact_com_velocity = gen_impact_vel(impact_lft_vel_dist,impact_lft_vel_index);
                impact_com_angle = gen_impact_ang(impact_lft_ang_dist, impact_lft_ang_index);
                impact_lft_melt_extra(time,1) = impact_lft_melt_extra(time,1) + gen_impact_melt(diameter, impact_lft_velocity, impact_lft_angle,2);

            end
            
            k = k + 1;    
        else
            search_100km = false;
        end
        
    end

    impacts_ast_per_mya = zeros(4500,1);
    impact_ast_melt_per_mya = zeros(4500,1);

    impacts_com_per_mya = zeros(4500,1);
    impact_com_melt_per_mya = zeros(4500,1);

    impacts_lft_per_mya = zeros(4500,1);
    impact_lft_melt_per_mya = zeros(4500,1);

    for i = 2001:4500
        impact_ast_melt_per_mya(i,1) = sum(impact_ast_melt(i,:));
        impacts_ast_per_mya(i,1) = sum(asteroids(i,:));

        impact_com_melt_per_mya(i,1) = sum(impact_com_melt(i,:));
        impacts_com_per_mya(i,1) = sum(comets(i,:));

        impact_lft_melt_per_mya(i,1) = sum(impact_lft_melt(i,:));
        impacts_lft_per_mya(i,1) = sum(planetestimals(i,:));
    end

    impact_ast_melt_per_mya = impact_ast_melt_per_mya + impact_ast_melt_extra;
    impact_com_melt_per_mya = impact_com_melt_per_mya + impact_com_melt_extra;
    impact_lft_melt_per_mya = impact_lft_melt_per_mya + impact_lft_melt_extra;

    fig = figure(1);
    semilogy(impact_ast_melt_per_mya, LineWidth=2)
    hold on
    title('Asteroid Melt Mass per MYR')
    xlabel('Time (MYA)')
    ylabel("Melt Mass (kg)")
    xlim([2000,4500]);
    ylim([1E14 1E21]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
        saveas(ax,"ast_mlt_myr.png");
    end

    fig = figure(2);
    semilogy(impacts_ast_per_mya, LineWidth=2)
    hold on
    title('Asteroid Impacts per MYR')
    xlabel('Time (MYA)')
    ylabel("Count")
    xlim([2000,4500]);
    ylim([1E0 1E4]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
        saveas(ax,"ast_imp_myr.png");
    end

    fig = figure(3);
    semilogy(impact_com_melt_per_mya, LineWidth=2)
    hold on
    title('Comet Melt Mass per MYR')
    xlabel('Time (MYA)')
    ylabel("Melt Mass (kg)")
    xlim([2000,4500]);
    ylim([1E14 1E23]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
        saveas(ax,"com_mlt_myr.png")
    end
    fig = figure(4);
    semilogy(impacts_com_per_mya, LineWidth=2)
    hold on
    title('Comet Impacts per MYR')
    xlabel('Time (MYA)')
    ylabel("Count")
    xlim([2000,4500]);
    ylim([1E0 1E4]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;

    if i == 2001
        saveas(ax,"com_imp_myr.png")
    end


    fig = figure(5);
    semilogy(impact_lft_melt_per_mya, LineWidth=2)
    hold on
    title('Leftover Melt Mass per MYR')
    xlabel('Time (MYA)')
    ylabel("Melt Mass (kg)")
    xlim([2000,4500]);
    ylim([1E14 1E23]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
            saveas(ax,"lft_mlt_myr.png")
    end

    fig = figure(6);
    semilogy(impacts_lft_per_mya, LineWidth=2)
    hold on
    title('Leftover Impacts per MYR')
    xlabel('Time (MYA)')
    ylabel("Count")
    xlim([2000,4500]);
    ylim([1E0 1E4]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    saveas(ax,"lft_imp_myr.png")

    fig = figure(7);
    semilogy(impact_ast_melt_per_mya+impact_com_melt_per_mya+impact_lft_melt_per_mya, LineWidth=2)
    hold on
    title('Total Melt Mass per MYR')
    xlabel('Time (MYA)')
    ylabel("Melt Mass (kg)")
    xlim([2000,4500]);
    ylim([1E14 1E23]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
        saveas(ax,"tot_mlt_myr.png")
    end

    fig = figure(8);
    semilogy(impacts_lft_per_mya+impacts_com_per_mya+impacts_ast_per_mya, LineWidth=2)
    hold on
    
    title('Total Impacts per MYR')
    xlabel('Time (MYA)')
    ylabel("Count")
    xlim([2000,4500]);
    ylim([1E0 1E4]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
        saveas(ax,"tot_imp_myr.png")
    end


    avg_ast_melt_per_mya = avg_ast_melt_per_mya + impact_ast_melt_per_mya;
    avg_com_melt_per_mya = avg_com_melt_per_mya + impact_com_melt_per_mya;
    avg_lft_melt_per_mya = avg_lft_melt_per_mya + impact_lft_melt_per_mya;



end

asteroids_avg = asteroids_avg/n_sims;
comets_avg = comets_avg/n_sims;
planetestimals_avg = planetestimals_avg/n_sims;



if color_map == true
    fig = figure(111);
    cm = colormap("jet");
    imagesc(asteroids_avg)
    set(gca,'ColorScale','log')
    cmc = colorbar;
    cmc.FontSize = 18;
    cmc.Label.String = "Count";
    cmc.Label.FontSize = 18;
    clim([1E-1 1E5])
    xlim([0.5,25.5]);
    ylim([2000, 4500])
    title('Asteroid Size Count from 4.5 to 2.0 GYA')
    ylabel('Time (MYA)')
    xlabel("Diameter (km)")
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';  
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
        saveas(ax,"ast_heatmap_count.png")
    end


    fig = figure(112);
    cn = colormap("jet");
    imagesc(comets_avg)
    set(gca,'ColorScale','log')
    cnc = colorbar;
    cnc.FontSize = 18;
    cnc.Label.String = "Count";
    cnc.Label.FontSize = 18;
    clim([1E-1 1E5])
    xlim([0.5,25.5]);
    ylim([2000, 4500])
    title('Comet Size Count from 4.5 to 2.0 GYA')
    ylabel('Time (MYA)')
    xlabel("Diameter (km)")
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';  
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i ==2001    
        saveas(ax,"com_heatmap_count.png")
    end

    fig = figure(113);
    co = colormap("jet");
    imagesc(planetestimals_avg)
    set(gca,'ColorScale','log')
    coc = colorbar;
    coc.FontSize = 18;
    coc.Label.String = "Count";
    coc.Label.FontSize = 18;
    clim([1E-1 1E5])
    xlim([0.5,25.5]);
    ylim([2500, 4500])
    title('Planetestimal Leftover Size Count from 4.5 to 2.0 GYA')
    ylabel('Time (MYA)')
    xlabel("Diameter (km)")
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    fig.Units = 'centimeters';  
    fig.Position(3) = 25;
    fig.Position(4) = 20;
    if i == 2001
        saveas(ax,"lft_heatmap_count.png")
    end

end


avg_ast_melt_per_mya = avg_ast_melt_per_mya/n_sims;
smooth_avg_ast_melt_per_mya = movmean(avg_ast_melt_per_mya,[100 100]);

avg_com_melt_per_mya = avg_com_melt_per_mya/n_sims;
smooth_avg_com_melt_per_mya = movmean(avg_com_melt_per_mya,[100 100]);

avg_lft_melt_per_mya = avg_lft_melt_per_mya/n_sims;
smooth_avg_lft_melt_per_mya = movmean(avg_lft_melt_per_mya,[100 100]);

smooth_avg_tot_melt_per_mya = movmean(avg_ast_melt_per_mya + avg_com_melt_per_mya + avg_lft_melt_per_mya,[100 100]);

fig = figure(9);
semilogy(avg_ast_melt_per_mya,LineWidth=3, Color='blue')
hold on
%semilogy(smooth_avg_ast_melt_per_mya)
title('Average Asteroid Melt Mass per MYR')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig.Units = 'centimeters';
fig.Position(3) = 25;
fig.Position(4) = 20;
saveas(ax,"avg_ast_mlt_mass.png")



fig = figure(10);
semilogy(avg_com_melt_per_mya, LineWidth=2, Color='blue')
hold on
%semilogy(smooth_avg_com_melt_per_mya,LineWidth=3)
title('Average Comet Melt Mass per MYR')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig.Units = 'centimeters';
fig.Position(3) = 25;
fig.Position(4) = 20;
saveas(ax,"avg_com_mlt_mass.png")


fig = figure(11);
semilogy(avg_lft_melt_per_mya, LineWidth=2, Color='blue')
hold on
%semilogy(smooth_avg_lft_melt_per_mya,LineWidth=3)
title('Average Planetestimal Leftover Melt Mass per MYR')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig.Units = 'centimeters';
fig.Position(3) = 25;
fig.Position(4) = 20;
saveas(ax,"avg_lft_mlt_mass.png")

fig = figure(12);
semilogy(avg_ast_melt_per_mya+avg_com_melt_per_mya+avg_lft_melt_per_mya, LineWidth=2, Color='blue')
hold on
%semilogy(smooth_avg_tot_melt_per_mya,LineWidth=3)
title('Average Total Melt Mass per MYR')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig.Units = 'centimeters';
fig.Position(3) = 25;
fig.Position(4) = 20;
saveas(ax,"avg_tot_mlt_mass.png")




    % smooth_impacts_ast_per_mya = movmean(impacts_ast_per_mya,[10 10]);
    % smooth_impact_ast_melt_per_mya = movmean(impact_ast_melt_per_mya,[100 100]);
    %
    % smooth_impacts_com_per_mya = movmean(impacts_com_per_mya,[10 10]);
    % smooth_impact_com_melt_per_mya = movmean(impact_com_melt_per_mya,[100 100]);
    %
    % smooth_impacts_lft_per_mya = movmean(impacts_lft_per_mya,[10 10]);
    % smooth_impact_lft_melt_per_mya = movmean(impact_lft_melt_per_mya,[100 100]);


% if color_map == True
%     figure(1)
%     cm = colormap("jet");
%     imagesc(asteroids)
%     set(gca,'ColorScale','log')
%     colorbar;
%     clim([1E-1 1E7])
%     xlim([0.5,20.5]);
%     ylim([2500, 4500])
%     ylabel('Time (MYA)')
%     xlabel("Diameter (km)")
%     ax=gca;
%     ax.XAxis.FontSize = 14;
%     ax.YAxis.FontSize = 14;
%     ax.XLabel.FontSize = 14;
%     ax.YLabel.FontSize = 14;
%     ax.Title.FontSize = 18;
% 
% 
%     figure(2)
%     cn = colormap("jet");
%     imagesc(comets)
%     set(gca,'ColorScale','log')
%     colorbar;
%     clim([1E-1 1E7])
%     xlim([0.5,20.5]);
%     ylim([2500, 4500])
%     ylabel('Time (MYA)')
%     xlabel("Diameter (km)")
%     ax=gca;
%     ax.XAxis.FontSize = 14;
%     ax.YAxis.FontSize = 14;
%     ax.XLabel.FontSize = 14;
%     ax.YLabel.FontSize = 14;
%     ax.Title.FontSize = 18;
% 
%     figure(3)
%     co = colormap("jet");
%     imagesc(planetestimals)
%     set(gca,'ColorScale','log')
%     colorbar;
%     clim([1E-1 1E7])
%     xlim([0.5,20.5]);
%     ylim([2500, 4500])
%     ylabel('Time (MYA)')
%     xlabel("Diameter (km)")
%     ax=gca;
%     ax.XAxis.FontSize = 14;
%     ax.YAxis.FontSize = 14;
%     ax.XLabel.FontSize = 14;
%     ax.YLabel.FontSize = 14;
%     ax.Title.FontSize = 18;
% 
%     figure(4)
%     cp = colormap("jet");
%     imagesc(impact_ast_melt)
%     set(gca,'ColorScale','log')
%     colorbar;
%     %clim([1E-1 1E7])
%     xlim([0.5,20.5]);
%     ylim([2500, 4500])
%     xlabel('Time (MYA)')
%     ylabel("Melt Mass (kg)")
%     ax=gca;
%     ax.XAxis.FontSize = 14;
%     ax.YAxis.FontSize = 14;
%     ax.XLabel.FontSize = 14;
%     ax.YLabel.FontSize = 14;
%     ax.Title.FontSize = 18;
% 
%     figure(5)
%     cq = colormap("jet");
%     imagesc(impact_com_melt)
%     set(gca,'ColorScale','log')
%     colorbar;
%     %clim([1E-1 1E7])
%     xlim([0.5,20.5]);
%     ylim([2500, 4500])
%     xlabel('Time (MYA)')
%     ylabel("Melt Mass (kg)")
%     ax=gca;
%     ax.XAxis.FontSize = 14;
%     ax.YAxis.FontSize = 14;
%     ax.XLabel.FontSize = 14;
%     ax.YLabel.FontSize = 14;
%     ax.Title.FontSize = 18;
% end


% figure(6)
% semilogy(impact_ast_melt_per_mya)
% hold on
% semilogy(smooth_impact_ast_melt_per_mya, LineWidth=4)
% 
% title('Asteroid Melt Mass per MYA')
% xlabel('Time (MYA)')
% ylabel("Melt Mass (kg)")
% xlim([2000,4500]);
% ylim([1E14 1E21]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;
% 
% figure(7)
% semilogy(impacts_ast_per_mya)
% hold on
% semilogy(smooth_impacts_ast_per_mya, LineWidth=4)
% 
% title('Asteroid Impacts per MYA')
% xlabel('Time (MYA)')
% ylabel("Count")
% xlim([2000,4500]);
% ylim([1E0 1E4]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;
% 
% 
% figure(8)
% semilogy(impact_com_melt_per_mya)
% hold on
% semilogy(smooth_impact_com_melt_per_mya, LineWidth=4)
% 
% title('Comet Melt Mass per MYA')
% xlabel('Time (MYA)')
% ylabel("Melt Mass (kg)")
% xlim([2000,4500]);
% ylim([1E14 1E21]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;
% 
% figure(9)
% semilogy(impacts_com_per_mya)
% hold on
% semilogy(smooth_impacts_com_per_mya, LineWidth=4)
% 
% title('Comet Impacts per MYA')
% xlabel('Time (MYA)')
% ylabel("Count")
% xlim([2000,4500]);
% ylim([1E0 1E4]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;
% 
% 
% figure(10)
% semilogy(impact_lft_melt_per_mya)
% hold on
% semilogy(smooth_impact_lft_melt_per_mya, LineWidth=4)
% 
% title('Leftover Melt Mass per MYA')
% xlabel('Time (MYA)')
% ylabel("Melt Mass (kg)")
% xlim([2000,4500]);
% ylim([1E14 1E21]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;
% 
% figure(11)
% semilogy(impacts_lft_per_mya)
% hold on
% semilogy(smooth_impacts_lft_per_mya, LineWidth=4)
% 
% title('Leftover Impacts per MYA')
% xlabel('Time (MYA)')
% ylabel("Count")
% xlim([2000,4500]);
% ylim([1E0 1E4]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;
% 
% figure(12)
% semilogy(impact_ast_melt_per_mya+impact_com_melt_per_mya+impact_lft_melt_per_mya)
% hold on
% semilogy(smooth_impact_ast_melt_per_mya, LineWidth=4)
% 
% semilogy(smooth_impact_com_melt_per_mya, LineWidth=4)
% 
% semilogy(smooth_impact_lft_melt_per_mya, LineWidth=4)
% 
% title('Total Melt Mass per MYA')
% xlabel('Time (MYA)')
% ylabel("Melt Mass (kg)")
% xlim([2000,4500]);
% ylim([1E14 1E21]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;
% 
% 
% figure(13)
% semilogy(impacts_lft_per_mya+impacts_com_per_mya+impacts_ast_per_mya)
% hold on
% semilogy(smooth_impacts_ast_per_mya, LineWidth=4)
% hold on
% semilogy(smooth_impacts_com_per_mya, LineWidth=4)
% hold on
% semilogy(smooth_impacts_lft_per_mya, LineWidth=4)
% hold on
% 
% title('Total Impacts per MYA')
% xlabel('Time (MYA)')
% ylabel("Count")
% xlim([2000,4500]);
% ylim([1E0 1E4]);
% ax=gca;
% ax.XAxis.FontSize = 14;
% ax.YAxis.FontSize = 14;
% ax.XLabel.FontSize = 14;
% ax.YLabel.FontSize = 14;
% ax.Title.FontSize = 18;