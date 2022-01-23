function [error] = fitnessFunction(genes, numofGaussians)

    linearError = 0;
    meanSquareError = 1;    
    f = @(u1,u2) sin(u1 + u2)*sin(u2^2); 
    
    u1Limits = [-1 2];
    u2Limits = [-2 1];
    
    chromosomeSize = length(genes)/numofGaussians;
    
    error = 0;
    
%     for i=1:iterations
%     
%         u1 = unifrnd(u1Limits(1), u1Limits(2));
%         u2 = unifrnd(u2Limits(1), u2Limits(2));
%         
%         fValue = f(u1,u2);
%         fApprox = 0;
%         
%         for j=1:chromosomeSize:length(genes)
%             gaussianValue = gaussianFunction(u1, u2, genes(j), genes(j+1), genes(j+2), genes(j+3));
%             fApprox = fApprox + gaussianValue;
%         end
%         
%         if linearError 
%             
%             error = error + abs(fValue - fApprox);
%         
%         elseif meanSquareError
%             
%             error = error + (fValue - fApprox)^2;
%             
%         end
% 
%     end

    for u1=linspace(u1Limits(1),u1Limits(2),25)
        for u2=linspace(u2Limits(1),u2Limits(2),25)
            
            fValue = f(u1,u2);
            fApprox = 0;

            for j=1:chromosomeSize:length(genes)
                gaussianValue = gaussianFunction(u1, u2, genes(j), genes(j+1), genes(j+2), genes(j+3), genes(j+4));
                fApprox = fApprox + gaussianValue;
            end

            if linearError 

                error = error + abs(fValue - fApprox);

            elseif meanSquareError

                error = error + (fValue - fApprox)^2;

            end
        end
    end
    
    error = error/625;

end