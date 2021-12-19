% Amarantidou Efthymia 
% AEM: 9762
% Project [2]

clear;
close all;
clc;

%% Initialize function & Calculate gradient
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

syms x y;
f = @(x,y) (x.^3).*exp(-(x.^2)-(y.^4));

f_grad = gradient(f, [x,y]);
f_hessian = hessian(f, [x,y]);

%% Newton method

epsilon = 0.01;

xy = [0 0; -1 -1; 1 1];

min_values = zeros(1,3);

for iteration=1:length(xy)
    starting_point = xy(iteration,:);
    fprintf("\nSTARTING POINT = [%d, %d]\n", starting_point(1), starting_point(2));

    for i=1:3
        step_selection = i; % For multiple gk calculation methods
        [min(i)] = newton_method(f, f_grad, f_hessian, epsilon, starting_point, step_selection);
    end
    
end

