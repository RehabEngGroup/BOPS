function [MAoutputDir,MAtrialsOutputDir,inputTrials, varargout] = MuscleAnalysis(inputDir, model_file, IKoutputDir, trialsList)
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%% Setting MA

switch nargin
    
    case 2  %no IK before
        
        trialsList = trialsListGeneration(inputDir);
        [MAid, MATemplateXml, fcut_coordinates, inputTrials, IKmotDir] = MAinput(trialsList);
        
    case 3 %IK before, but MA on different trials (for which it has been performed IK)
        
        trialsList = trialsListGeneration(IKoutputDir);
        [MAid, MATemplateXml, fcut_coordinates, inputTrials] = MAinput(trialsList);
        IKmotDir=IKoutputDir;
        
    case 4 %IK before and ID on the same trials
        
        [MAid, MATemplateXml, fcut_coordinates] = MAinput();
        IKmotDir=IKoutputDir;
        inputTrials=trialsList;     
end


%% Running MA

[MAoutputDir, MAtrialsOutputDir]=runMuscleAnalysis(inputDir,inputTrials, model_file, IKmotDir, MAid, MATemplateXml, fcut_coordinates);