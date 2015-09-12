function []=runMA(osimModel, coordinates_file, results_directory, XMLTemplate, lowpassfcut,varargin)
% Function to run MA for a single trial
% Inputs:
%   model_file
%   coordinates_file
%   results_directory
%   XMLTemplate (used until problems with API will be solved)
%   lowpassfcut (optional)

% This file is part of Batch OpenSim Processing Scripts (BOPS).
% Copyright (C) 2015 Alice Mantoan, Monica Reggiani
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%     http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>


%%

import org.opensim.modeling.*

analyzeTool=AnalyzeTool(XMLTemplate);

%Set the model
analyzeTool.setModel(osimModel);
analyzeTool.setModelFilename(osimModel.getDocumentFileName());

analyzeTool.setReplaceForceSet(false);
analyzeTool.setResultsDir(results_directory);
analyzeTool.setOutputPrecision(8)


% Get mot data to determine time range
motData = Storage(coordinates_file);

% Get initial and intial time
initial_time = motData.getFirstTime();
final_time = motData.getLastTime();

analyzeTool.setInitialTime(initial_time);
analyzeTool.setFinalTime(final_time);

analyzeTool.setSolveForEquilibrium(false)
analyzeTool.setMaximumNumberOfSteps(20000)
%analyzeTool.setMaxDT(1e-005)
analyzeTool.setMaxDT(1)
analyzeTool.setMinDT(1e-008)
analyzeTool.setErrorTolerance(1e-005)


%% Muscle Analysis

%ma = createMuscleAnalysisObj(initial_time, final_time);

%Append to analyzeTool
%analyzeTool.getAnalysisSet().adoptAndAppend(ma);

%since setComputeMoments(true) from API does not work, it is necessary to 
%load the XMLTemplate, and set just initial and final time

analyzeTool.getAnalysisSet().get(0).setStartTime(initial_time);
analyzeTool.getAnalysisSet().get(0).setEndTime(final_time);


%%

analyzeTool.setCoordinatesFileName(coordinates_file);

if nargin ==5
     analyzeTool.setLowpassCutoffFrequency(lowpassfcut);
else
     analyzeTool.setLowpassCutoffFrequency(-1); %the default value is -1.0, so no filtering
end


%% Save the settings in the Setup folder
setupFileDir=[results_directory '\Setup'];

if exist(setupFileDir,'dir') ~= 7
    mkdir (setupFileDir);
end

setupFile='setup_MA.xml';
analyzeTool.print([setupFileDir '\' setupFile ]);

%% Run
runAnalyzeTool(setupFileDir, setupFile);

%Save the log file in a Log folder for each trial
logFolder=[results_directory '\Log'];
if exist(logFolder,'dir') ~= 7
    mkdir (logFolder);
end
movefile([setupFileDir '\out.log'],[logFolder '\out.log'])
movefile([setupFileDir '\err.log'],[logFolder '\err.log'])
