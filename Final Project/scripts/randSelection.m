function [selection] = randSelection(population,SelectNum,chromosomes)
% Selects random people from the population
choice = zeros(1,SelectNum);
fitnessScores = population(:, chromosomes+1);
% Invert fitness scores to make lower scores more probable
invertedFitnessScores = 1./fitnessScores;

% Calculate selection probabilities based on inverted fitness scores
selectionProbabilities = invertedFitnessScores / sum(invertedFitnessScores);

for i=1:SelectNum
    % Spin the wheel
    spin = rand();
    % Find the selected index
    cumulativeProbability = 0;
    for j = 1:length(fitnessScores)
        cumulativeProbability = cumulativeProbability + selectionProbabilities(j);
         if spin <= cumulativeProbability
            choice(i) = j;
         break;
         end
    end
end

selection = population(choice,:);
end
