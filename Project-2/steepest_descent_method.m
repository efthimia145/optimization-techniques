function [minimum] = steepest_descent_method(f, gradf, epsilon, starting_point, step_selection)

    syms x y;

    gk_calculation_methods = ["Constant gk", "Minimization of function", "Armijo"];

    xk = starting_point';
    k = 1;

    x = xk(1);
    y = xk(2);
    
    points_x = x;
    points_y = y;

    % Create figures to plot the results
    figure();
    fcontour(f);
    colorbar
    hold on
    scatter(x,y,'*');
    title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                            starting_point(1)+","+starting_point(2)+")"]);
    xlabel("x");
    ylabel("y");
    
    f_grad = subs(gradf);

    if step_selection == 1 % Constant gk

        gk = 1;

        while norm(f_grad) > epsilon

            dk = -f_grad;

            xk = round(double(xk + gk.*dk), 4);

            x = xk(1);
            y = xk(2);
            
            points_x = [points_x x];
            points_y = [points_y y];

            f_grad = subs(gradf);     
            k = k + 1;

            scatter(x,y,'*');
        end

        annotation('textbox', [0.6, 0.2, 0.1, 0.1], 'String', "k = "+k);
        saveas(gcf, "figures/SD-contours-plot-" + gk_calculation_methods(step_selection) + "-" + ...
                        num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        hold off;

        fprintf("\n[====Constant gk Method====]\n");
        
        if k > 1
            x_axis = 1:k;
            figure();
            plot(x_axis, f(points_x(x_axis), points_y(x_axis)),'--o','Color','b',...
                                        'MarkerSize',8,'MarkerFaceColor','#d3658c');
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("k");
            ylabel("f(x,y)");
            saveas(gcf, "figures/SD-k-plot-" + gk_calculation_methods(step_selection) + "-" + ...
                        num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
            
            % Plot the points on the 3D plot
            figure();
            x = -4:0.1:4;
            y = x';
            z = (x.^3).*exp(-(x.^2)-(y.^2));
            surf(x,y,z);
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("x");
            ylabel("y");
            zlabel("f(x,y)")

            annotation('textbox', [0.7, 0.8, 0.1, 0.1], 'String', "k = "+k);
                        
            hold on;
            
            for i=1:k
                px = points_x(:);
                py = points_y(:);
                pz = (px.^3).*exp(-(px.^2)-(py.^2));
                plot3(px,py,pz, '--*', 'Color', 'red','MarkerSize', 20, 'LineWidth', 2);
            end
            colorbar
            hold off;
            saveas(gcf, "figures/SD-3d-plot-" + gk_calculation_methods(step_selection) + "-" + ...
                        num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        end

    end

    if step_selection == 2 % Minimization of f(xk + gk*dk)

        syms gk;

        while norm(f_grad) > epsilon

            dk = -f_grad;

            g(gk) = f(xk(1) + gk*dk(1), xk(2)+gk*dk(2)); % Function to be minized

            % Find gk to minimize f(xk+gk*dk)using golden section method
            l = 0.01;
            l_limit = 0;
            u_limit = 5;
            [gmin, ~, ~, ~, ~] = golden_section_method(g, l, l_limit, u_limit);

            xk = round(double(xk + gmin.*dk), 4);

            x = xk(1);
            y = xk(2);
            
            points_x = [points_x x];
            points_y = [points_y y];

            f_grad = subs(gradf);     
            k = k + 1;
            
            scatter(x,y,'*');
        end

        annotation('textbox', [0.6, 0.2, 0.1, 0.1], 'String', "k = "+k);
        hold off;

        fprintf("\n[====Minimization Method====]\n");
        
        if k > 1
            x_axis = 1:k;
            figure();
            plot(x_axis, f(points_x(x_axis), points_y(x_axis)),'--o','Color','b',...
                                        'MarkerSize',8,'MarkerFaceColor','#d3658c');
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("k");
            ylabel("f(x,y)");
            saveas(gcf, "figures/SD-k-plot-" + gk_calculation_methods(step_selection) + "-" +...
                    num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");

            % Plot the points on the 3D plot
            figure();
            x = -4:0.1:4;
            y = x';
            z = (x.^3).*exp(-(x.^2)-(y.^2));
            surf(x,y,z);
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("x");
            ylabel("y");
            zlabel("f(x,y)")
            
            annotation('textbox', [0.7, 0.8, 0.1, 0.1], 'String', "k = "+k);
                        
            hold on;
            
            for i=1:k
                px = points_x(:);
                py = points_y(:);
                pz = (px.^3).*exp(-(px.^2)-(py.^2));
                plot3(px,py,pz, '--*', 'MarkerSize', 20, 'LineWidth', 2);
            end
            colorbar
            hold off;
            saveas(gcf, "figures/SD-3d-plot-" + gk_calculation_methods(step_selection) + "-" +...
                        num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        end
    end

    if step_selection == 3 % Armijo

        alpha = 10^(-3);
        beta = 1/5;
        mk = 0;
        gk = 0.3;

        s = 30;%gk * beta^(mk);

        while norm(f_grad) > epsilon

            dk = -f_grad;
            xk_1 = round(double(xk + gk.*dk), 4);

            % Calculate mk
            while f(xk(1), xk(2)) - f(xk_1(1),xk_1(2)) < alpha*beta^(mk)*s*dk'*f_grad
                mk = mk + 1;
            end

            gk = s*beta^(mk);

            xk = round(double(xk + gk.*dk), 4);

            x = xk(1);
            y = xk(2);
            
            points_x = [points_x x];
            points_y = [points_y y];
 
            f_grad = subs(gradf);     
            k = k + 1;

            scatter(x,y,'*');
        end

        annotation('textbox', [0.6, 0.2, 0.1, 0.1], 'String', "k = "+k);
        hold off;

        fprintf("\n[====Armijo Method====]\n");
        
        if k > 1
            x_axis = 1:k;
            figure();
            plot(x_axis, f(points_x(x_axis), points_y(x_axis)),'--o','Color','b',...
                                        'MarkerSize',8,'MarkerFaceColor','#d3658c');
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("k");
            ylabel("f(x,y)");
            saveas(gcf, "figures/SD-k-plot-" + gk_calculation_methods(step_selection) + "-" + ...
                        num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");

            % Plot the points on the 3D plot
            figure();
            x = -4:0.1:4;
            y = x';
            z = (x.^3).*exp(-(x.^2)-(y.^2));
            surf(x,y,z);
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("x");
            ylabel("y");
            zlabel("f(x,y)")
            
            annotation('textbox', [0.7, 0.8, 0.1, 0.1], 'String', "k = "+k);
                        
            hold on;
            
            for i=1:k
                px = points_x(:);
                py = points_y(:);
                pz = (px.^3).*exp(-(px.^2)-(py.^2));
                plot3(px,py,pz, '--*', 'MarkerSize', 20, 'LineWidth', 2);
            end
            colorbar
            hold off;
            saveas(gcf, "figures/SD-3d-plot-" + gk_calculation_methods(step_selection) + "-" + ...
                        num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        end
    end

    minimum = f(xk(1), xk(2));

    fprintf("\nMinimum of function f = %.4f\n", minimum);
    fprintf("Iterations needed = %d\n", k);

end