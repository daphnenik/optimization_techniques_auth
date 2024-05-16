function mutated = mutation(person,gene_length,populationNum)
% Randomly chooses one gene of the person to mutate
% Changes the value of the gene with a random one within its limits.

mutIndex = randi(populationNum);
mutationType = mod(mutIndex, 5);

switch mutationType
    case 1
        person(mutIndex,1:gene_length) = -1 + 2*rand; %magnitude of Gaussian
    case 2
        person(mutIndex,1:gene_length) = -4 + 9*rand; %center1 [-4 5]
    case 3
        person(mutIndex,1:gene_length) = -5 + 9*rand; %center2 [-5 4]
    case 4
        person(mutIndex,1:gene_length) = 0.2 + 1.3 * rand; %sigma1 [0.2,1.3]
    case 5
        person(mutIndex,1:gene_length) = 0.2 + 1.3 * rand; %sigma2 [0.2,1.3]
end
mutated = person(mutIndex,1:gene_length); %The mutated person
end

