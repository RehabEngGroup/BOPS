function [IDoutputDir,IDtrialsOutputDir,inputTrials, varargout] = InverseDynamics(inputDir, model_file, IKoutputDir, trialsList)

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