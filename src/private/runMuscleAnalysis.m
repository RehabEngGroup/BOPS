function [MAoutputDir, MAtrialsOutputDir]=runMuscleAnalysis(inputDir,inputTrials, model_file, IKmotDir, MAid, MATemplateXml, fcut_coordinates, varargin)
% Function to run Muscle Analysis for multiple trials
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com> 

%%
import org.opensim.modeling.*

%Definition of output folders
[MAoutputDir, MAtrialsOutputDir] = outputFoldersDefinition(inputDir, inputTrials, MAid, 'MA');

%Definition of input files lists
[IKmotFullFileName] = inputFilesListGeneration(IKmotDir, inputTrials, '.mot');



%%
nTrials= length(inputTrials);

for k=1:nTrials
    
    %Get the model
    osimModel = Model(model_file);
    osimModel.initSystem();
           
    results_directory=MAtrialsOutputDir{k};
           
    if exist(results_directory,'dir') ~= 7
        mkdir (results_directory);
    end
    
    coordinates_file=IKmotFullFileName{k};

    %save_to_base(1)
    switch nargin 
           
        case 6  %until there will be probl setting the Muscle Analysis object with API
            runMA(osimModel, coordinates_file, results_directory, MATemplateXml)
            
        case 5  %it will be the optimal case when API problems will be solved
            runMA(osimModel, coordinates_file, results_directory)            
            
        %very rare          
        case 7
            runMA(osimModel, coordinates_file, results_directory, MATemplateXml, fcut_coordinates)
    end
    
    clear  osimModel coordinates_file results_directory
    
end