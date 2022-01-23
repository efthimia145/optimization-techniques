function mutatedChromosome = mutation(gene, chromosomeSize, cLimits, sigmaLimits, alphaLimits)

    N = length(gene);
    
    mutatedIndex = randi(N);
    
    mutatedChromosome = gene;

    while mutatedChromosome(mutatedIndex) == gene(mutatedIndex)
        
        switch mod(mutatedIndex,chromosomeSize)
            case 1
                mutatedChromosome(mutatedIndex) = unifrnd(cLimits(1), cLimits(2));
            case 2
                mutatedChromosome(mutatedIndex) = unifrnd(cLimits(1), cLimits(2));
            case 3
                mutatedChromosome(mutatedIndex) = unifrnd(sigmaLimits(1), sigmaLimits(2));
            case 4
                mutatedChromosome(mutatedIndex) = unifrnd(sigmaLimits(1), sigmaLimits(2));
            case 0
                mutatedChromosome(mutatedIndex) = unifrnd(alphaLimits(1), alphaLimits(2));
        end
        
    end
    
end