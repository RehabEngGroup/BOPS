% Main script for IK
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
%[anglesToPlot,IKxlabel]=settingIKplot();

%To avoid hard coded settings: selection of anglesToPlot from GUI
[anglesToPlot,IKxlabel]=settingIKplot(model_file);

%Plot results for each trial
plotProcessingResults(IKtrialsOutputDir,'ik.mot',anglesToPlot,IKxlabel)

%Plot results of all input trials together
plotResultsMultipleTrials(IKoutputDir,inputTrials, 'ik.mot', anglesToPlot,IKxlabel)

