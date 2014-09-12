function []=runID(osimModel, coordinates_file, GRFmot_file, genericExtLoadFullPath, results_directory, lowpassfcut, varargin)
% Function to run ID for a single trial
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*
    
disp('Solving ID..')

idTool = InverseDynamicsTool();

idTool.setModel(osimModel);
idTool.setModelFileName(osimModel.getDocumentFileName());

% Get mot data to determine time range
motData = Storage(coordinates_file);

% Get initial and intial time
initial_time = motData.getFirstTime();
final_time = motData.getLastTime();


%External Load File
externForcesTree = xml_read(genericExtLoadFullPath);

externForcesTree.ExternalLoads.datafile = GRFmot_file;
externForcesTree.ExternalLoads.external_loads_model_kinematics_file = coordinates_file;

if nargin<6
    lowpassfcut=externForcesTree.ExternalLoads.lowpass_cutoff_frequency_for_load_kinematics;
end
%externForcesTree.ExternalLoads.lowpass_cutoff_frequency_for_load_kinematics = lowpassfcut;

% Create name for a subject specific external loads xml
extLoadsXml = 'external_loads.xml';

xml_write([results_directory '\' extLoadsXml], externForcesTree, 'OpenSimDocument');
    
    
idTool.setResultsDir(results_directory);

%retrieve input dir
index=strfind(coordinates_file, '\ik');
idTool.setInputsDir(coordinates_file(1:index));


idTool.setStartTime(initial_time);
idTool.setEndTime(final_time);

excludedForces = ArrayStr();
excludedForces.append('Muscles');
idTool.setExcludedForces(excludedForces);

idTool.setExternalLoadsFileName([results_directory '\' extLoadsXml]);

idTool.setCoordinatesFileName(coordinates_file);
idTool.setLowpassCutoffFrequency(lowpassfcut);
idTool.setOutputGenForceFileName([ 'inverse_dynamics.sto' ]);

% Save the settings in a setup file
setupFile = 'setup_ID.xml';

setupFileDir=[results_directory '\Setup'];

if exist(setupFileDir,'dir') ~= 7
    mkdir (setupFileDir);
end

idTool.print([setupFileDir '\' setupFile]);

fprintf([ 'Performing ID \n'])

matlabdir=pwd;
cd([setupFileDir])
dos(['id -S ',setupFile]);
cd(matlabdir);
%idTool.run();


