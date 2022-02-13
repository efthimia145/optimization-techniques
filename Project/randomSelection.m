function [selectedPopulation] = randomSelection(population, numofSelections)

    y = randperm(height(population), numofSelections);
    
    selectedPopulation = population(y, :);

end