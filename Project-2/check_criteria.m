function check_flag = check_criteria(f, gradf, xk, dk, gk)
        
    check_3 = false;
    check_4 = false;
    
    x = xk(1);
    y = xk(2);
    gradfx = subs(gradf);

    xk_1 = round(double(xk + gk.*dk), 4);
    x = xk_1(1);
    y = xk_1(2);
    gradfx_1 = subs(gradf);

    for beta = linspace(0.001,1,50)
        if dk'*gradfx_1 <= beta*dk'*gradfx
            continue;
        else
            check_3 = true;
            break;
        end
    end
        
    if check_3
        for alpha = linspace(0.001,beta,50)
            if f(xk_1(1), xk_1(2)) > f(xk(1), xk(2)) + alpha*gk*dk'*gradfx
                continue
            else
                check_4 = true;
                break;
            end
        end
    end
    
    check_flag = check_3 && check_4;
end