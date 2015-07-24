function [IKoutputDir,IKtrialsOutputDir, varargout] = runInverseKinematics(inputDir,inputTrials, model_file, IKTemplateXml, IKid)
% Function to run IK for multiple trials
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*

%Definition of output folders
[IKoutputDir, IKtrialsOutputDir] = outputFoldersDefinition(inputDir, inputTrials, IKid, 'IK');

trcFullFileName = inputFilesListGeneration(inputDir, inputTrials, '.trc');
%to have also the relative path:
%[trcFullFileName, trcRelativePath] = inputFilesListGeneration(inputDir, inputTrials, '.trc');


%% Get the model
osimModel = Model(model_file);
osimModel.initSystem();

%%
nTrials= length(inputTrials);

for k=1:nTrials
        
    results_directory=IKtrialsOutputDir{k};
    
    marker_file=trcFullFileName{k};
    
    if exist(results_directory,'dir') ~= 7
        mkdir (results_directory);
    end
   
    runIK(osimModel, marker_file, IKTemplateXml, results_directory)
    
end

%Save the log file
copyfile('out.log',[IKoutputDir 'out.log'])


