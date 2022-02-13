% This function calculates the minimun and maximum of a given 2 variable function f
% given the range for each variable. 

function [minF, maxF] = findExtrema(f, u1Limits, u2Limits)

    step = 0.05;
    
    minF = Inf;
    maxF = -Inf;
    
    for u1 = u1Limits(1):step:u1Limits(2)

        for u2 = u2Limits(1):step:u2Limits(2)

            fVal = f(u1, u2);

            if fVal < minF
                minF = fVal;
            
            elseif fVal > maxF
                maxF = fVal;
                
            end
           
        end
        
    end
    
end