function [IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir, IKmotDir, inputTrials, model_file, IDextLoadTemplate, IDid, fcut_coordinates, varargin)
% Function to run ID for multiple trials
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*

%Definition of output folders
[IDoutputDir, IDtrialsOutputDir] = outputFoldersDefinition(inputDir, inputTrials, IDid, 'ID');

%Definition of input files lists
[IKmotFullFileName] = inputFilesListGeneration(IKmotDir, inputTrials, '.mot');

[GRFmotFullFileName] = inputFilesListGeneration(inputDir, inputTrials, '.mot');
%for both case you can have also the relative path:
%[GRFmotFullFileName, GRFmotRelativePath] = inputFilesListGeneration(inputDir, inputTrials, '.mot');


%% Get the model
osimModel = Model(model_file);
osimModel.initSystem();

%%
nTrials= length(inputTrials);

for k=1:nTrials
        
    results_directory=IDtrialsOutputDir{k};
           
    if exist(results_directory,'dir') ~= 7
        mkdir (results_directory);
    end
    
    coordinates_file=IKmotFullFileName{k};
    GRFmot_file=GRFmotFullFileName{k};
  
    if nargin>6
        runID(osimModel, coordinates_file, GRFmot_file, IDextLoadTemplate, results_directory, fcut_coordinates)
    else
        runID(osimModel, coordinates_file, GRFmot_file, IDextLoadTemplate, results_directory)
    end
end
