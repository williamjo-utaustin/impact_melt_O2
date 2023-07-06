%% 
clc;
clear;
close all;

Cmap1 = parula(10);
Markers={'o' '+' '*' '.' 'x' '_' '|' 'square' 'diamond' '^' 'v'};
LineTypes={'-'	'--' ':' '-.' '-' '--' ':' '-'	'--' ':' '-.' '-' '--' ':'};
data_file = readtable("o2_ratios.xlsx");
data = table2array(data_file);

fig = figure(1);
for i = 2:9
    
    semilogy(data(:,1),data(:,i), 'Color', Cmap1(i,:), 'LineWidth', 3, 'Marker', Markers{i},'MarkerSize',10,'LineStyle', LineTypes{i});
    hold on
   
end
title('Mole Percent of Melt Gases vs. Gas Melt Fraction')
xlabel('Gas-Melt Fraction')
ylabel("Mole Percent (%)")
legend("H_2", "H_2O", "CO", "CO_2", "CH_4", "H_2S", "SO_2", "S_2", 'Location','eastoutside')
xlim([0.5,3]);
ylim([0 100]);
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



load("melt_50_sims_mini.mat")
tot_melt_per_mya = avg_ast_melt_per_mya + avg_com_melt_per_mya;

fig2 = figure(2);
fig3 = figure(3);
fig5 = figure(5);
fig7 = figure(7);
fig8 = figure(8);
fig10 = figure(10);
O2_consumed_melt = zeros(4500,10,4);
gas_melt_frac = [0.5 1.0 2.0 3.0];

disp("here")
for j = 1:4
    frac_gas = gas_melt_frac(j);
    for i = 4500:-1:2001
        if mod(i,100) == 0
            disp(i)
        end
        mass_O2_consumed = o2_consumption(tot_melt_per_mya(i,1),frac_gas);
        
        for h = 2:10
            O2_consumed_melt(i,h,j) = mass_O2_consumed(h-1);
        end

        O2_consumed_melt(i,1,j) = sum(mass_O2_consumed);

    end

    for i = 2:11
        
        if i ~= 4 && i~= 6 && i~=9 && i~=11 
            figure(i)
            semilogy(O2_consumed_melt(:,i-1,j),LineWidth=3)
            hold on
        end

    end

end

figure(2)
set(gca,'XDir','reverse')
title('Total Consumed O_2 Potential vs. Age (MYA)')
xlabel('Time (MYA)')
ylabel("Consumed O_2 Potential (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',16, 'Location','southeast')
% xlim([2000,4500]);
% ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig2.Units = 'centimeters';
fig2.Position(3) = 25;
fig2.Position(4) = 20;
saveas(fig2,"total_O2.png")



figure(3)
set(gca,'XDir','reverse')
title('Consumed O_2 Potential Due to H_2 vs. Age (MYA)')
xlabel('Time (MYA)')
ylabel("Consumed O_2 Potential (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',16, 'Location','southeast')
% xlim([2000,4500]);
% ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig3.Units = 'centimeters';
fig3.Position(3) = 25;
fig3.Position(4) = 20;
saveas(fig3,"H2_O2.png")

figure(5)
set(gca,'XDir','reverse')
title('Consumed O_2 Potential Due to CO vs. Age (MYA)')
xlabel('Time (MYA)')
ylabel("Consumed O_2 Potential (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',16, 'Location','southeast')
% xlim([2000,4500]);
% ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig5.Units = 'centimeters';
fig5.Position(3) = 25;
fig5.Position(4) = 20;
saveas(fig5,"CO_O2.png")

figure(7)
set(gca,'XDir','reverse')
title('Consumed O_2 Potential Due to CH_4 vs. Age (MYA)')
xlabel('Time (MYA)')
ylabel("Consumed O_2 Potential (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',16, 'Location','southeast')
% xlim([2000,4500]);
% ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig7.Units = 'centimeters';
fig7.Position(3) = 25;
fig7.Position(4) = 20;
saveas(fig7,"CH4_O2.png")

figure(8)
set(gca,'XDir','reverse')
title('Consumed O_2 Potential Due to H_2S vs. Age (MYA)')
xlabel('Time (MYA)')
ylabel("Consumed O_2 Potential (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',16, 'Location','southeast')
% xlim([2000,4500]);
% ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig8.Units = 'centimeters';
fig8.Position(3) = 25;
fig8.Position(4) = 20;
saveas(fig8,"H_2S_O2.png")

figure(10)
set(gca,'XDir','reverse')
title('Consumed O_2 Potential Due to S_2 vs. Age (MYA)')
xlabel('Time (MYA)')
ylabel("Consumed O_2 Potential (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',16, 'Location','southeast')
% xlim([2000,4500]);
% ylim([1E14 1E23]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig10.Units = 'centimeters';
fig10.Position(3) = 25;
fig10.Position(4) = 20;
saveas(fig10,"S2_O2.png")


