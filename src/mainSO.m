% Main script for SO
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>


[inputDir, model_file]=processingInput();

trialsList = trialsListGeneration(inputDir);


inputTrials=trialsList; %list of input trials includes all trials


[SOid, XMLsetupTemplate, SOActuators, IKresultsDir, IDresultsDir] = SOinput();

%b - if you want to define the lowpass frequency cut off for filtering coordinates
%[SOid, XMLsetupTemplate, SOActuators, IKresultsDir, IDresultsDir, inputTrials, fcut_coordinates] = SOinput();


[SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir,inputTrials, model_file, IKresultsDir, IDresultsDir, SOid, SOActuators, XMLsetupTemplate); 


%[SOoutputDir, SOtrialsOutputDir]=runStaticOptimization(inputDir,inputTrials, model_file, IKresultsDir, IDresultDir, SOid, SOActuators); 
