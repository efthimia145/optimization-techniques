% Amarantidou Efthymia 
% AEM: 9762
% Project [2]

clear;
close all;
clc;

%% Initialize function
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

syms x y;
f = @(x,y) (x.^3).*exp(-(x.^2)-(y.^4));

%% Plots of function

% Contours diagram of f1
figure(1);
fcontour(f);
colorbar
title("Function f(x,y)");
xlabel("x");
ylabel("y");
saveas(gcf,"figures/contours_f.pdf")

% 3D plot
figure(2);
x = -4:0.1:4;
y = x';
z = (x.^3).*exp(-(x.^2)-(y.^2));
[px,py] = gradient(z);

surf(x,y,z);
colorbar
title("3D Plot of f(x,y)");
xlabel("x");
ylabel("y");
zlabel("f(x,y)")
saveas(gcf,"figures/3d_plot_f.pdf")
