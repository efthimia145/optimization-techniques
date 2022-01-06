% Amarantidou Efthymia 
% AEM: 9762
% Project

clear;
close all;
clc;

%%

numofGaussians = 15;
chromosomeSize = 4;
populationSize = 30;
maxGenerations = 1000;

genes = zeros(1, chromosomeSize*numofGaussians);

u1Limits = [-1 2];
u2Limits = [-2 1];
cLimits = [-3 3];               % define
sigmaLimits = [0.2 1.3];    % define

f = @(u1,u2) sin(u1 + u2)*sin(u2^2);

fitnessFunctionResults = zeros(populationSize, 1);

bestGene = zeros(maxGenerations, length(genes));
minError = zeros(maxGenerations, 1);

errorThreshold = 0.05;

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
    end
    
    fitnessFunctionResults(i) = fitnessFunction(genes(i,:), numofGaussians);

end

population = [genes fitnessFunctionResults];

population = sortrows(population, length(population));

bestGene(generation,:) = population(1,1:end-1);
minError(generation) = population(1,end);

%% New chromosomes generation

bestPerc = 0.3;
randomPerc = 0.1;
crossoverPerc = 1 - (bestPerc + randomPerc);

bestSelections = populationSize*bestPerc;
randomSelections = populationSize*randomPerc;
crossoverSelections = populationSize*crossoverPerc;

randomStart = bestSelections +1;
randomEnd = randomStart + randomSelections - 1;

bestPopulation = population(1:bestSelections, 1:end-1);

while minError(generation) > errorThreshold && generation <= maxGenerations
    
    generation = generation + 1
    population(randomStart:randomEnd, 1:end-1) = randomSelection(population(randomStart:end, 1:end-1), randomSelections);
    
    population(randomEnd+1:end, 1:end-1) = crossoverSelection(bestPopulation, crossoverSelections, crossoverMethod(2));
    
    for i=1:populationSize
        fitnessFunctionResults(i) = fitnessFunction(genes(i,:), numofGaussians);
    end
   
    population(:,end) = fitnessFunctionResults;
    
    population = sortrows(population, length(population));

    bestGene(generation,:) = population(1,1:end-1);
    minError(generation) = population(1,end)
    
end