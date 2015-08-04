function [inputDir, model_file] = processingConfiguration()
% Function to get common processing input from the user
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%% input dir
inputDir = uigetdir(' ', 'Select your trials folder');

ind=strfind(inputDir, '\dynamicElaborations');


%% model file
scalingDir=[inputDir(1:ind) 'scaling\']; 
    
if exist(scalingDir,'dir') == 7
    
    modelFile=dir([scalingDir '\*.osim']);
    modelFilePath=scalingDir;
    
    if length(modelFile)<2 
        modelFileName=modelFile.name;
        model_file=[scalingDir modelFileName];
    else
        [modelFileName, modelFilePath] = uigetfile([scalingDir '\*.osim'], 'Select the .osim model');
        model_file=[modelFilePath modelFileName];
    end
    
else
    [modelFileName, modelFilePath] = uigetfile([inputDir '\*.osim'], 'Select the .osim model');
    model_file=[modelFilePath modelFileName];
end