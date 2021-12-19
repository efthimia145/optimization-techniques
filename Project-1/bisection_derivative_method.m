function [root, k, ak, bk, function_calculations] = bisection_derivative_method(f, x, l, l_limit, u_limit)
    
    a = l_limit;
    b = u_limit; 
    
    ak = a;
    bk = b;
    k = 0; 
    x1 = (a+b)/2;
    function_calculations = 1;
    xdot = eval((subs(diff(f,x,1),x,x1)));
    
    while abs(b - a) > l && xdot ~= 0
        
        if xdot < 0
            a = x1;
            
        elseif xdot > 0
            b = x1;
            
        end
        
        x1 = (a+b)/2;
        function_calculations = function_calculations + 1;

        xdot = eval((subs(diff(f,x,1),x,x1)));
        
        ak = [ak; a];
        bk = [bk; b];   
        
        k = k + 1;
        
    end
    
    root = (b+a)/2;
end