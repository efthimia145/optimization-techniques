function mutatedChromosome = mutation(chromosome, c1Limits, c2Limits, sigma1Limits, sigma2Limits)

    N = length(chromosome);
    
    mutatedIndex = randi(N);
    
    mutatedChromosome = chromosome;
    
    while mutatedChromosome(mutatedIndex) == chromosome(mutatedIndex)
        
        switch mutatedIndex
            case 1
                mutatedChromosome(mutatedIndex) = unifrnd(c1Limits(1), c1Limits(2));
            case 2
                mutatedChromosome(mutatedIndex) = unifrnd(c2Limits(1), c2Limits(2));
            case 3
                mutatedChromosome(mutatedIndex) = unifrnd(sigma1Limits(1), sigma1Limits(2));
            case 4
                mutatedChromosome(mutatedIndex) = unifrnd(sigma2Limits(1), sigma2Limits(2));
        end
        
    end
    
end