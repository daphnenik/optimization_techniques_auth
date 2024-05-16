% Define a range of x and y values
x = linspace(-10, 10, 150);
y = linspace(-10, 10, 150);

% Create a grid of (x, y) values
[X, Y] = meshgrid(x, y);

% Evaluate the function at each point
Z = 1/3*X.^2 + 3*Y.^2;

% Create a 3D surface plot
figure;
surf(X, Y, Z,'EdgeColor','none');

% Label the axes and add a title
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
title('f(x1, x2) = 1/3*x1.^2 + 3*x2.^2');

% Adjust the view and add a colorbar
view(3);
colorbar;