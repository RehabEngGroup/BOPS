function []=runSO(osimModel, coordinates_file, external_loads_file, results_directory, force_set_files, XMLTemplate, lowpassfcut, varargin)
% Function to run SO for a single trial
%input:
%model_file
%coordinates_file
%external_loads_file
%results_directory
%force_set_files (optional, but usually used)
%XMLTemplate (used until problems with API will be solved)
%lowpassfcut (optional)
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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

if nargin >4  %Set actuators file    
    forceSet = ArrayStr();
    forceSet.append(force_set_files);
    analyzeTool.setForceSetFiles(forceSet);
end

% Get mot data to determine time range
motData = Storage(coordinates_file);

% Get initial and intial time
initial_time = motData.getFirstTime();
final_time = motData.getLastTime();

analyzeTool.setInitialTime(initial_time);
analyzeTool.setFinalTime(final_time);

analyzeTool.setSolveForEquilibrium(false)
analyzeTool.setMaximumNumberOfSteps(20000)
analyzeTool.setMaxDT(1)
analyzeTool.setMinDT(1e-008)
analyzeTool.setErrorTolerance(1e-005)

%% Static Optimization

%so = createStaticOptimizationObj(initial_time, final_time);

%Append to analyzeTool
%analyzeTool.getAnalysisSet().adoptAndAppend(so);

%to avoid memory leak with MATLAB, use the Static Optimization object load
%with the XMLTemplate, and set just initial and final time
analyzeTool.getAnalysisSet().get(0).setStartTime(initial_time);
analyzeTool.getAnalysisSet().get(0).setEndTime(final_time);

%%
%analyzeTool.setControlsFileName()

analyzeTool.setExternalLoadsFileName(external_loads_file);
analyzeTool.setCoordinatesFileName(coordinates_file);

if nargin ==7
    analyzeTool.setLowpassCutoffFrequency(lowpassfcut);
else if nargin<6 %else set the value in the XMLTemplate
        analyzeTool.setLowpassCutoffFrequency(-1); %the default value is -1.0, so no filtering
    end
end


%% Save the settings in the Setup folder
setupFileDir=[results_directory '\Setup'];

if exist(setupFileDir,'dir') ~= 7
    mkdir (setupFileDir);
end

setupFile='setup_SO.xml';
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



