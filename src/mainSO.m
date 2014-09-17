% Main script for SO
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>


[inputDir, model_file]=processingInput();

trialsList = trialsListGeneration(inputDir);

%3 different options for setting ID input
%a - base call
%[IDid, IDTemplateXml, IKmotDir] = IDinput();
inputTrials=trialsList; %list of input trials includes all trials

%b - if you want to define the lowpass frequency cut off for filtering coordinates
%[SOid, IKmotDir, IDresultDir, SOTemplateXml, SOActuators, fcut_coordinates] = SOinput();

[SOid, IKmotDir, IDresultDir, SOActuators] = SOinput();

%[SOid, IKmotDir, IDresultDir] = SOinput();


%[SOoutputDir, SOtrialsOutputDir]=runInverseDynamics(inputDir,inputTrials, model_file, IKmotDir, IDresultDir, SOid, SOActuators, fcut_coordinates); 

[SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir,inputTrials, model_file, IKmotDir, IDresultDir, SOid, SOActuators); 
