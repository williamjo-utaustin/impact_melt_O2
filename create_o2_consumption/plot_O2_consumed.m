clc;
clear;
close all;

plot_on = true;
Cmap1 = parula(10);
time = linspace(1,4500,4500);
time = time/1000;

load("melt_gen_per_mat_to_plot.mat");
load("colorblind_colormap.mat")

linestyles = ["-" ":" "--" "-."];

if plot_on == true
    fig2 = figure(2);
    fig3 = figure(3);
    fig5 = figure(5);
    fig7 = figure(7);
    fig8 = figure(8);
    fig10 = figure(10);
end


cum_O2_consumed = zeros(4500,4);
smooth_cum_O2_consumed = zeros(4500,4);
tared_smooth_cum_O2_consumed = zeros(4500,4);

fig1 = figure(1);

for j = 1:4

    cum_O2_consumed(4500,j) = O2_consumed_melt(4500,1,j);
    for i = 4499:-1:2001
        cum_O2_consumed(i,j) = cum_O2_consumed(i+1,j) + O2_consumed_melt(i,1,j);
    end
    smooth_cum_O2_consumed(:,j) = movmean(cum_O2_consumed(:,j),[0 0]);


    for i = 1:4000
        tared_smooth_cum_O2_consumed(i,j) = smooth_cum_O2_consumed(i,j) - smooth_cum_O2_consumed(4000,j);
    end

    semilogy(time(2001:4000),tared_smooth_cum_O2_consumed(2001:4000,j),Color=colorblind(2*j,:),LineStyle=linestyles(j), LineWidth=0.1);
    set(gca,'XDir','reverse')
    hold on

end
legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',20, 'Location','southeast')

xlim([2.0,4.0]);
ylim([0E21 1E22]);
ax=gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.Title.FontSize = 18;
ax.LineWidth = 2;
xlabel('Time (Ga)')
ylabel("Cumulative Consumed O_2 (kg)")
fig1.Units = 'centimeters';
fig1.Position(3) = 25;
fig1.Position(4) = 20;
%saveas(fig1,"cumulative_consumed_O2.png")


%figure(2);
fig_set([10 14],[12 1 9]);
tiledlayout('flow','TileSpacing','compact')
fig_array = [1 2 0 3 0 4 5 0 6 0];

if plot_on == true
    for j = 1:4

        for i = 2:11

            if i ~= 4 && i~= 6 && i~=9 && i~=11
                subplot(2,3,fig_array(i-1))
                if i == 2
                    for k = 2:10
                        O2_consumed_melt(:,1,j) = O2_consumed_melt(:,1,j) + O2_consumed_melt(:,k,j);
                    end
                end
                semilogy(time,O2_consumed_melt(:,i-1,j)/1E6,LineWidth=1,Color=colorblind(2*j,:), LineStyle=linestyles(j))
                set(gca,'XDir','reverse')
                hold on
            end

        end

    end


    subplot(2,3,1)
    %set(gca,'XDir','reverse')
    title('Total')
    %xlabel('Time (Ga)')
    ylabel("Rate of O_2 Consumed [kg yr^{-1}]")
    %legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',10, 'Location','northeast')
    xlim([2.0,4.0]);
    ylim([1E3 1E16]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    set(gca,'Ticklength',[0.015 0.015],'XMinorTick','on','YMinorTick','on')

%     fig2.Units = 'centimeters';
%     fig2.Position(3) = 25;
%     fig2.Position(4) = 20;
%     saveas(fig2,"total_O2.png")
    

    subplot(2,3,2)
    %set(gca,'XDir','reverse')
    title('H_2')
%     xlabel('Time (Ga)')
%     ylabel("Consumed O_2 Potential (kg)")
    %legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',10, 'Location','northeast')
    xlim([2.0,4.0]);
    ylim([1E3 1E16]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    set(gca,'Ticklength',[0.015 0.015],'XMinorTick','on','YMinorTick','on')

%     fig3.Units = 'centimeters';
%     fig3.Position(3) = 25;
%     fig3.Position(4) = 20;
    %saveas(fig2,"H2.png")

    subplot(2,3,3)
    %set(gca,'XDir','reverse')
    title('CO')
%     xlabel('Time (Ga)')
%     ylabel("Consumed O_2 Potential (kg)")
    legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',10, 'Location','northeast')
    xlim([2.0,4.0]);
    ylim([1E3 1E16]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    set(gca,'Ticklength',[0.015 0.015],'XMinorTick','on','YMinorTick','on')

%     fig3.Units = 'centimeters';
%     fig3.Position(3) = 25;
%     fig3.Position(4) = 20;
    %saveas(fig7,"CH4_O2.png")


    subplot(2,3,4)
    %set(gca,'XDir','reverse')
    title('CH_4')
    xlabel('Time (Ga)')
    ylabel("Rate of O_2 Consumed [kg yr^{-1}]")
    %legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',10, 'Location','northeast')
    xlim([2.0,4.0]);
    ylim([1E3 1E16]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    set(gca,'Ticklength',[0.015 0.015],'XMinorTick','on','YMinorTick','on')

%     fig3.Units = 'centimeters';
%     fig3.Position(3) = 25;
%     fig3.Position(4) = 20;
    %saveas(fig7,"CH4_O2.png")

    subplot(2,3,5)
    %set(gca,'XDir','reverse')
    title('H_2S')
    xlabel('Time (Ga)')
    %ylabel("Consumed O_2 Potential (kg)")
    %legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',10, 'Location','northeast')
    xlim([2.0,4.0]);
    ylim([1E3 1E16]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
    set(gca,'Ticklength',[0.015 0.015],'XMinorTick','on','YMinorTick','on')

%     fig8.Units = 'centimeters';
%     fig8.Position(3) = 25;
%     fig8.Position(4) = 20;
    %saveas(fig8,"H_2S_O2.png")

    subplot(2,3,6)
    %set(gca,'XDir','reverse')
    title('S_2')
    xlabel('Time (Ga)')
    %ylabel("Consumed O_2 Potential (kg)")
    %legend(["0.5% Gas-Melt Fraction", "1% Gas-Melt Fraction", "2% Gas-Melt Fraction", "3% Gas-Melt Fraction"],'FontSize',10, 'Location','northeast')
    xlim([2.0,4.0]);
    ylim([1E3 1E16]);
    ax=gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;
    ax.Title.FontSize = 18;
    ax.LineWidth = 2;
%     fig10.Units = 'centimeters';
%     fig10.Position(3) = 25;
%     fig10.Position(4) = 20;
    %saveas(fig10,"S2_O2.png")

    set(gca,'Ticklength',[0.015 0.015],'XMinorTick','on','YMinorTick','on')



end

fig_name='O2_consumption_by_gases.pdf';
save2pdf(fullfile(pwd,fig_name),gcf,600)
