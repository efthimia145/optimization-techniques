% Amarantidou Efthymia 
% AEM: 9762
% Project [3]
    
clear;
close all;  
clc;

%% Initialize function
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

syms x y;
f = @(x,y) (1/2)*x.^2 + 2*y.^2;

f_grad = gradient(f, [x,y]);

%% Steepest descent method

epsilon = 0.01;

gamma = [0.05 0.5 2 10];
starting_point = [2 4];

min_values = zeros(1,length(gamma));

for iteration=1:length(gamma)
    
    fprintf("\nGAMMA = %.2f\n", gamma(iteration));

    [min_values(iteration)] = steepest_descent_method(f, f_grad, epsilon, starting_point, gamma(iteration));
 
end     
