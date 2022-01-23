% Amarantidou Efthymia 
% AEM: 9762
% Project

clear;
close all;
clc;

%%

numofGaussians = 15;
chromosomeSize = 5;
populationSize = 50;
maxGenerations = 3000;

genes = zeros(1, chromosomeSize*numofGaussians);

u1Limits = [-1 2];
u2Limits = [-2 1];
cLimits = [-3 2];               % define
sigmaLimits = [0.1 1.5];    % define
alphaLimits = [-0.99 0.84];

f = @(u1,u2) sin(u1 + u2)*sin(u2^2);
fitnessFunctionResults = zeros(populationSize, 1);

bestGene = zeros(maxGenerations, length(genes));
minError = inf(maxGenerations, 1);

errorThreshold = 0.001;

crossoverMethod = ["Cut" "Merge"];
%% Generate data

% First generation

generation = 1;

for i=1:populationSize
    
    for j=1:chromosomeSize:numofGaussians*chromosomeSize
        genes(i,j) = unifrnd(cLimits(1), cLimits(2));                                % center 1
        genes(i,j+1) =  unifrnd(cLimits(1), cLimits(2));                            % center 2
        genes(i,j+2) =  unifrnd(sigmaLimits(1), sigmaLimits(2));           % sigma 1
        genes(i,j+3) =  unifrnd(sigmaLimits(1), sigmaLimits(2));           %sigma 2
        genes(i,j+4) = unifrnd(alphaLimits(1), alphaLimits(2));             % alpha
    end
    
    fitnessFunctionResults(i) = fitnessFunction(genes(i,:), numofGaussians);

end

population = [genes fitnessFunctionResults];

population = sortrows(population, length(population));

bestGene(generation,:) = population(1,1:end-1);
minError(generation) = population(1,end);

%% Plot function 
resolution = 50;
u1 = linspace(u1Limits(1),u1Limits(2),resolution);
u2 = (linspace(u2Limits(1),u2Limits(2),resolution))';

z = sin(u1 + u2).*sin(u2.^2);
surf(u1,u2,z)
%% New chromosomes generation

bestPerc = 0.3;
randomPerc = 0.1;
crossoverPerc = 1 - (bestPerc + randomPerc);
mutationPropability = 0.5;

bestSelections = populationSize*bestPerc;
randomSelections = populationSize*randomPerc;
crossoverSelections = int8(populationSize*crossoverPerc);

randomStart = bestSelections +1;
randomEnd = randomStart + randomSelections - 1;

while minError(generation) > errorThreshold && generation <= maxGenerations
    
    generation = generation + 1;
    bestPopulation = population(1:bestSelections, 1:end-1);
    population(randomStart:randomEnd, 1:end-1) = randomSelection(population(randomStart:end, 1:end-1), randomSelections);
    
    population(randomEnd+1:end, 1:end-1) = crossoverSelection(bestPopulation, crossoverSelections, crossoverMethod(2));
    
    if rand <= mutationPropability
        mutatedGeneIndex = randi(populationSize);
        mutatedGene = population(mutatedGeneIndex, 1:end-1);
        population(mutatedGeneIndex,1:end-1) = mutation(mutatedGene, chromosomeSize, cLimits, sigmaLimits, alphaLimits);
    end
        
    for i=1:populationSize
        fitnessFunctionResults(i) = fitnessFunction(population(i,1:end-1), numofGaussians);
    end
   
    population(:,end) = fitnessFunctionResults;
    
    population = sortrows(population, length(population));

    bestGene(generation,:) = population(1,1:end-1);
    minError(generation) = population(1,end);

end

[~, bestGeneration] = min(minError);
genefinal = bestGene(bestGeneration, :);
fApprox = zeros(resolution);

xCounter = 0;
yCounter = 0;

for u1=linspace(-1,2,resolution)
    yCounter = yCounter + 1;
    xCounter = 0;
    for u2=linspace(-2,1,resolution)
        xCounter = xCounter + 1;
    for j=1:chromosomeSize:length(genefinal)
                gaussianValue = gaussianFunction(u1, u2, genefinal(j), genefinal(j+1), genefinal(j+2), genefinal(j+3), genefinal(j+4));
                fApprox(xCounter, yCounter)  = fApprox(xCounter, yCounter) + gaussianValue;
    end
    end
end

figure();
numGen = 1:1:generation;
plot(numGen,minError(numGen));

u1 = linspace(u1Limits(1),u1Limits(2),resolution);
u2 = linspace(u2Limits(1),u2Limits(2),resolution);
figure();
surf(u1,u2, fApprox);