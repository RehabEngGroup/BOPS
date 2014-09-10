function [trialsList, trialsOutputDir] = trialsSetup(inputDir, ikID)
% Function to get the trials list from the input folder and the output dir
% for each trial 
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

ind=strfind(inputDir, '\dynamicElaborations');
IKoutputDir=[inputDir(1:ind) 'inverseKinematics\' ikID '\'];

trials=dir(inputDir);
j=1;

for k=3:length(trials)

    if trials(k).isdir==1
        trialsList{j}=trials(k).name;
        trialsOutputDir{j}=[IKoutputDir trialsList{j}];
        j=j+1;
    end
end

