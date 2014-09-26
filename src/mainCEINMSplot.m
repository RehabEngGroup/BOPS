%main CEINMS output plot 

%% input dir
resultsDir = uigetdir(' ', 'Select your results folder');

%Get trials in the input folder
trialsList = trialsListGeneration(resultsDir);
inputTrials=trialsList;

%definition of the output folder for each trial
for k=1:length(trialsList)  
    trialsResultsDir{k}=[resultsDir filesep inputTrials{k}];
end


%Plot results for each trial
plotProcessingResults(trialsResultsDir,'Torques.sto','% Stance')

plotResultsMultipleTrials(resultsDir, trialsList, 'Torques.sto','% Stance')