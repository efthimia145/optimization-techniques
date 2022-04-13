% Amarantidou Efthymia 
% AEM: 9762
% Project

% This file calls the geneticAlgorithmFunction given specific variables.
% The variables can change based on our needs. 

clear;
close all;
clc;

numofGaussians = 15;
maxGenerations = 10000;
populationSize = 100;
bestPerc = 0.2;
mutationPropability = 0.1;

[temp, generation] = geneticAlgorithmF(numofGaussians, maxGenerations, populationSize, bestPerc, mutationPropability); 

% Test for number of Gaussians
% ================================================
% numofGaussians = [5 7 10 15];
% maxGenerations = [5000 10000];
% populationSize = 30;
% bestPerc = 0.3;
% mutationPropability = 0.01;
% 
% 
% iterations = 4;
% 
% for k=1:length(maxGenerations)
%     
%     minError = zeros(maxGenerations(k), length(numofGaussians));
% 
%     for i=1:length(numofGaussians)
%         i
%         for j = 1:iterations
%             [temp, generation] = geneticAlgorithmF(numofGaussians(i), maxGenerations(k), populationSize, bestPerc, mutationPropability); 
%             minError(:,i) = minError(:,i) + temp;
%         end
%         minError(:,i) = minError(:,i) / iterations;
%     end
% 
%     figure();
%     numGen = 1:1:generation;
%     for i=1:length(numofGaussians)
%         hold on
%         plot(numGen,minError(numGen, i), 'DisplayName',['Num of Gaussians = ' num2str(numofGaussians(i))]);
%     end
%     xlabel('Generation');
%     ylabel('Fitness Function Value');
%     title('Fitness Function Results per Generation');
%     legend();
%     grid on;
%     saveas(gcf,["figures/FitnessFunction-" + num2str(numofGaussians) + "-" + num2str(generation) + ".pdf"])
%     hold off;
% end
% 
% Test for percentage of best chromosomes
% ================================================
% numofGaussians = 15;
% maxGenerations = [5000 10000];
% populationSize = 30;
% bestPerc = [0.2 0.3 0.5];
% mutationPropability = 0.1;
% iterations = 4;
% 
% for k=1:length(maxGenerations)
%     minError = zeros(maxGenerations(k), length(bestPerc));
% 
%     for i=1:length(bestPerc)
%         i
%         for j = 1:iterations
%             [temp, generation] = geneticAlgorithmF(numofGaussians, maxGenerations(k), populationSize, bestPerc(i), mutationPropability); 
%             minError(:,i) = minError(:,i) + temp;
%         end
%         minError(:,i) = minError(:,i) / iterations;
%     end
% 
%     figure();
%     numGen = 1:1:generation;
%     for i=1:length(bestPerc)
%         hold on
%         plot(numGen,minError(numGen, i), 'DisplayName',['Best genes (%) = ' num2str(bestPerc(i))]);
%     end
%     xlabel('Generation');
%     ylabel('Fitness Function Value');
%     title('Fitness Function Results per Generation');
%     legend();
%     grid on;
%     saveas(gcf,["figures/FitnessFunction-" + num2str(bestPerc) + "-" + num2str(generation) + ".pdf"])
%     hold off;
% end
% 
% Test for mutation propability
% ================================================ 
% numofGaussians = 15;
% maxGenerations = [5000 10000];
% populationSize = 30;
% bestPerc = 0.3;
% mutationPropability = [0.2 0.1 0.01];
% iterations = 4;
% 
% for k=1:length(maxGenerations)
%     minError = zeros(maxGenerations(k), length(mutationPropability));
% 
%     for i=1:length(mutationPropability)
%         i
%         for j = 1:iterations
%             [temp, generation] = geneticAlgorithmF(numofGaussians, maxGenerations(k), populationSize, bestPerc, mutationPropability(i)); 
%             minError(:,i) = minError(:,i) + temp;
%         end
%         minError(:,i) = minError(:,i) / iterations;
%     end
% 
%     figure();
%     numGen = 1:1:generation;
%     for i=1:length(mutationPropability)
%         hold on
%         plot(numGen,minError(numGen, i), 'DisplayName',['Mutation propability (%) = ' num2str(mutationPropability(i))]);
%     end
%     xlabel('Generation');
%     ylabel('Fitness Function Value');
%     title('Fitness Function Results per Generation');
%     legend();
%     grid on;
%     saveas(gcf,["figures/FitnessFunction-" + num2str(mutationPropability) + "-" + num2str(generation) + ".pdf"])
%     hold off;
% end

% Test for population size
% ================================================
% numofGaussians = 15;
% maxGenerations = [5000 10000];
% populationSize = [30 50 70 100];
% bestPerc = 0.3;
% mutationPropability = 0.1;
% 
% iterations = 4;
% 
% for k=1:length(maxGenerations)
% 
%     minError = zeros(maxGenerations(k), length(populationSize));
% 
%     for i=1:length(populationSize)
%         i
%         for j = 1:iterations
%             [temp, generation] = geneticAlgorithmF(numofGaussians, maxGenerations(k), populationSize(i), bestPerc, mutationPropability); 
%             minError(:,i) = minError(:,i) + temp;
%         end
%         minError(:,i) = minError(:,i) / iterations;
%     end
% 
%     figure();
%     numGen = 1:1:generation;
%     for i=1:length(populationSize)
%         hold on
%         plot(numGen,minError(numGen, i), 'DisplayName',['Population size = ' num2str(populationSize(i))]);
%     end
%     xlabel('Generation');
%     ylabel('Fitness Function Value');
%     title('Fitness Function Results per Generation');
%     legend();
%     grid on;
%     saveas(gcf,["figures/FitnessFunction-" + num2str(populationSize) + "-" + num2str(generation) + ".pdf"])
%     hold off;
% end