function [] = runInverseKinematics(inputDir,model_file, ikID, IKTemplateXml)
% Function to run IK for multiple trials
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*

ind=strfind(inputDir, '\dynamicElaborations');
IKoutputDir=[inputDir(1:ind) 'inverseKinematics\' ikID '\'];

[trialsList, trialsOutputDir] = trialsSetup(inputDir, ikID);

[trcFullFileName, trcRelativePath] = trcListGeneration(inputDir, trialsList);


%% Get the model
osimModel = Model(model_file);
osimModel.initSystem();

%%
nTrials= length(trialsList);

for k=1:nTrials
        
    results_directory=trialsOutputDir{k};
    
    marker_file=trcFullFileName{k};
    
    if exist(results_directory,'dir') ~= 7
        mkdir (results_directory);
    end
   
    runIK(osimModel, marker_file, IKTemplateXml, results_directory)
    
end

%Save the log file
copyfile('out.log',[IKoutputDir 'out.log'])


