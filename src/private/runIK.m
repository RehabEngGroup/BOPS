function []=runIK(model, marker_file, genericSetupFileFullPath, results_directory)
% Function to run IK for a single trial using OpenSim API
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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
ikTool.setOutputMotionFileName([results_directory '\' output_motion_file]);


% Save the settings in a setup file
setupFile = 'setup_IK.xml';

setupFileDir=[results_directory '\Setup'];

if exist(setupFileDir,'dir') ~= 7
    mkdir (setupFileDir);
end

ikTool.print([setupFileDir '\' setupFile]);

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

