function crossoveredPopulation = crossoverSelection(bestPopulation, numofCrossovers, crossoverMethod)
% This function generates the appropriate chromosomes using the crossover
% method for the next generation.

% Inputs:
% =======
% @ bestPopulation: the chosen best chromosomes from the previous
% generation
% @ numofCrossovers: the number of chromosomes that need to be generated
% @ crossoverMethod: the crossover method

% Outputs: 
% ========
% @ crossoveredPopulation: the chromosomes generated from crossover
    
    N = height(bestPopulation);
    
    s = RandStream('mlfg6331_64'); 
    
    crossoveredPopulation = zeros(numofCrossovers, length(bestPopulation));
      
    if crossoverMethod == "Cut"

        for i=1:2:numofCrossovers-1

            y = datasample(s,1:height(bestPopulation),2,'Replace',false);
            crossoveredPopulation(i:i+1, :) = crossover(bestPopulation(y(1), :), bestPopulation(y(2), :), crossoverMethod);

        end

    elseif crossoverMethod == "Merge"

        for i=1:numofCrossovers

            y = datasample(s,1:height(bestPopulation),2,'Replace',false);
            crossoveredPopulation(i, :) = crossover(bestPopulation(y(1), :), bestPopulation(y(2), :), crossoverMethod);

        end
        
      else
        
        fprintf("Acceptable crossover methods are: [Cut, Merge]");
        return
        
    end
    
end