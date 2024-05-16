function fit = fitnessFunc(genes,size)
% The score of each candidate is the mse of the approximation to the real
% value of f. 

u1Lim = [-1 2];
u2Lim = [-2 1];

squared_diff = 0;

n = 25;

for u1 = linspace(u1Lim(1),u1Lim(2),n)
    for u2 = linspace(u2Lim(1),u2Lim(2),n)
    squared_diff = squared_diff + (real_f(u1,u2) - fBar(u1,u2,genes,size))^2;
    end
end
fit = squared_diff/(n^2); %mse
end

