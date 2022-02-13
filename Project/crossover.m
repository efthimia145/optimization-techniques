function child = crossover(parent1, parent2, crossoverMethod)

    if length(parent1) ~= length(parent2)
        fprintf("Parent chromosomes are not of the same size!");
        child = 0;
        return
    end
    
    N = length(parent1);
    
    if crossoverMethod == "Cut"
        
        cutPoint = randi(N-1);
        
        child1 = [parent1(1:cutPoint) parent2(cutPoint+1:end)];
        child2 = [parent2(1:cutPoint) parent1(cutPoint+1:end)];
        
        child = [child1; child2];
        
    elseif crossoverMethod == "Merge"
        
        child = (parent1 + parent2)/2;
        
    end
    
end