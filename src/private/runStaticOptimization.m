function [SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir, inputTrials, model_file, IKmotDir, IDresultDir, SOid, force_set_files, XMLTemplate, fcut_coordinates, varargin)
% Function to run SO for multiple trials
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>  [SOid, IKmotDir, IDresultDir, SOTemplateXml, SOActuators] 

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