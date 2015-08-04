function [IKoutputDir,IKtrialsOutputDir,inputTrials, varargout] = InverseKinematics(inputDir, model_file)
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%% Setting IK
%Get trials in the input folder
trialsList = trialsListGeneration(inputDir);
[IKid, IKTemplateXml,inputTrials] = IKinput(trialsList);
    


%% Running IK
[IKoutputDir, IKtrialsOutputDir]=runInverseKinematics(inputDir,inputTrials, model_file, IKTemplateXml, IKid); 