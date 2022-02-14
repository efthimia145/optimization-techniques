function [error] = fitnessFunction(f, gene, numofGaussians, errorType)
% This function calculates the fitness function value for a given function
% f and a given gene. 
%
% Inputs:
% =======
% @ f: the given function 
% @ gene: the given gene 
% @ numofGaussians: num of Gaussians used
% @ errorType: the error calculation method. Can be "Linear" of "Mean Square"

% Outputs: 
% ========
% @ error: the calculated error achieved
    
    u1Limits = [-1 2];
    u2Limits = [-2 1];
    
    chromosomeSize = length(gene)/numofGaussians;
    
    error = 0;
    points = 20;
    
    for u1=linspace(u1Limits(1),u1Limits(2),points)
        for u2=linspace(u2Limits(1),u2Limits(2),points)
            
            fValue = f(u1,u2);
            fApprox = 0;

            for j=1:chromosomeSize:length(gene)
                gaussianValue = gaussianFunction(u1, u2, gene(j), gene(j+1), gene(j+2), gene(j+3), gene(j+4));
                fApprox = fApprox + gaussianValue;
            end

            if errorType == "Linear"

                error = error + abs(fValue - fApprox);

            elseif errorType == "Mean Square"

                error = error + (fValue - fApprox)^2;

            end
        end
    end
    
    error = error/(points^2);

end