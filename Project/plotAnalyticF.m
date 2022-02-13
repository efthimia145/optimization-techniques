% This function creates the plot for the estimated analytic function. 

function [] = plotAnalyticF(resolution, finalGene, chromosomeSize, u1Limits, u2Limits, generation)

    fApprox = zeros(resolution);

    yCounter = 0;

    for u1=linspace(-1,2,resolution)
        yCounter = yCounter + 1;
        xCounter = 0;
        for u2=linspace(-2,1,resolution)
            xCounter = xCounter + 1;
        for j=1:chromosomeSize:length(finalGene)
                    gaussianValue = gaussianFunction(u1, u2, finalGene(j), finalGene(j+1), finalGene(j+2), finalGene(j+3), finalGene(j+4));
                    fApprox(xCounter, yCounter)  = fApprox(xCounter, yCounter) + gaussianValue;
        end
        end
    end

    numofGaussians = length(finalGene)/chromosomeSize;
    
    u1 = linspace(u1Limits(1),u1Limits(2),resolution);
    u2 = linspace(u2Limits(1),u2Limits(2),resolution);
    figure();
    surf(u1,u2, fApprox);

    xlabel('u1');
    ylabel('u2');
    zlabel('z');
    title({'Analytic function'
            ['Num of Gaussians = ' num2str(numofGaussians)]
            ['Num of generations = ' num2str(generation)] });
    grid on;
%     saveas(gcf,["figures/fanalytic-" + num2str(maxGenerations) + ".pdf"])

end