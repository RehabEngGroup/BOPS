function [SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir, inputTrials, model_file, IKmotDir, IDresultDir, SOid, force_set_files, fcut_coordinates, varargin)
% Function to run ID for multiple trials
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
%for both case you can have also the relative path:
%[GRFmotFullFileName, GRFmotRelativePath] = inputFilesListGeneration(inputDir, inputTrials, '.mot');


%% Get the model
osimModel = Model(model_file);
osimModel.initSystem();

%%
nTrials= length(inputTrials);

for k=1:nTrials
    
    results_directory=SOtrialsOutputDir{k};
           
    if exist(results_directory,'dir') ~= 7
        mkdir (results_directory);
    end
    
    coordinates_file=IKmotFullFileName{k};
    external_loads_file=ExtLoadXmlFullFileName{k};
    
    switch nargin
        case 8           
            runSO(osimModel, coordinates_file, external_loads_file, results_directory, force_set_files, fcut_coordinates)
            
        case 7
            runSO(osimModel, coordinates_file, external_loads_file, results_directory, force_set_files)
        
        case 6
            runSO(osimModel, coordinates_file, external_loads_file, results_directory)
    end
end