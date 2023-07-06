clc;
clear;
close all;

load("complete_impact_2.mat");

Cmap1 = parula(4);

for i = 1:10
    if(impactor_gt_100km(i,1)>0)
        if(impactor_gt_100km(i,3)==1)
            ast_avg_gt_25(impactor_gt_100km(i,1),1) = ast_avg_gt_25(impactor_gt_100km(i,1),1) + 1/n_sims/earth_sa;

        end
    end
end

time = linspace(1,4500,4500);
time = time/1000;

smooth_ast_avg_01_10 = movmean(ast_avg_01_10,[25 250]);
smooth_ast_avg_11_25 = movmean(ast_avg_11_25,[25 250]);
smooth_ast_avg_gt_25 = movmean(ast_avg_gt_25,[25 250]);

smooth_com_avg_01_10 = movmean(com_avg_01_10,[25 250]);
smooth_com_avg_11_25 = movmean(com_avg_11_25,[25 250]);
smooth_com_avg_gt_25 = movmean(com_avg_gt_25,[25 250]);

figure(13)
subplot(1,2,1)
semilogy(time, smooth_ast_avg_01_10/1E6, 'Color', Cmap1(1,:), 'LineWidth', 4, 'LineStyle','-')
set(gca,'XDir','reverse')
hold on
semilogy(time, smooth_ast_avg_11_25/1E6, 'Color', Cmap1(2,:), 'LineWidth', 4, 'LineStyle',':')
hold on
semilogy(time, smooth_ast_avg_gt_25/1E6, 'Color', Cmap1(3,:), 'LineWidth', 4, 'LineStyle','-.')
xlim([2.0,4.0]);

legend("1 < D < 10 km", "10 < D < 25 km"," D > 25 km",  Location="northeast", fontsize=14)

% hold on
% semilogy(time, ast_avg_01_10/1E6, 'Color', Cmap1(1,:), 'LineWidth', 2, 'LineStyle','-')
% hold on
% semilogy(time, ast_avg_11_25/1E6, 'Color', Cmap1(2,:), 'LineWidth', 2, 'LineStyle','-')
% hold on
% semilogy(time, ast_avg_gt_25/1E6, 'Color', Cmap1(3,:), 'LineWidth', 2, 'LineStyle','-')


ax=gca;
xlabel('Age (GYA)')
ylabel("Asteroid Impact Flux Rate [km^{-2} yr^{-1}]")
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
saveas(ax,"ast_avg_flux.png")


%figure(14)
subplot(1,2,2)
semilogy(time, smooth_com_avg_01_10/1E6, 'Color', Cmap1(1,:), 'LineWidth', 4, 'LineStyle','-')
set(gca,'XDir','reverse')
hold on
semilogy(time, smooth_com_avg_11_25/1E6, 'Color', Cmap1(2,:), 'LineWidth', 4, 'LineStyle',':')
hold on
legend("1 < D < 10 km", "10 < D < 25 km",  Location="northeast", fontsize=14)
xlim([2.0,4.0]);
ax=gca;
xlabel('Age (GYA)')
ylabel("Comet Impact Flux Rate [km^{-2} yr^{-1}]")
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
saveas(ax,"com_avg_flux.png")
