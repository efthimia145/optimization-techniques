function mutatedChromosome = mutation(initialChromosome, geneSetSize, cLimits, sigmaLimits, alphaLimits)
% This function mutates a random initialChromosome of a given chromosome. 

% Inputs:
% =======
% @ initialChromosome: the chromosome to be mutated
% generation
% @ geneSetSize: the size of a set off genes containing parameters for 1
% Gaussian. 
% @ cLimits: the limits for c parameter
% @ sigmaLimits: the limits for sigma parameter
% @ alphaLimits: the limits for alpha parameter

% Outputs: 
% ========
% @ mutatedChromosome: the chromosomes generated after mutation.

    N = length(initialChromosome);
    
    mutatedIndex = randi(N);
    
    mutatedChromosome = initialChromosome;

    while mutatedChromosome(mutatedIndex) == initialChromosome(mutatedIndex)
        
        switch mod(mutatedIndex,geneSetSize)
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