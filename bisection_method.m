function [minimum, k, ak, bk] = bisection_method(f, l, epsilon, l_limit, u_limit)

    a = l_limit;
    b = u_limit;
    
    ak = a;
    bk = b;

    k = 0;
    while abs(b - a) > l
        x1 = ((a+b)/2) - epsilon;
        x2 = ((a+b)/2) + epsilon;

        if f(x1) > f(x2)
            a = x1;

        elseif f(x1) < f(x2)
            b = x2;

        else
            a = x1;
            b = x2;
        end
        
        k = k + 1;
        ak = [ak; a];
        bk = [bk; b];
    end
    
    minimum = (b+a)/2;    
end
