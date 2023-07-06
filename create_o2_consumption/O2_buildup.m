clc;
clear;
close all;

age = linspace(1,4500,4500);

conv_factor = 10^12*32/(10^3);

%F_m = (0.19451*(age/1000).^5 - 2.22465*(age/1000).^4 + 10.05408*(age/1000).^3 - 21.78742*(age/1000).^2 + 23.36993*(age/1000) + 1.08404)*conv_factor;
F_m = (0.38763*(age/1000).^6 - 5.64481*(age/1000).^5 + 33.20065*(age/1000).^4 - 100.29940*(age/1000).^3 + 163.63397*(age/1000).^2 - 135.35683*(age/1000) + 54.99517)*conv_factor;
F_e = ((1.02422E-4)*(age/1000).^(8.49987))*conv_factor;
F_source = (F_m + F_e)*1E6;
figure(1);


load("O2_Consumed_Melt.mat");

% for j = 1:4
%     semilogy(O2_consumed_melt(:,1,j), LineWidth=3)
%     hold on
% end

Cmap1 = parula(5);
Markers={'o' '+' '*' '.' 'x' '_' '|' 'square' 'diamond' '^' 'v'};
LineTypes={'-'	'--' ':' '-.' '-' '--' ':' '-'	'--' ':' '-.' '-' '--' ':'};
semilogy(age,F_source,'Color', Cmap1(1,:), 'LineWidth', 3,'LineStyle', LineTypes{1})
hold on
semilogy(age,F_m*1E6,'Color', Cmap1(2,:), 'LineWidth', 3, 'LineStyle', LineTypes{2})
hold on
semilogy(age,F_e*1E6,'Color', Cmap1(3,:), 'LineWidth', 3, 'LineStyle', LineTypes{3})
hold on

excess_O2 = zeros(4500,4);

figure(2);
balance_plot = zeros(4,4500);

for j = 1:4

    balance = 0;

    for i = 4500:-1:2001

        excess_O2(i,j) = F_source(i) - O2_consumed_melt(i,1,j);
        balance = balance + excess_O2(i,j);
        balance_plot(j,i) = balance;
        disp(balance)
    end

     plot(age(2001:4500),balance_plot(j,2001:4500),'Color', Cmap1(j,:), 'LineWidth', 3,'LineStyle', LineTypes{j})
     hold on
end







figure(3);
for j = 1:4
    
    drop_size = balance_plot(j,3632) - balance_plot(j,3631);
    disp(drop_size)
    for i = 2001:3631

        balance_plot(j,i) = balance_plot(j,i) + drop_size;

    end
    plot(age(2001:4500),balance_plot(j,2001:4500),'Color', Cmap1(j,:), 'LineWidth', 3,'LineStyle', LineTypes{j})
    hold on

end

figure(4);
min_index = zeros(1,4);
min_frac = [0.5 1 2 3];

for j = 1:4
    
    [M,min_index(1,j)] = min(balance_plot(j,2001:4500));

end

plot(min_frac,min_index+2000)


figure(1)
title('O_2 Production in 1 MYR Bins')
xlabel('Age (MYA)')
ylabel("O_2 Produced (kg)")
% legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction", "O_2 Source"],'FontSize',16, 'Location','southeast')
legend(["Total O_2 Production", "O_2 Production from Organic Carbon Burial", "O_2 Production from Hydrogen Escape"],'FontSize',16, 'Location','southeast')
xlim([2000,4500]);
ylim([1E14 1E20]);
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
%saveas(fig2,"total_O2.png")

figure(2)
plot([2001,4500],[0,0], 'k--', LineWidth=3)
title('Evolution of O_2 Mass in the Atmosphere')
xlabel('Age (MYA)')
ylabel("O_2 Surplus (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize', 16, 'Location','northeast')
xlim([2000,4500]);
ylim([-4E21 4E21]);
ax=gca;
ax.YAxis.Exponent = 0;
ytickformat('%.1e');
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig2.Units = 'centimeters';
fig2.Position(3) = 25;
fig2.Position(4) = 20;
%saveas(fig2,"total_O2.png")

figure(3)
plot([2001,4500],[0,0], 'k--', LineWidth=3)
title('Evolution of O_2 Mass in the Atmosphere')
xlabel('Age (MYA)')
ylabel("O_2 Surplus (kg)")
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize', 16, 'Location','northeast')
xlim([2000,4500]);
ylim([-4E21 4E21]);
ax=gca;
ax.YAxis.Exponent = 0;
ytickformat('%.1e');
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
fig2.Units = 'centimeters';
fig2.Position(3) = 25;
fig2.Position(4) = 20;
%saveas(fig2,"total_O2.png")