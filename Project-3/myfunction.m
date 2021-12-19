% Amarantidou Efthymia 
% AEM: 9762
% Project [3]

clear;
close all;
clc;

%% Initialize function
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

syms x1 x2;
f = @(x1,x2) (1/2)*x1^2 + 2*x2^2;

%% Plots of function

% Function contours

figure('PaperPosition', [0.25 0.25 8 6]);
fcontour(f, [ 2*pi]);
colorbar

title("Function f(x)");
xlabel("x1");
ylabel("x2");

saveas(gcf,"figures/contours_f.pdf")

% 3D plot

figure('PaperPosition', [0.25 0.25 8 6]);
x = -20:0.5:15;
y = x';
z = (1/2)*x.^2 + 2*y.^2;

surf(x,y,z);
colorbar

title("3D Plot of f(x)");
xlabel("x1");
ylabel("x2");
zlabel("f(x)")
saveas(gcf,"figures/3d_plot_f.pdf")
