function [output, total, histogram] = count_per_mya(F_input)
    
    output = zeros(4499,1);

    for i = 1:4499
        output(i,1) = F_input(i+1) - F_input(i);
    end

    total = sum(output);
    histogram = output / total;
end

