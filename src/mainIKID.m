% Main script for IK and ID
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

[inputDir, model_file]=processingInput();

%Get trials in the input folder
trialsList = trialsListGeneration(inputDir);

%% INVERSE KINEMATICS

[IKid, IKTemplateXml] = IKinput();
inputTrials=trialsList; %list of input trials includes all trials

%if you want to process a subset of all trials, call the function as:
%[IKid, IKTemplateXml,inputTrials] = IKinput(trialsList);

[IKoutputDir, IKtrialsOutputDir]=runInverseKinematics(inputDir,inputTrials, model_file, IKTemplateXml, IKid); 

%if plot or output are not necessary, you can call the function like this:
%runInverseKinematics(inputDir,inputTrials, model_file, IKTemplateXml, ikID); 

% Plotting

%WARNING: REMEMBER to modify the following function: it has hard coded setting!!!
%[anglesToPlot,IKxlabel]=settingIKplot();

%to select anglesToPlot from GUI
[anglesToPlot,IKxlabel]=settingIKplot(model_file);

%Plot results for each trial
plotProcessingResults(IKtrialsOutputDir,'ik.mot',anglesToPlot,IKxlabel)
%Plot results of all trials together
plotResultsTogheter(IKoutputDir,inputTrials, 'ik.mot', anglesToPlot,IKxlabel)

%% INVERSE DYNAMICS

% ID input setting
%[IDid, IDTemplateXml, IKmotDir] = IDinput();
%ask also the frequency cut off for filtering
[IDid, IDTemplateXml, IKmotDir, fcut_coordinates] = IDinput();

%inputTrials assumed to be the same of IK (you need to have done IK before performing ID)

%[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid); 
[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid, fcut_coordinates); 

%if plot or output are not necessary, you can call the function like this:
%runInverseDynamics(inputDir,inputTrials, model_file, IDTemplateXml, idID); 

% Plotting

%1- REMEMBER to modify the following function: it has hard coded setting
%[momentsToPlot,IDxlabel]=settingIDplot();

%2- OTHERWISE you can exploit the following call
%ask to select dofs in the model
%[momentsToPlot,IDxlabel]=settingIDplot(model_file);

%3- OR use already selected anglesToPlot
[momentsToPlot,IDxlabel]=settingIDplot(model_file,anglesToPlot);

%Plot results for each trial
plotProcessingResults(IDtrialsOutputDir,'inverse_dynamics.sto',momentsToPlot,IDxlabel)
%Plot results of all trials together
plotResultsTogheter(IDoutputDir,inputTrials, 'inverse_dynamics.sto', momentsToPlot,IDxlabel)