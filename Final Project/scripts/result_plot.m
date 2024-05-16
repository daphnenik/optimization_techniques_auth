function [] = result_plot(genes,gsize,error)
% Plots to view the best result and compare with real f
size = 50;

u1 = linspace(-1, 2, size); 
u2 = linspace(-2, 1, size); 

f_aprox = zeros(size,size);
count_u1 = 1;
for i = u1
    count_u2 = 1;
    for j = u2
        f_aprox(count_u1,count_u2) = fBar(i,j,genes,gsize);
        count_u2 = count_u2 + 1;
    end
    count_u1 = count_u1 + 1;
end

fvalues = zeros(size,size);
count_u1 = 1;
for i = u1
    count_u2 = 1;
    for j = u2
        fvalues(count_u1,count_u2) = real_f(i,j);
        count_u2 = count_u2 + 1;
    end
    count_u1 = count_u1 + 1;
end

figure;

% Plot 1: f Approach plot
subplot(1,2,1);
surf(u1,u2,f_aprox);
title('f Approach 3D plot');

% Plot 2: f 3D plot
subplot(1,2,2);
surf(u1,u2,fvalues)
title('f 3D plot');

%The error of the approximation (2d and 3d representation) 

figure(5)
plot(error)
title('Error progression');

err_values = fvalues - f_aprox;

figure(6)
surf(u1,u2,err_values);
title('3D Error visualization');

end