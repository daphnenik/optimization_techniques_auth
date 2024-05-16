% RUNTIME AROUND 4 MINUTES!!!

mutationProb = 20;
maxGen = 1000;
gaussians = 15;
geneSize = gaussians*5;

% Calculate our best solution and our error. 

[bestSolution,bestError] = myGA(gaussians,maxGen,mutationProb);

% Load our best result from the tests and generate plots
%load opt5.mat

result_plot(bestSolution,geneSize,bestError)

gaussianNames = {'1st Gaussian';'2nd Gaussian';'3rd Gaussian';'4th Gaussian';...
    '5th Gaussian';'6th Gaussian';'7th Gaussian';'8th Gaussian';'9th Gaussian';...
    '10th Gaussian';'11th Gaussian';'12th Gaussian';'13th Gaussian';...
    '14th Gaussian';'15th Gaussian'};

% Gaussian parameters
A = bestSolution(1:5:end)';
center1 = bestSolution(2:5:end)'; 
center2 = bestSolution(3:5:end)';
sigma1 = bestSolution(4:5:end)'; 
sigma2 = bestSolution(5:5:end)'; 

gaussiansTable = table(gaussianNames,A,center1,center2,sigma1,sigma2);
disp(gaussiansTable)
%writetable(gaussiansTable,'Gaussians.xlsx','FileType','spreadsheet');