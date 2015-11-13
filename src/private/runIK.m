function []=runIK(model, marker_file, genericSetupFileFullPath, results_directory)
% Function to run IK for a single trial using OpenSim API

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

ikTool = InverseKinematicsTool(genericSetupFileFullPath);

% Tell Tool to use the loaded model
ikTool.setModel(model);

% Get trc data to determine time range
markerData = MarkerData(marker_file);

% Get initial and intial time
initial_time = markerData.getStartFrameTime();
final_time = markerData.getLastFrameTime();

output_motion_file='ik.mot';

% Setup the ikTool for this trial
ikTool.setMarkerDataFileName(marker_file);
ikTool.setStartTime(initial_time);
ikTool.setEndTime(final_time);
ikTool.setOutputMotionFileName([results_directory filesep output_motion_file]);


% Save the settings in a setup file
setupFile = 'setup_IK.xml';

setupFileDir=[results_directory filesep 'Setup'];

if exist(setupFileDir,'dir') ~= 7
    mkdir (setupFileDir);
end

ikTool.print([setupFileDir filesep setupFile]);

fprintf(['Performing IK \n']);

% Run IK via API
ikTool.run();

%or running the .exe
%matlabdir=pwd;
%cd([setupFileDir])
%dos(['ik -S ',setupFile]);
%cd(matlabdir);

%Save the log file in a Log folder for each trial
% logFolder=[results_directory '\Log'];
% if exist(logFolder,'dir') ~= 7
%     mkdir (logFolder);
% end
% copyfile('out.log',[logFolder '\out.log'])

