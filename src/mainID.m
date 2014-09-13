% Main script for ID
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

[inputDir, model_file]=processingInput();

trialsList = trialsListGeneration(inputDir);

%3 different options for setting ID input
%a - base call
%[IDid, IDTemplateXml, IKmotDir] = IDinput();
inputTrials=trialsList; %list of input trials includes all trials

%b - if you want to define the lowpass frequency cut off for filtering coordinates
[IDid, IDTemplateXml, IKmotDir, fcut_coordinates] = IDinput();
%NOTE: if you do not define the lowpass frequency cut off, the value is load from the IDTemplateXml template

%c - if you want also to process a subset of all trials
%[IDid, IDTemplateXml, IKmotDir, fcut_coordinates, inputTrials] = IDinput();


%% 3 different calls for runInverseDynamics:

%a -without definition of fcut_coordinates: the value is load from the IDTemplateXml template
%[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid); 

%b- if you have defined the lowpass frequency cut off for filtering coordinates, call like this:
[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid, fcut_coordinates); 

%c- if plot or output are not necessary, you can call the function like this:
%runInverseDynamics(inputDir,inputTrials, model_file, IDTemplateXml, idID); 

%% Plotting

%REMEMBER to modify the following function: it has hard coded setting
%[momentsToPlot,IDxlabel]=settingIDplot();

%OTHERWISE you can exploit the following call: it asks to select dofs from the model
[momentsToPlot,IDxlabel]=settingIDplot(model_file);

%Plot results for each trial
plotProcessingResults(IDtrialsOutputDir,'inverse_dynamics.sto',momentsToPlot,IDxlabel)

%Plot results of all trials together
plotResultsTogheter(IDoutputDir,inputTrials, 'inverse_dynamics.sto', momentsToPlot,IDxlabel)