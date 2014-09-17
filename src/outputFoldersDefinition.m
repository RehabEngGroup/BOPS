function [outputDir, trialsOutputDir] = outputFoldersDefinition(inputDir, inputTrials, elaborationID, tag)
% Function to get the IK results folder and the output dir
% for each trial 
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

ind=strfind(inputDir, '\dynamicElaborations');

%definition of output dir
switch tag
    case 'IK'
        
        outputDir=[inputDir(1:ind) 'inverseKinematics\' elaborationID '\'];
        
    case 'ID'
        
        outputDir=[inputDir(1:ind) 'inverseDynamics\' elaborationID '\'];
        
    case 'SO'
        
        outputDir=[inputDir(1:ind) 'staticOptimization\' elaborationID '\'];
        
    otherwise
        error ([tag ' case missing. Check function outputFoldersDefinition.m'])
end

%definition of the output folder for each trial
for k=1:length(inputTrials)  
    trialsOutputDir{k}=[outputDir inputTrials{k}];
end
