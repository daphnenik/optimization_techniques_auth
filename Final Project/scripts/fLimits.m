function [fmin,fmax] = fLimits()

% Minimum and maximum value of f(u1,u2) to define the magnitude of the Gaussians

size = 100;
fval = zeros(size,size);

for i = 1:size
    u1 = linspace(-1,2,size);
    for j = 1:size
        u2 = linspace(-2,1,size);
        fval(i,j) = real_f(u1(i), u2(j));
    end
end
fmin = min(min(fval));
fmax = max(max(fval));
end
