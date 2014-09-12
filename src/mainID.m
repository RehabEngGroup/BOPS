% Main script for ID
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

[inputDir, model_file]=processingInput();

trialsList = trialsListGeneration(inputDir);

%[IDid, IDTemplateXml, IKmotDir] = IDinput();
inputTrials=trialsList;

%if you want to define the lowpass frequency cut off for filtering coordinates
%[IDid, IDTemplateXml, IKmotDir, fcut_coordinates] = IDinput();
%if you want also to process a subset of all trials
[IDid, IDTemplateXml, IKmotDir, fcut_coordinates, inputTrials] = IDinput();


%[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid); 

%if you have defined the lowpass frequency cut off for filtering
%coordinates, call lije this:
[IDoutputDir, IDtrialsOutputDir]=runInverseDynamics(inputDir,IKmotDir, inputTrials, model_file, IDTemplateXml, IDid, fcut_coordinates); 

%if plot or output are not necessary, you can call the function like this:
%runInverseDynamics(inputDir,inputTrials, model_file, IDTemplateXml, idID); 

%% Plotting

%REMEMBER to modify the following function: it has hard coded setting
[momentsToPlot,IDxlabel]=settingIDplot();

plotProcessingResults(IDtrialsOutputDir,'inverse_dynamics.sto',momentsToPlot,IDxlabel)

plotResultsTogheter(IDoutputDir,inputTrials, 'inverse_dynamics.sto', momentsToPlot,IDxlabel)