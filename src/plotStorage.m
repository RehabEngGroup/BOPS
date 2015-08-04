function []=plotStorage(XaxisLabel)

% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%% input dir
resultsDir = uigetdir(' ', 'Select your results folder');

%Get trials in the input folder
trialsList = trialsListGeneration(resultsDir);
inputTrials=trialsList;

%definition of the output folder for each trial
for k=1:length(trialsList)  
    trialsResultsDir{k}=[resultsDir filesep inputTrials{k}];
end

if nargin==1
    
    [stoFilesNameList, stoFilesID, musclesGroups]=settingSTOplot(trialsResultsDir);
    xaxislabel=XaxisLabel;
    
else
    [stoFilesNameList, stoFilesID, musclesGroups,xaxislabel]=settingSTOplot(trialsResultsDir);
end

plotSTOgroups(trialsResultsDir,stoFilesNameList,stoFilesID, musclesGroups,xaxislabel)