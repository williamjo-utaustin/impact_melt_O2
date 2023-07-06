clc;
clear;
close all;

load('sim_1.mat')

rng(4224054);

asteroids = reshape(histogram_impactor(:, 1, :),[4500 100]);
comets = reshape(histogram_impactor(:, 2, :),[4500 100]);
planetestimals = reshape(histogram_impactor(:, 3, :),[4500 100]);

[impact_ast_vel_dist, impact_ast_vel_index] = gen_ast_vel_dist();
[impact_ast_ang_dist, impact_ast_ang_index] = gen_ast_ang_dist();

[impact_com_vel_dist, impact_com_vel_index] = gen_com_vel_dist();
[impact_com_ang_dist, impact_com_ang_index] = gen_com_ang_dist();

[impact_lft_vel_dist, impact_lft_vel_index] = gen_lft_vel_dist();
[impact_lft_ang_dist, impact_lft_ang_index] = gen_lft_ang_dist();


impact_ast_melt = zeros(4500,100);
impact_com_melt = zeros(4500,100);
impact_lft_melt = zeros(4500,100);

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

smooth_impacts_ast_per_mya = movmean(impacts_ast_per_mya,[10 10]);
smooth_impact_ast_melt_per_mya = movmean(impact_ast_melt_per_mya,[100 100]);

smooth_impacts_com_per_mya = movmean(impacts_com_per_mya,[10 10]);
smooth_impact_com_melt_per_mya = movmean(impact_com_melt_per_mya,[100 100]);

smooth_impacts_lft_per_mya = movmean(impacts_lft_per_mya,[10 10]);
smooth_impact_lft_melt_per_mya = movmean(impact_lft_melt_per_mya,[100 100]);

figure(1)
cm = colormap("jet");
imagesc(asteroids)
set(gca,'ColorScale','log')
colorbar;
clim([1E-1 1E7])
xlim([0.5,20.5]);
ylim([2500, 4500])
ylabel('Time (MYA)')
xlabel("Diameter (km)")
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;


figure(2)
cn = colormap("jet");
imagesc(comets)
set(gca,'ColorScale','log')
colorbar;
clim([1E-1 1E7])
xlim([0.5,20.5]);
ylim([2500, 4500])
ylabel('Time (MYA)')
xlabel("Diameter (km)")
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(3)
co = colormap("jet");
imagesc(planetestimals)
set(gca,'ColorScale','log')
colorbar;
clim([1E-1 1E7])
xlim([0.5,20.5]);
ylim([2500, 4500])
ylabel('Time (MYA)')
xlabel("Diameter (km)")
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(4)
cq = colormap("jet");
imagesc(impact_ast_melt)
set(gca,'ColorScale','log')
colorbar;
%clim([1E-1 1E7])
xlim([0.5,20.5]);
ylim([2500, 4500])
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(5)
cp = colormap("jet");
imagesc(impact_com_melt)
set(gca,'ColorScale','log')
colorbar;
%clim([1E-1 1E7])
xlim([0.5,20.5]);
ylim([2500, 4500])
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(6)
semilogy(impact_ast_melt_per_mya)
hold on
semilogy(smooth_impact_ast_melt_per_mya, LineWidth=4)
grid on
title('Asteroid Melt Mass per MYA')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E21]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(7)
semilogy(impacts_ast_per_mya)
hold on
semilogy(smooth_impacts_ast_per_mya, LineWidth=4)
grid on
title('Asteroid Impacts per MYA')
xlabel('Time (MYA)')
ylabel("Count")
xlim([2000,4500]);
ylim([1E0 1E4]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;


figure(8)
semilogy(impact_com_melt_per_mya)
hold on
semilogy(smooth_impact_com_melt_per_mya, LineWidth=4)
grid on
title('Comet Melt Mass per MYA')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E21]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(9)
semilogy(impacts_com_per_mya)
hold on
semilogy(smooth_impacts_com_per_mya, LineWidth=4)
grid on
title('Comet Impacts per MYA')
xlabel('Time (MYA)')
ylabel("Count")
xlim([2000,4500]);
ylim([1E0 1E4]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;


figure(10)
semilogy(impact_lft_melt_per_mya)
hold on
semilogy(smooth_impact_lft_melt_per_mya, LineWidth=4)
grid on
title('Leftover Melt Mass per MYA')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E21]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(11)
semilogy(impacts_lft_per_mya)
hold on
semilogy(smooth_impacts_lft_per_mya, LineWidth=4)
grid on
title('Leftover Impacts per MYA')
xlabel('Time (MYA)')
ylabel("Count")
xlim([2000,4500]);
ylim([1E0 1E4]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;

figure(12)
semilogy(impact_ast_melt_per_mya+impact_com_melt_per_mya+impact_lft_melt_per_mya)
hold on
semilogy(smooth_impact_ast_melt_per_mya, LineWidth=4)
grid on
semilogy(smooth_impact_com_melt_per_mya, LineWidth=4)
grid on
semilogy(smooth_impact_lft_melt_per_mya, LineWidth=4)
grid on
title('Total Melt Mass per MYA')
xlabel('Time (MYA)')
ylabel("Melt Mass (kg)")
xlim([2000,4500]);
ylim([1E14 1E21]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;


figure(13)
semilogy(impacts_lft_per_mya+impacts_com_per_mya+impacts_ast_per_mya)
hold on
semilogy(smooth_impacts_ast_per_mya, LineWidth=4)
hold on
semilogy(smooth_impacts_com_per_mya, LineWidth=4)
hold on
semilogy(smooth_impacts_lft_per_mya, LineWidth=4)
hold on
grid on
title('Total Impacts per MYA')
xlabel('Time (MYA)')
ylabel("Count")
xlim([2000,4500]);
ylim([1E0 1E4]);
ax=gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;
ax.Title.FontSize = 18;