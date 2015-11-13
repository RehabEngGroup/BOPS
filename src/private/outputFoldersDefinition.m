function [outputDir, trialsOutputDir] = outputFoldersDefinition(inputDir, inputTrials, elaborationID, tag)
% Function to get the IK results folder and the output dir
% for each trial 

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


%%

ind=strfind(inputDir, [filesep 'dynamicElaborations']);

%definition of output dir
switch tag
    case 'IK'
        
        outputDir=[inputDir(1:ind) 'inverseKinematics' filesep elaborationID filesep];
        
    case 'ID'
        
        outputDir=[inputDir(1:ind) 'inverseDynamics' filesep elaborationID filesep];
        
    case 'SO'
        
        outputDir=[inputDir(1:ind) 'staticOptimization' filesep elaborationID filesep];
        
    case 'MA'
        
        outputDir=[inputDir(1:ind) 'muscleAnalysis' filesep elaborationID filesep];
        
        
    otherwise
        error ([tag ' case missing. Check function outputFoldersDefinition.m'])
end

%definition of the output folder for each trial
for k=1:length(inputTrials)  
    trialsOutputDir{k}=[outputDir inputTrials{k}];
end
