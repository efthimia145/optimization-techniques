function [minimum, ak, bk, function_calculations] = fibonacci_method(f, l, e, l_limit, u_limit, n, fibonacci_array)
    
    a = l_limit;
    b = u_limit; 
    
    ak = a;
    bk = b;
    
    k = 1;
    
    x1 = a + (fibonacci_array(n-2)/fibonacci_array(n))*(b-a); 
    x2 = a + (fibonacci_array(n-1)/fibonacci_array(n))*(b-a); 
    function_calculations = 2;
    
    while k < n-1
        k = k + 1;

        if k == n-2
            x2 = x1 + e;
            function_calculations = function_calculations + 1;
            if f(x1) > f(x2)
                a = x1;
            elseif f(x1) <= f(x2)
                b = x2;
            end
        
        elseif k < n - 2
            if f(x1) > f(x2)
                a = x1;
                x1 = x2;
                x2 = a + (fibonacci_array(n-k-2)/fibonacci_array(n-k))*(b-a); 
                function_calculations = function_calculations + 1;
            elseif f(x1) <= f(x2)
                b = x2;
                x2 = x1;
                x1 = a + (fibonacci_array(n-k-1)/fibonacci_array(n-k+1))*(b-a);
                function_calculations = function_calculations + 1;
            end

            ak = [ak; a];
            bk = [bk; b];
        end
    end
    
    minimum = (b+a)/2;
end