function []=plotStorage(XaxisLabel)

% This file is part of Batch OpenSim Processing Scripts (BOPS).
% Copyright (C) 2015 Alice Mantoan, Monica Reggiani
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%     http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
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