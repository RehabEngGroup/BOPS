function [SOoutputDir,SOtrialsOutputDir, inputTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir, trialsList)

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
