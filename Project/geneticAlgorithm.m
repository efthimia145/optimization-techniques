% Amarantidou Efthymia 
% AEM: 9762
% Project

clear;
close all;
clc;

% maxGenerations = [12000];
% for i=1:length(maxGenerations)
%     i
%     geneticAlgorithmF(maxGenerations(i));
% end

%% Set parameters for the genetic algorithm

numofGaussians = 15;
gaussianChromosomes = 5;
populationSize = 100;
maxGenerations = 10000;

genes = zeros(1, gaussianChromosomes*numofGaussians);

u1Limits = [-1 2];
u2Limits = [-2 1];

cLimits = [-3 3];             % define
sigmaLimits = [0.1 1.3];      % define

f = @(u1,u2) sin(u1 + u2)*sin(u2^2);

[fMin, fMax] = findExtrema(f, u1Limits, u2Limits);
alphaLimits = [fMin fMax]; 

fitnessFunctionResults = zeros(populationSize, 1);

bestGene = zeros(maxGenerations, width(genes));

minError = inf(maxGenerations, 1);

errorThreshold = 0.001;

crossoverMethod = ["Cut" "Merge"];
errorType = ["Linear" "Mean Square"];   % Error used for the fitness function calculation.
%% Generate data

% First generation

generation = 1;

for i=1:populationSize
    
    for j=1:gaussianChromosomes:numofGaussians*gaussianChromosomes
        genes(i,j) = unifrnd(cLimits(1), cLimits(2));                                % center 1
        genes(i,j+1) =  unifrnd(cLimits(1), cLimits(2));                            % center 2
        genes(i,j+2) =  unifrnd(sigmaLimits(1), sigmaLimits(2));            % sigma 1
        genes(i,j+3) =  unifrnd(sigmaLimits(1), sigmaLimits(2));            % sigma 2
        genes(i,j+4) = unifrnd(alphaLimits(1), alphaLimits(2));               % alpha
    end
    
    fitnessFunctionResults(i) = fitnessFunction(genes(i,:), numofGaussians, errorType(2));

end

population = [genes fitnessFunctionResults];

population = sortrows(population, width(population));

bestGene(generation,:) = population(1,1:end-1);
minError(generation) = population(1,end);

%% Plot function 
resolution = 50;
u1 = linspace(u1Limits(1),u1Limits(2),resolution);
u2 = (linspace(u2Limits(1),u2Limits(2),resolution))';

z = sin(u1 + u2).*sin(u2.^2);
surf(u1,u2,z)
xlabel('u1');
ylabel('u2');
zlabel('z');
title('Given function to approach');
grid on;

%% New chromosomes generation
%
% bestPerc:            Percentage of best selected genes from previous generation.
% randomPerc:       Percentage of randomly selected genes from previous generation.
% crossoverPerc:    Percentage of crossovered genes.

bestPerc = 0.4;
randomPerc = 0.1;
crossoverPerc = 1 - (bestPerc + randomPerc);

mutationPropability = 0.1;

bestSelections = populationSize*bestPerc;
randomSelections = populationSize*randomPerc;
crossoverSelections = int8(populationSize*crossoverPerc);

randomStart = bestSelections +1;
randomEnd = randomStart + randomSelections - 1;

while minError(generation) > errorThreshold && generation < maxGenerations
    
    generation = generation + 1;
    
    bestPopulation = population(1:bestSelections, 1:end-1);
    population(randomStart:randomEnd, 1:end-1) = randomSelection(population(randomStart:end, 1:end-1), randomSelections);
    
    population(randomEnd+1:end, 1:end-1) = crossoverSelection(bestPopulation, crossoverSelections, crossoverMethod(1));
    
    for i = 1:populationSize
        if rand <= mutationPropability
            mutatedGeneIndex = randi(populationSize);
            mutatedGene = population(mutatedGeneIndex, 1:end-1);
            population(mutatedGeneIndex,1:end-1) = mutation(mutatedGene, gaussianChromosomes, cLimits, sigmaLimits, alphaLimits);
        end
    end
        
    for i = 1:populationSize
        fitnessFunctionResults(i) = fitnessFunction(population(i,1:end-1), numofGaussians, errorType(2));
    end
   
    population(:,end) = fitnessFunctionResults;
    
    population = sortrows(population, width(population));

    bestGene(generation,:) = population(1,1:end-1);
    minError(generation) = population(1,end);

end

% Plot the error in each generation

figure();
numGen = 1:1:generation;
plot(numGen,minError(numGen));
xlabel('Generation');
ylabel('Fitness Function Value');
title('Fitness Function Results per Generation');
grid on; 
saveas(gcf,["figures/FitnessFunction-" + num2str(numofGaussians) + "-" + num2str(generation) + "-" ...
                   + num2str(cLimits)+num2str(sigmaLimits) + ".pdf"])

% Get the generation with the minimum error and plot the
% calculated analytic function

[~, bestGeneration] = min(minError);
finalGene = bestGene(bestGeneration, :);

plotAnalyticF(resolution, finalGene, gaussianChromosomes, u1Limits, u2Limits, generation);