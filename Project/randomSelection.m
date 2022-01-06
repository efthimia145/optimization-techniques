function [selectedPopulation] = randomSelection(population, numofSelections)

    s = RandStream('mlfg6331_64'); 
    y = datasample(s,1:height(population),numofSelections,'Replace',false);
    
    selectedPopulation = population(y, :);

end