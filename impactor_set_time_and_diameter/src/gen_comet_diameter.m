function [freq_comets,d_comets] = gen_comet_diameter(size)

    if size == 1 % for Asteroids 1 - 10km in Diameter
        d_start = 1.0;
        d_end = 25;
        impactor_interval = 0.1;
    end

    num_partitions = int32((d_end - d_start)/impactor_interval);
    d = linspace(d_start,d_end,num_partitions);
    freq_funct = zeros(1,num_partitions);


    % Created for JSCs
    for i = 1:num_partitions

        freq_funct(1,i) = 21.956*exp(-0.468*d(i));

    end

     % create stops from Excel for comets
%     stop_1 = 6.568633136;
% 
%     for i = 1:num_partitions
% 
%         if d(i) >= 1 && d(i) < stop_1
%             
%             freq_funct(1,i) = 4.663135E8 * exp(-6.293884E-1*d(i));
%             
%         elseif d(i) >= stop_1 
% 
%             freq_funct(1,i) = 4.968553E9*d(i)^(-3.442054);
% 
%         else
%             
%             disp("Bounds don't work!");
%         
%         end
% 
%     end

    d_comets = d(1:num_partitions-1);
    freq_comets = zeros(1,num_partitions-1);

    for i = 1: num_partitions - 1
        
        freq_comets(i) = freq_funct(i) - freq_funct(i+1);

    end



end

