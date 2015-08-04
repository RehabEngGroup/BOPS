function [SOoutputDir,SOtrialsOutputDir, inputTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir, trialsList)
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%% Setting SO

switch nargin
    
    case 2  %no IK and ID before
        
        trialsList = trialsListGeneration(inputDir);
        [SOid, XMLsetupTemplate, fcut_coordinates, SOActuators, inputTrials, IKmotDir, IDoutputDir] = SOinput(trialsList);
        
    case 4 %IK and ID before, but SO on different trials (for which it has been performed ID in the same folder)
        
        trialsList = trialsListGeneration(IDoutputDir);
        [SOid, XMLsetupTemplate, fcut_coordinates, SOActuators, inputTrials] = SOinput(trialsList);
        IKmotDir=IKoutputDir;
        
    case 5 %IK before and ID on the same trials
        
        [SOid, XMLsetupTemplate, fcut_coordinates, SOActuators] = SOinput();
        IKmotDir=IKoutputDir;
        inputTrials=trialsList;     
end


%% Running SO

[SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir,inputTrials, model_file, IKmotDir, IDoutputDir, SOid, SOActuators, XMLsetupTemplate, fcut_coordinates); 
%[SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir,inputTrials, model_file, IKmotDir, IDoutputDir, SOid, SOActuators, XMLsetupTemplate); 
