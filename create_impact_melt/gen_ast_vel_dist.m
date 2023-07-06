function [histogram, bin_velocity] = gen_ast_vel_dist()

%     x_plot = linspace(8.5,49.5,40);
%     y_plot = 0.0016 + ((1.9 ./(0.25 .* x_plot .* sqrt(2*pi))) .* exp(-(log(x_plot./16.17)).^2/(2.*0.25.^2)));
%     
%     semilogy(x_plot,y_plot);
%     hold on
    
    y = @(x) 0.0016 + ((1.9 ./(0.25 .* x .* sqrt(2*pi))) .* exp(-(log(x./16.17)).^2/(2.*0.25.^2))); 
    
    
    bin_area = zeros(41,1);
    bin_velocity = zeros(41,1);
    for i = 9:49
        
        bin_area(i-8,1) = integral(y,i-0.5,i+0.5);
        bin_velocity(i-8,1) = i;
    
    end
    
    total_area = sum(bin_area);
    histogram = bin_area/total_area;

end



