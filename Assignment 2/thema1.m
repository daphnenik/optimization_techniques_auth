% Define a range of x and y values
x = linspace(-4, 4, 100);
y = linspace(-4, 4, 100);

% Create a grid of (x, y) values
[X, Y] = meshgrid(x, y);

% Evaluate the function at each point
Z = (X.^3) .* exp(-X.^2 - Y.^4);

% Create a 3D surface plot
figure;
surf(X, Y, Z);

% Label the axes and add a title
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('f(x, y) = (x^3) * e^(-x^2 - y^4)');

% Adjust the view and add a colorbar
view(3);
colorbar;
