function [minimum, ak, bk] = fibonacci_method(f, l, l_limit, u_limit, n, fibonacci_array)
    
    a = l_limit;
    b = u_limit; 
    
    ak = a;
    bk = b;
   
    k = 1;
    
    while k < n-1
        k = k + 1;
        x1 = a + (fibonacci_array(n-k)/fibonacci_array(n-k+2))*(b-a); 
        x2 = a + (fibonacci_array(n-k+1)/fibonacci_array(n-k+2))*(b-a); 
        
        if f(x1) > f(x2)
            a = x1;
            
        elseif f(x1) <= f(x2)
            b = x2;
        end
        
        ak = [ak; a];
        bk = [bk; b];    
        
    end
    
    minimum = (b+a)/2;
end