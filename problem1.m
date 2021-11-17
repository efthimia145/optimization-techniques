% Amarantidou Efthymia 
% AEM: 9762
% Project [1]

clear;
close all;
clc;

%% Initialize functions 
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

x = linspace(-4, 4);

f1 = @(x) (x-3).^2 + (sin(x+3)).^2;
f2 = @(x) (x-1).*cos(x./2) + x.^2;
f3 = @(x) (x+2).^2 + exp(x-2).*sin(x+3);

% Plot the functions
functions = figure('Name', 'Initial Functions', 'NumberTitle', 'off');
hold on
plot(x, f1(x));
plot(x, f2(x));
plot(x, f3(x), 'g');
title('Initial Functions Minimum [Bisection Method]', 'FontSize', 23);
legend('f_{1}(x)', 'f_{2}(x)', 'f_{3}(x)', 'FontSize', 18, 'Position',[0.7 0.7 0.2 0.2]);
xlabel('x', 'FontSize', 23);
ylabel('f_{i}(x)', 'FontSize', 23);
grid on

%% Problem 1 / Question 1

l = 0.01; 
epsilon = [4e-3 5e-4 1e-4 5e-5 1e-5];
a = -4;
b = 4;

k = zeros(size(epsilon, 2), 3);
minimum = zeros(size(epsilon, 2), 3);

% Find the minimums via bisection method for different values of epsilon. 
for i=1:size(epsilon,2)
    [minimum(i, 1), k(i, 1), ~, ~] = bisection_method(f1, l, epsilon(i), a, b);
    [minimum(i, 2), k(i, 2), ~, ~] = bisection_method(f2, l, epsilon(i), a, b);
    [minimum(i, 3), k(i, 3), ~, ~] = bisection_method(f3, l, epsilon(i), a, b);
end

% Plot the minimums on the figures' plot.
symbol = ['--' '*' '+', 'o' 'x'];

for iteration=1:size(epsilon, 2)
    figure(functions);
    plot(minimum(iteration,1), f1(minimum(iteration,1)), ['b' symbol(iteration)])
    plot(minimum(iteration,2), f2(minimum(iteration,2)), ['r' symbol(iteration)])
    plot(minimum(iteration,3), f3(minimum(iteration,3)), ['g' symbol(iteration)])
    legend('f1(x)', 'f2(x)', 'f3(x)', 'x1*', 'x2*', 'x3*');
end

%% Problem 1 / Question 2

l = [1e-1 5e-2 1e-2];
epsilon = 0.001;
minimum = zeros(size(l, 2), 3);
k = zeros(size(epsilon, 2), 3);

% Find the minimums via bisection method for different values of l. 

for i=1:size(l, 2)
    [minimum(i, 1), k(i, 1), ak1, bk1] = bisection_method(f1, l(i), epsilon, a, b);
    [minimum(i, 2), k(i, 2), ak2, bk2] = bisection_method(f2, l(i), epsilon, a, b);
    [minimum(i, 3), k(i, 3), ak3, bk3] = bisection_method(f3, l(i), epsilon, a, b);
    
    f1_intervals = figure('Name', 'f1 Intervals', 'NumberTitle', 'off');
    hold on;
    plot(ak1);
    plot(bk1);
    title(['Limits in each iteration for l = ' num2str(l(i)) ' [f_{1}(x)]'], 'FontSize', 18)
    xlabel('k', 'FontWeight','bold', 'FontSize', 23)
    ylabel('ak/ bk', 'FontWeight','bold', 'FontSize', 23)
    legend('ak', 'bk', 'FontSize', 18);
    hold off;

    f2_intervals = figure('Name', 'f2 Intervals', 'NumberTitle', 'off');
    hold on;
    plot(ak2);
    plot(bk2);
    title(['Limits in each iteration for l = ' num2str(l(i)) ' [f_{2}(x)]'], 'FontSize', 18)
    xlabel('k', 'FontWeight','bold', 'FontSize', 23)
    ylabel('ak/ bk', 'FontWeight','bold', 'FontSize', 23)
    legend('ak', 'bk', 'FontSize', 18);
    hold off;
    
    f3_intervals = figure('Name', 'f3 Intervals', 'NumberTitle', 'off');
    hold on;
    plot(ak3);
    plot(bk3);
    title(['Limits in each iteration for l = ' num2str(l(i)) ' [f_{3}(x)]'], 'FontSize', 18)
    xlabel('k', 'FontWeight','bold', 'FontSize', 23)
    ylabel('ak/ bk', 'FontWeight','bold', 'FontSize', 23)
    legend('ak', 'bk', 'FontSize', 18);
    hold off;  
end

for iteration=1:size(l, 2)
    figure(functions);
    plot(minimum(iteration,1), f1(minimum(iteration,1)), ['m' symbol(iteration)])
    plot(minimum(iteration,2), f2(minimum(iteration,2)), ['c' symbol(iteration)])
    plot(minimum(iteration,3), f3(minimum(iteration,3)), ['k' symbol(iteration)])
    legend('f1(x)', 'f2(x)', 'f3(x)', 'x1*', 'x2*', 'x3*', "(x1*)'", "(x2*)'", "(x3*)'");
end
