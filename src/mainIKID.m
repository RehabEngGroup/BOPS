% Main script for IK and ID
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

[inputDir, model_file]=processingInput();

%Get trials in the input folder
trialsList = trialsListGeneration(inputDir);

[IKid, IKTemplateXml] = IKinput();
inputTrials=trialsList; %list of input trials includes all trials

%if you want to process a subset of all trials, call the function as:
%[IKid, IKTemplateXml,inputTrials] = IKinput(trialsList);

[IKoutputDir, IKtrialsOutputDir]=runInverseKinematics(inputDir,inputTrials, model_file, IKTemplateXml, IKid); 

%if plot or output are not necessary, you can call the function like this:
%runInverseKinematics(inputDir,inputTrials, model_file, IKTemplateXml, ikID); 

%% Plotting

%WARNING: REMEMBER to modify the following function: it has hard coded setting!!!
[anglesToPlot,IKxlabel]=settingIKplot();

%to select anglesToPlot from GUI
% [anglesToPlot,xlabel]=settingIKplot(model_file)

plotProcessingResults(IKtrialsOutputDir,'ik.mot',anglesToPlot,IKxlabel)

plotResultsTogheter(IKoutputDir,inputTrials, 'ik.mot', anglesToPlot,IKxlabel)

%%

%if you want to define the lowpass frequency cut off for filtering coordinates
[IDid, IDTemplateXml, IKmotDir, fcut_coordinates] = IDinput();
%if you want also to process a subset of all trials
%[IDid, IDTemplateXml, IKmotDir, fcut_coordinates, inputTrials] = IDinput();


%[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid); 

%if you have defined the lowpass frequency cut off for filtering
%coordinates, call lije this:
[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid, fcut_coordinates); 

%if plot or output are not necessary, you can call the function like this:
%runInverseDynamics(inputDir,inputTrials, model_file, IDTemplateXml, idID); 

%% Plotting

%REMEMBER to modify the following function: it has hard coded setting
[momentsToPlot,IDxlabel]=settingIDplot();
%OTHERWISE you can exploit the following call
%ask to select dofs in the model
%[momentsToPlot,IDxlabel]=settingIDplot(model_file);
%use already selected anglesToPlot
%[momentsToPlot,IDxlabel]=settingIDplot(model_file,anglesToPlot);

plotProcessingResults(IDtrialsOutputDir,'inverse_dynamics.sto',momentsToPlot,IDxlabel)

plotResultsTogheter(IDoutputDir,inputTrials, 'inverse_dynamics.sto', momentsToPlot,IDxlabel)