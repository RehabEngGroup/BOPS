% Main script for Muscle Analysis
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

[inputDir, model_file]=processingInput();

%Get trials in the input folder
trialsList = trialsListGeneration(inputDir);


[MAid, MATemplateXml, IKresultsDir] = MAinput();
inputTrials=trialsList; %list of input trials includes all trials


[MAoutputDir, MAtrialsOutputDir]=runMuscleAnalysis(inputDir,inputTrials, model_file, IKresultsDir, MAid, MATemplateXml); 