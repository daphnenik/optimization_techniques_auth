function [bestSolution,error] = myGA(gaussiansNum,maxGeneration,mutationProb)
tic;

generation = 1;
populationSize = 160; 

% Each chromosome consists of 5 genes
chromosomes = gaussiansNum * 5;  
genes = zeros(1,chromosomes);
population = zeros(populationSize,chromosomes+1);

%Chosen values for c1 and c2
c1Lim = [-4 5]; 
c2Lim = [-5 4];

error = inf(1,maxGeneration);
best = zeros(maxGeneration,chromosomes+1);

[minf,maxf] = fLimits();

% 1st Generation - Random starting values within the limits
for j = 1:populationSize
    for i = 1:5:chromosomes
        genes(i) = minf + (maxf - minf)*rand; %magnitude
        genes(i+1) = c1Lim(1) + (c1Lim(2) - c1Lim(1))*rand; %center1
        genes(i+2) = c2Lim(1) + (c2Lim(2) - c2Lim(1))*rand; %center2
        genes(i+3) = 0.2 + 1.3 * rand; %sigma1 
        genes(i+4) = 0.2 + 1.3 * rand; %sigma2
    end
    population(j,1:chromosomes) = genes;
    population(j,chromosomes+1) = fitnessFunc(genes,chromosomes);
end

    % Sorting the population of the 1st generation based on fitness score
    population = sortrows(population,chromosomes+1);

    % Storing the best solution and error
    best(generation,:) = (population(1,:));
    error(generation) = population(1,chromosomes+1); 
    last_error = population(1,chromosomes+1);

    %Setting percentages
    bestPerc = 0.2;
    bestSelections = populationSize*bestPerc;
    bestPopulation = population(1:bestSelections,1:chromosomes+1);
    
    randPerc = 0.1;  
    randomSelections = populationSize*randPerc;
    
    crossoverPerc = 0.7;
    crossoverSelections = populationSize*crossoverPerc;

    CrossStart = bestSelections + 1;
    CrossEnd = CrossStart + crossoverSelections-1;

    while (last_error >=0.02 && generation <= maxGeneration)
        generation = generation + 1;
        rng('shuffle');
        % Population to be crossovered
        crossPopulation = randSelection(population(1:end,1:chromosomes+1),crossoverSelections,chromosomes);
        crossoveredPopulation = zeros(crossoverSelections,chromosomes);
        shuffled_data = randperm(size(crossPopulation,1));
        % Reshape the shuffled array into pairs
        randPair = reshape(shuffled_data, [], 2);

    % Apply crossover on the random part of our population that we chose
    for i=1:length(randPair)
        for k = 2*i
            [crossoveredPopulation(k-1,:),crossoveredPopulation(k,:)] = crossover(crossPopulation(randPair(i,1),:),crossPopulation(randPair(i,2),:),chromosomes);
        end
    end
    % Randomly chosen part of the populations that moves on to the next
    % generation
    randPopulation = randSelection(population(bestSelections + 1:end,1:chromosomes+1),randomSelections,chromosomes);
    population(CrossEnd+1:end, 1:chromosomes+1) = randPopulation;

    population(CrossStart:CrossEnd, 1:chromosomes) = crossoveredPopulation;

    % Mutating randomly chosen part of the population
    for i = 1:populationSize
        if 100*rand < mutationProb   
           population(i,1:chromosomes) = mutation(population,chromosomes,populationSize);
        end
    end

    % Calculate the fitness score of each gene
    for j = 1:populationSize
        population(j,chromosomes+1) = fitnessFunc(population(j,1:chromosomes),chromosomes);
    end

    % Sorting the population of each generation based on fitness score 
    population = sortrows(population,chromosomes+1);

    best(generation,:) = (population(1,:));
    error(generation) = population(1,chromosomes+1); 
    last_error = population(1,chromosomes+1);
    end    

    [~,idx] = min(error); % index of the generation with the lowest MSE
    bestSolution = best(idx,1:chromosomes); % take the best person from that generation

    toc;
end