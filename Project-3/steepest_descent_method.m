function [minimum] = steepest_descent_method(f, gradf, epsilon, starting_point, gk)

    syms x y;

    xk = starting_point';
    k = 1;

    x = xk(1);
    y = xk(2);
    
    points_x = x;
    points_y = y;
    
    max_steps = 1000;

    % Create figures to plot the results
    figure('PaperPosition', [0.25 0.25 8 6]);

    fcontour(f);
    colorbar
    
    hold on
    scatter(x,y,'*');
    
    title(["Starting Point = ("+ starting_point(1)+","+starting_point(2)+")" "Gamma = " + gk]);
    xlabel("x1");
    ylabel("x2");
    
    f_grad = subs(gradf);

    while norm(f_grad) > epsilon && k < max_steps

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
    saveas(gcf, "figures/SD-contours-plot-" + gk + "-" + num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
    hold 
    
    if k == max_steps
        fprintf("Stopped. Too many steps!");
    end
    
    if k > 1   && ~isnan(f(xk(1), xk(2)))
        
        x_axis = 1:k;
        
        figure('PaperPosition', [0.25 0.25 8 6]);
        plot(x_axis, f(points_x(x_axis), points_y(x_axis)),'--o','Color','b','MarkerSize',8,'MarkerFaceColor','#d3658c');
        
        title(["Starting Point = ("+ starting_point(1)+","+starting_point(2)+")" "Gamma = " + gk]);
        xlabel("k");
        ylabel("f(x)");
        
        saveas(gcf, "figures/SD-k-plot-" + gk + "-" + num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");

        if k ~= max_steps
        % Plot the points on the 3D plot
        figure('PaperPosition', [0.25 0.25 8 6]);
        x = -10:0.5:10;
        y = x';
        z = (1/2)*x.^2 + 2*y.^2;
        
        surf(x,y,z);
        
        title(["Starting Point = ("+ starting_point(1)+","+starting_point(2)+")" "Gamma = " + gk]);
        xlabel("x1");
        ylabel("x2");
        zlabel("f(x)")

        annotation('textbox', [0.7, 0.8, 0.1, 0.1], 'String', "k = "+k);

        hold on;

        for i=1:k
            px = points_x(:);
            py = points_y(:);
            pz = (1/2)*px.^2 + 2*py.^2;
            plot3(px,py,pz, '--*', 'Color', 'red','MarkerSize', 20, 'LineWidth', 2);
        end
        colorbar
        hold off;
        saveas(gcf, "figures/SD-3d-plot-" + gk + "-" + num2str(starting_point(1))+ num2str(starting_point(2)) + ".pdf");
        end
        
    end

    minimum = f(xk(1), xk(2));
    
    if ~isnan(minimum)
        
        fprintf("\nMinimum of function f = %.4f\n", minimum);
        fprintf("Iterations needed = %d\n", k);
        
    else
        
        fprintf("\nCannot find minimum. Method does not converge!\n");
        
    end

end