function y = impact_flux(x, a, b, c)
    y = a * exp(b*x) + abs(c) * x;
end

