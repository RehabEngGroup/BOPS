function [IDoutputDir,IDtrialsOutputDir,inputTrials, varargout] = InverseDynamics(inputDir, model_file, IKoutputDir, trialsList)
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%% Setting ID
switch nargin
    
    case 2  %no IK before
        
        trialsList = trialsListGeneration(inputDir);
        [IDid, IDTemplateXml, fcut_coordinates, inputTrials, IKmotDir] = IDinput(trialsList);
        
    case 3 %IK before, but ID on different trials (for which it has been performed IK)
        
        trialsList = trialsListGeneration(IKoutputDir);
        [IDid, IDTemplateXml, fcut_coordinates, inputTrials] = IDinput(trialsList);
        IKmotDir=IKoutputDir;
        
    case 4 %IK before and ID on the same trials
        
        [IDid, IDTemplateXml, fcut_coordinates] = IDinput();
        IKmotDir=IKoutputDir;
        inputTrials=trialsList;       
end


%% Running ID
 
[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid, fcut_coordinates); 