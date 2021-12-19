function [minimum, k, ak, bk, function_calculations] = golden_section_method(f, l, l_limit, u_limit)
    
    gamma = 0.618;
    
    a = l_limit;
    b = u_limit;
    
    ak = a;
    bk = b;
    
    k = 0;
    
    x1 = a + (1-gamma)*(b-a);
    x2 = a + gamma*(b-a);
    function_calculations = 2;
    
    while abs(b - a) > l
  
        if f(x1) > f(x2)
            a = x1;
            x1 = x2;
            x2 = a + gamma*(b-a);
            function_calculations = function_calculations + 1;

        elseif f(x1) <= f(x2)
            b = x2;
            x2 = x1;
            x1 = a + (1-gamma)*(b-a);
            function_calculations = function_calculations + 1;

        end
        
        k = k + 1;
        ak = [ak; a];
        bk = [bk; b];
    end
    minimum = (b+a)/2;
end
