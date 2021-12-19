function [minimum] = levenberg_marquardt_method(f, gradf, hessianf, epsilon, starting_point, step_selection)
    
    gk_calculation_methods = ["Constant gk Method", "Minimization of function Method", "Armijo Method"];
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
    title([gk_calculation_methods(step_selection) "Starting Point = ("+starting_point(1)+...
                                                                ","+starting_point(2)+")"]);
    xlabel("x");
    ylabel("y");

    f_grad = subs(gradf);
    f_hessian = subs(hessianf);

    % Find appropriate mk
    m = abs(max(eig(f_hessian)));
    
    condition_value = f_hessian + m.*eye(2);
    
    while  condition_value(1, 1) <= 0 || det(condition_value) <= 0
        m = m + 0.1;
        condition_value = f_hessian + m.*eye(2);
    end
    
    criteria_fulfilled = true;
    
    if step_selection == 1
        
        fprintf("\n[====Constant gk Method====]\n");

        gk = 0.1;

        while norm(f_grad) > epsilon

            dk = -inv(condition_value)*f_grad;
            
            % Check if criteria 3, 4 are fulfilled

            criteria_fulfilled = check_criteria(f, gradf, xk, dk, gk);
            
            if ~criteria_fulfilled
                break;
            end
                
            xk = round(double(xk + gk.*dk), 4);

            x = xk(1);
            y = xk(2);
            
            points_x = [points_x x];
            points_y = [points_y y];
           
            f_grad = subs(gradf);
            f_hessian = subs(hessianf);
            
            % Update mk
            m = abs(max(eig(f_hessian)));
            while  condition_value(1, 1) <= 0 || det(condition_value) <= 0
                m = m + 0.1;
                condition_value = f_hessian + m.*eye(2);
            end
            k = k + 1;
            
            scatter(x,y,'*');
        end

        annotation('textbox', [0.6, 0.2, 0.1, 0.1], 'String', "k = "+k);
        hold off;
        saveas(gcf, "figures/LM-contours-plot-" + gk_calculation_methods(step_selection) + "-" + ...
                num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        
        if k > 1
            x_axis = 1:k;
            figure();
            plot(x_axis, f(points_x(x_axis), points_y(x_axis)),'--o','Color','b',...
                                        'MarkerSize',8,'MarkerFaceColor','#d3658c');
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("k");
            ylabel("f(x,y)");
            saveas(gcf, "figures/LM-k-plot-" + gk_calculation_methods(step_selection) + "-" +...
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
            saveas(gcf, "figures/LM-3d-plot-" + gk_calculation_methods(step_selection) + "-" +...
                             num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        end
        
    end

    if step_selection == 2
        
        fprintf("\n[====Minimization Method====]\n");

        syms gk;

        while norm(f_grad) > epsilon

            dk = -inv(condition_value)*f_grad;

            g(gk) = f(xk(1) + gk*dk(1), xk(2)+gk*dk(2));

            % Find gk to minimize f(xk+gk*dk)
            l = 0.01;
            l_limit = 0;
            u_limit = 5;
            
            [gmin, ~, ~, ~, ~] = golden_section_method(g, l, l_limit, u_limit);
            
            % Check if criteria 3, 4 are fulfilled
            criteria_fulfilled = check_criteria(f, gradf, xk, dk, gmin);
            
            if ~criteria_fulfilled
                break;
            end
            
            xk = round(double(xk + gmin.*dk), 4);

            x = xk(1);
            y = xk(2);
            
            points_x = [points_x x];
            points_y = [points_y y];
            
            f_grad = subs(gradf);
            f_hessian = subs(hessianf);

            % Update mk
            m = abs(max(eig(f_hessian)));
            while  condition_value(1, 1) <= 0 || det(condition_value) <= 0
                m = m + 0.1;
                condition_value = f_hessian + m.*eye(2);
            end
            k = k + 1;
            
            scatter(x,y,'*');
        end

        annotation('textbox', [0.6, 0.2, 0.1, 0.1], 'String', "k = "+k);
        hold off;

        if k > 1
            x_axis = 1:k;
            figure();
            plot(x_axis, f(points_x(x_axis), points_y(x_axis)),'--o','Color','b',...
                                        'MarkerSize',8,'MarkerFaceColor','#d3658c');
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("k");
            ylabel("f(x,y)");
            saveas(gcf, "figures/LM-k-plot-" + gk_calculation_methods(step_selection) + "-" +...
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
            saveas(gcf, "figures/LM-3d-plot-" + gk_calculation_methods(step_selection) + "-" +...
                             num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        end
    end

    if step_selection == 3
        
        fprintf("\n[====Armijo Method====]\n");

        alpha = 10^(-3);
        beta = 1/5;
        mk = 0;
        gk = 10;

        s = gk * beta^(mk);

        while norm(f_grad) > epsilon

            dk = -inv(condition_value)*f_grad;
            xk_1 = round(double(xk + gk.*dk), 4);

            while f(xk(1), xk(2)) - f(xk_1(1),xk_1(2)) < -alpha*beta^(mk)*s*(dk'*f_grad)
                mk = mk + 1;
            end

            gk = s*beta^(mk);
            
            % Check if criteria 3, 4 are fulfilled
            criteria_fulfilled = check_criteria(f, gradf, xk, dk, gk);
            
            if ~criteria_fulfilled
                break;
            end

            xk = round(double(xk + gk.*dk), 4);

            x = xk(1);
            y = xk(2);   
            
            points_x = [points_x x];
            points_y = [points_y y];
            
            f_grad = subs(gradf);
            f_hessian = subs(hessianf);
               
            % Update mk
            m = abs(max(eig(f_hessian)));
            
            while  condition_value(1, 1) <= 0 || det(condition_value) <= 0
                m = m + 0.1;
                condition_value = f_hessian + m.*eye(2);
            end
            k = k + 1;

            scatter(x,y,'*');
        end

        annotation('textbox', [0.6, 0.2, 0.1, 0.1], 'String', "k = "+k);
        hold off;
        
        if k > 1
            x_axis = 1:k;
            figure();
            plot(x_axis, f(points_x(x_axis), points_y(x_axis)), '--o','Color','b',...
                                         'MarkerSize',8,'MarkerFaceColor','#d3658c');
            title([gk_calculation_methods(step_selection) "Starting Point = ("+...
                                    starting_point(1)+","+starting_point(2)+")"]);
            xlabel("k");
            ylabel("f(x,y)");
            saveas(gcf, "figures/LM-k-plot-" + gk_calculation_methods(step_selection) + "-" +...
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
            saveas(gcf, "figures/LM-3d-plot-" + gk_calculation_methods(step_selection) + "-" +...
                             num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        end
    end

    minimum = f(xk(1), xk(2));
    
    if ~criteria_fulfilled && k >= 1 
        fprintf("\nCriteria are not fulfilled in iteration = %d\n", k);
        fprintf("Last point reached was f = %.4f\n", minimum)
    elseif k == 1
        fprintf("\nI cannot find the minimum. Gradient of function is almost zero.\n")
    else
        fprintf("\nMinimum of function f = %.4f\n", minimum);
        fprintf("Iterations needed = %d\n", k);   
    end

end