% This function chooses randomly some of the non-best chromosomes of the
% previous generation to be transfered to the next generation.
function [selectedPopulation] = randomSelection(population, numofSelections)

    y = randperm(height(population), numofSelections);
    
    selectedPopulation = population(y, :);

end