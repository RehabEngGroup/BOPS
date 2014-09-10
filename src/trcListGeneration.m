function [trcFullFileName, trcRelativePath] = trcListGeneration(inputDir, trialsList)
% Function to generate the list of .trc files
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

nTrials=length(trialsList);

%trc list
for k=1:nTrials
    
    trFullFilePaths{k}=[inputDir '\' trialsList{k}];
    trcFileNames{k}=dir([trFullFilePaths{k} '\*.trc']);
    
    trcFullFileName{k}=[trFullFilePaths{k} '\' trcFileNames{k}.name];
    
    trcRelativePath{k}=['.\' trialsList{k} '\'  trcFileNames{k}.name];
end

