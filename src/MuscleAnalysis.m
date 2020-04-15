function [MAoutputDir,MAtrialsOutputDir,inputTrials, varargout] = MuscleAnalysis(inputDir, model_file, IKoutputDir, trialsList)

% This file is part of Batch OpenSim Processing Scripts (BOPS).
%
% Copyright (C) 2020 Bruno Bedo, Danilo Catelli, William Cruaud, Mario Lamontagne
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
% Author(s): Alice Mantoan, <ali.mantoan@gmail.com>
%            Monica Reggiani, <monica.reggiani@gmail.com>

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