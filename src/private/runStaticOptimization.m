function [SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir, inputTrials, model_file, IKmotDir, IDresultDir, SOid, force_set_files, XMLTemplate, fcut_coordinates, varargin)
% Function to run SO for multiple trials
%
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


%%
import org.opensim.modeling.*

%Definition of output folders
[SOoutputDir, SOtrialsOutputDir] = outputFoldersDefinition(inputDir, inputTrials, SOid, 'SO');

%Definition of input files lists
[IKmotFullFileName] = inputFilesListGeneration(IKmotDir, inputTrials, '.mot');

[ExtLoadXmlFullFileName] = inputFilesListGeneration(IDresultDir, inputTrials, '.xml');


%%
nTrials= length(inputTrials);

for k=1:nTrials
    
    %Get the model
    osimModel = Model(model_file);
    osimModel.initSystem();
           
    results_directory=SOtrialsOutputDir{k};
           
    if exist(results_directory,'dir') ~= 7
        mkdir (results_directory);
    end
    
    coordinates_file=IKmotFullFileName{k};
    external_loads_file=ExtLoadXmlFullFileName{k};
    
    switch nargin
           
        case 8  %until there will be probl creating a Static Optimization object with API
            runSO(osimModel, coordinates_file, external_loads_file, results_directory, force_set_files, XMLTemplate)
            
        case 7  %it will be the optimal case when API problems will be solved
            runSO(osimModel, coordinates_file, external_loads_file, results_directory, force_set_files)            
            
        case 6
            runSO(osimModel, coordinates_file, external_loads_file, results_directory) % not using Actuators
            
        case 9
            runSO(osimModel, coordinates_file, external_loads_file, results_directory, force_set_files, XMLTemplate, fcut_coordinates)
    end
    
    clear  osimModel external_loads_file coordinates_file results_directory
    
end