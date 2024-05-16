clear all;
close all;
clc;

% Grid for 2D filled contour plot 
start = -8;
stop = 8;
n = 60;
[x1_contour,x2_contour] = meshgrid(linspace(start,stop,n),linspace(start,stop,n));

% Starting point
x1_0 = 6;
x2_0 = -6;

% Steepest Descent method for starting point (x1_0,x2_0) and every gk
for i = 1:4
    %testing different gk values : 0.1, 0.3, 3, 5
    switch i
        case 1
            gk = 0.1; 
        case 2
            gk = 0.3; 
        case 3
            gk = 3; 
        case 4
            gk = 5; 
    end
    epsilon = 0.001;
    [x1,x2] = steepdes_gkconst(x1_0,x2_0,gk,epsilon);
    figure();
    contourf(x1_contour,x2_contour,fx1x2(x1_contour,x2_contour),'--');
    title(['f(x1,x2) contour plot - Steepest Descent, gk = ',num2str(gk),', x1 = ',num2str(x1_0),' x2 = ',num2str(x2_0)]);
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
    title(['f(x1,x2) for different k - Steepest Descent, gk = ',num2str(gk),', x1 = ',num2str(x1_0),' x2 = ',num2str(x2_0)]);
    hold on;
    scatter(k,fx1x2(x1,x2),'red');
    xlabel('k');
    ylabel('f(x1k,x2k)');
    legend('f(x1,x2)','f(x1k,x2k)');
    hold off;
end

% Steepest Descent with constant gk 
function [x1,x2] =  steepdes_gkconst(x1_0,x2_0,gk,epsilon)
    x1(1) = x1_0;
    x2(1) = x2_0;
    k = 1;
    while norm(grad_fx1x2(x1(k),x2(k))) > epsilon
        d(:,k) = -grad_fx1x2(x1(k),x2(k));
        x1(k+1) = x1(k)+gk*d(1,k);
        x2(k+1) = x2(k)+gk*d(2,k);
        k = k + 1;       
    end
end

% Value of f(x1,x2) at (x1k,x2k)
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