function []=runSO(osimModel, coordinates_file, external_loads_file, results_directory, force_set_files, lowpassfcut, varargin)
% Function to run SO for a single trial
%input
%model_file
%coordinates_file
%lowpassfcut (optional)
%results_directory
%external_loads_file
%force_set_files
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

import org.opensim.modeling.*

analyzeTool=AnalyzeTool();

%Set the model
analyzeTool.setModel(osimModel);
analyzeTool.setModelFilename(osimModel.getDocumentFileName());

% Get mot data to determine time range
motData = Storage(coordinates_file);

% Get initial and intial time
initial_time = motData.getFirstTime();
final_time = motData.getLastTime();

analyzeTool.setInitialTime(initial_time);
analyzeTool.setFinalTime(final_time);

%analyzeTool.setControlsFileName()

analyzeTool.setResultsDir(results_directory)

analyzeTool.setReplaceForceSet(false)

analyzeTool.setOutputPrecision(8)
analyzeTool.setSolveForEquilibrium(false)
analyzeTool.setMaximumNumberOfSteps(20000)
analyzeTool.setMaxDT(1)
analyzeTool.setMinDT(1e-008)
analyzeTool.setErrorTolerance(1e-005)

%Static Optimization

so= StaticOptimization(osimModel);
%so= StaticOptimization();

so.setOn(true);
so.setStartTime(initial_time);
so.setEndTime(final_time);

so.setStepInterval(1)
so.setInDegrees(true)
so.setUseModelForceSet(true)
so.setActivationExponent(2)
so.setUseMusclePhysiology(true)
so.setConvergenceCriterion(0.0001)
so.setMaxIterations(100)

%Append to analyzeTool
analyzeTool.getAnalysisSet().adoptAndAppend(so)

if nargin >4
    %Set actuators file
    forceSet = ArrayStr();
    forceSet.append(force_set_files);
    analyzeTool.setForceSetFiles(forceSet)
end

analyzeTool.setExternalLoadsFileName(external_loads_file);
analyzeTool.setCoordinatesFileName(coordinates_file);

if nargin >5
    analyzeTool.setLowpassCutoffFrequency(lowpassfcut);
end


% Save the settings in the Setup folder
setupFileDir=[results_directory '\Setup'];

if exist(setupFileDir,'dir') ~= 7
    mkdir (setupFileDir);
end

setupFile='setup_SO.xml';
analyzeTool.print([setupFileDir '\' setupFile ])

%Run SO
matlabdir=pwd;
cd(setupFileDir)
dos(['analyze -S ',setupFile]);
cd(matlabdir);


%Save the log file in a Log folder for each trial
logFolder=[results_directory '\Log'];
if exist(logFolder,'dir') ~= 7
    mkdir (logFolder);
end
movefile([setupFileDir '\out.log'],[logFolder '\out.log'])
movefile([setupFileDir '\err.log'],[logFolder '\err.log'])
