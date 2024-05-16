clear all;
close all;
clc;

% grid to plot 2D filled contour plot 
x1_range = [-10,5];
x2_range = [-8,12];
n = 60;
[x1_contour,x2_contour] = meshgrid(linspace(x1_range(1),x1_range(2),n),linspace(x2_range(1),x2_range(2),n));

for i = 1:3
    %all the cases for starting point, epsilon, gk, sk
    switch i 
        case 1
            x1_0 = 5;
            x2_0 = -5;
            epsilon = 0.01;
            sk = 5;
            gk = 0.5;
        case 2
            x1_0 = -5;
            x2_0 = 10;
            epsilon = 0.01;
            sk = 15;
            gk = 0.1;
        case 3
            x1_0 = 8;
            x2_0 = -10;
            epsilon = 0.01;
            sk = 0.1;
            gk = 0.2;
    end
    
    [x1,x2] = SteepDes_proj(x1_0,x2_0,epsilon,gk,sk,x1_range,x2_range);

    figure();
    contourf(x1_contour,x2_contour,fx1x2(x1_contour,x2_contour),'--');
    title(['f(x1,x2) contour plot - Steepest Descent, gk = ',num2str(gk),', sk = ',num2str(sk),', epsilon = ',num2str(epsilon),', x1 = ',num2str(x1_0),' x2 = ',num2str(x2_0)]);
    hold on;
    plot(x1,x2,'red');
    scatter(x1,x2,'red');
    xlabel('x1');
    ylabel('x2');
    legend('f(x1,x2)','f(x1k,x2k)');
    hold off;
    
    figure()
    k = 1:length(x1);
    plot(k,fx1x2(x1,x2),'k');
    title(['f(x1,x2) values for different k, Steepest Descent, gk = ',num2str(gk),', sk = ',num2str(sk),', epsilon = ',num2str(epsilon),', x1 = ',num2str(x1_0),' x2 = ',num2str(x2_0)]);
    hold on;
    scatter(k,fx1x2(x1,x2),'red');
    xlabel('k');
    ylabel('f(x1k,x2k)');
    legend('f(x1,x2)','f(x1k,x2k)');
    hold off;
    
end

% Steepest Descent with projection, gk constant
function [x1,x2] = SteepDes_proj(x11,x21,epsilon,gk,sk,x1_limit,x2_limit)
    if(x11<x1_limit(1))
       fprintf('\Starting point out of limits - x1 = %i\n',x11);
       x11 = x1_limit(1);
    end
    if(x11>x1_limit(2))
        fprintf('\nStarting point out of limits - x1 = %i\n',x11);
        x11 = x1_limit(2);
    end
    if(x21<x2_limit(1))
        fprintf('\nStarting point out of limits - x2 = %i\n',x21);
        x21 = x2_limit(1);
    end
    if(x21>x2_limit(2))
        fprintf('\nStarting point out of limits - x2 = %i\n',x21);
        x21 = x2_limit(2);
    end
    x1(1) = x11;
    x2(1) = x21;
    k = 1;
    while norm(grad_fx1x2(x1(k),x2(k))) > epsilon 
        d(:,k) = -grad_fx1x2(x1(k),x2(k));
        x1k_bar = x1(k)+sk*d(1,k);
        x2k_bar = x2(k)+sk*d(2,k);
        if(x1k_bar<x1_limit(1))
            x1k_bar = x1_limit(1);
        end
        if(x1k_bar>x1_limit(2))
            x1k_bar = x1_limit(2);
        end
        if(x2k_bar<x2_limit(1))
            x2k_bar = x2_limit(1);
        end
        if(x2k_bar>x2_limit(2))
            x2k_bar = x2_limit(2);
        end
        x1(k+1) = x1(k)+gk*(x1k_bar - x1(k));
        x2(k+1) = x2(k)+gk*(x2k_bar - x2(k));
        k = k + 1;
        if(k==500)
            break;
        end  
    end
end

% f(x1,x2) at (x1k,x2k)
function fk = fx1x2(x1k,x2k)
    syms x1 x2;
    f = 1/3*x1.^2 + 3*x2.^2;
    fk = subs(f,{x1,x2},{x1k,x2k});
end
% Gradient of f(x1,x2) at X1,X2
function [grad_fX1X2] = grad_fx1x2(X1,X2)
    syms x1 x2;
    f = 1/3*x1.^2 + 3*x2.^2;
    grad_f = gradient(f,[x1,x2]);
    grad_fX1X2 = subs(grad_f,[x1 x2],{X1,X2});
end