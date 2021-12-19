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

%% Steepest descent method with Projection

epsilon = [0.01 0.02 0.01];

gamma = [0.05 0.3 0.1];
starting_point = [10 -5; -7 5; 17 -5];

alpha = [-15 -20];
beta = [15 12];
sk = [8 10 0.5];

min_value = zeros(1, length(starting_point));

for iteration=1:length(starting_point)
    
    fprintf("\n[============= Iteration #%d =============] \n", iteration);
    fprintf("\nEPSILON = %.2f\n", epsilon(iteration));
    fprintf("\nGAMMA = %.2f\n", gamma(iteration));
    fprintf("\nSTARTING POINT = (%.2f, %.2f)\n", starting_point(iteration, 1), starting_point(iteration,2));
    fprintf("\nSK = %.1f\n", sk(iteration));

    min_value = steepest_descent_projection_method(f, f_grad, epsilon(iteration), starting_point(iteration, :), gamma(iteration), ...
                                                                                                                                        sk(iteration), alpha, beta);
end
