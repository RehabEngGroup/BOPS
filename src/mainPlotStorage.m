%main plot result

%% input dir
resultsDir = uigetdir(' ', 'Select your results folder');

%Get trials in the input folder
trialsList = trialsListGeneration(resultsDir);
inputTrials=trialsList;

%definition of the output folder for each trial
for k=1:length(trialsList)  
    trialsResultsDir{k}=[resultsDir filesep inputTrials{k}];
end

[stoFilesNameList, stoFilesID, musclesGroups,xaxislabel]=settingSTOplot(trialsResultsDir);

plotSTOgroups(trialsResultsDir,stoFilesNameList,stoFilesID, musclesGroups,xaxislabel)