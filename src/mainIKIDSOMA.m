% Main script for Processing Data: IK, ID, SO, MA
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

%Plotting

%WARNING: REMEMBER to modify the following function: it has hard coded setting!!!
%[anglesToPlot,IKxlabel]=settingIKplot();

%To avoid hard coded settings: selection of anglesToPlot from GUI
[anglesToPlot,IKxlabel]=settingIKplot(model_file);

%Plot results for each trial
plotProcessingResults(IKtrialsOutputDir,'ik.mot',IKxlabel, anglesToPlot)

%Plot results of all input trials together
plotResultsMultipleTrials(IKoutputDir,inputTrials, 'ik.mot',IKxlabel, anglesToPlot)

%% INVERSE DYNAMICS

% ID input setting
%[IDid, IDTemplateXml, IKmotDir] = IDinput();
%ask also the frequency cut off for filtering
[IDid, IDTemplateXml, IKmotDir, fcut_coordinates] = IDinput();

%inputTrials assumed to be the same of IK (you need to have done IK before performing ID)

%[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid); 
[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid, fcut_coordinates); 


% Plotting

%3- OR use already selected anglesToPlot
[momentsToPlot,IDxlabel]=settingIDplot(model_file,anglesToPlot);

%Plot results for each trial
plotProcessingResults(IDtrialsOutputDir,'inverse_dynamics.sto',IDxlabel, momentsToPlot)
%Plot results of all input trials together
plotResultsMultipleTrials(IDoutputDir,inputTrials, 'inverse_dynamics.sto',IDxlabel, momentsToPlot)


%% STATIC OPTIMIZATION


[SOid, XMLsetupTemplate, SOActuators] = SOinput();


[SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir,inputTrials, model_file, IKmotDir, IDoutputDir, SOid, SOActuators, XMLsetupTemplate); 


%% Muscle Analysis

[MAid, MATemplateXml] = MAinput();

[MAoutputDir, MAtrialsOutputDir]=runMuscleAnalysis(inputDir,inputTrials, model_file, IKmotDir, MAid, MATemplateXml); 

[MAoutputDir, MAtrialsOutputDir]=runMuscleAnalysis(inputDir,inputTrials, model_file, IKmotDir, MAid, MATemplateXml, 6);

