% This file is part of Batch OpenSim Processing Scripts (BOPS).
%
% Copyright (C) 2020 Bruno Bedo, Danilo Catelli, William Cruaud, Mario Lamontagne
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
% Author(s): Bruno Bedo,        <bruno.bedo@usp.rb>
%            Danilo S. Catelli, <danilo.catelli@uottawa.ca>
%            William Cruaud,    <w.cruaud@hotmail.fr>

% Setting SO
% clear all

global selections inputDir model_file
%% Loading information
%Get the XML Template
originalPath=pwd;
cd('..')
if selections.LoadTemplateJRA ==1
[Template_FileName,Template_PathName]=uigetfile([pwd filesep fullfile('Templates','\JointReaction') filesep],'Select the TEMPLATE');
XMLTemplate=fullfile(Template_PathName,Template_FileName);
else
TemplatePath=[pwd filesep fullfile('Templates','\JointReaction') filesep];   
XMLTemplate = [TemplatePath,char(selections.TamplateListJRF)];
end

% Get Actuator
if selections.LoadActuadors ==1 || selections.runSO == 0
[Actuator_FileName,Actuator_PathName]=uigetfile([pwd filesep fullfile('Templates','\StaticOptimization') filesep,'*.xml'],'Select the ACTUATOR');
Actuator_directory=fullfile(Actuator_PathName,Actuator_FileName);
else
TemplatePath=[pwd filesep fullfile('Templates','\StaticOptimization') filesep];   
Actuator_directory = [TemplatePath,char(selections.ActuatorsList)];
end

cd(originalPath)

% Get main folder
if exist('inputDir','var') ==0
Main_Folder = uigetdir('pwd','Select the Main Folder where your data are Saved');
else
originalPath=pwd;
if  exist(selections.JRApathRes,'dir') ~= 7
    mkdir (selections.JRApathRes);
end
cd(selections.JRApathRes)
cd ..
Main_Folder = pwd;  
cd(originalPath)
end


% Get Folder with all trials names
if isfield(selections,'trials') == 0
TrialsFolder = [Main_Folder, '\staticOptimization'];

d = dir(TrialsFolder);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
else
nameFolds =  selections.trials(selections.ListTrials);
end

if exist('model_file','var') ==0
oldFolder = cd(Main_Folder);
[OSIM_FileName,OSIM_PathName] =uigetfile('*.osim', 'Select the OSIM File');
OSIM_directory=fullfile(OSIM_PathName,OSIM_FileName);
else
OSIM_directory = model_file;
end


%%
% C = strsplit(Mot_PathName,'\');
for idx=1:length(nameFolds)

    Mot_directory=[Main_Folder,'\inverseKinematics' '\', nameFolds{idx},'\ik.mot'];
    ELoad_directory=[Main_Folder, '\inverseDynamics', '\', nameFolds{idx},'\Setup','\external_loads.xml'];
    SOForce_directory=[Main_Folder, '\staticOptimization', '\', nameFolds{idx},'\_StaticOptimization_force.sto'];
    
    C = strsplit(Mot_directory,'\');

%% Setup 
cd(Main_Folder)
import org.opensim.modeling.*
osimModel = Model(OSIM_directory);
osimModel.initSystem();

analyzeTool=AnalyzeTool(XMLTemplate);
% Analyse_Name=SOForce_FileName(1:end-29)
% analyzeTool.setName(Analyse_Name)

%Set the model
analyzeTool.setModel(osimModel);
analyzeTool.setModelFilename(osimModel.getDocumentFileName());
% Set the Name
% Name=[C{end-3},'_',C{end-1}]
Name=[C{end-1}];
% Name= Name(find(~isspace(Name)));
analyzeTool.setName(Name)

%% Results folder
  Result_Folder=[Main_Folder, '\Joint_Reaction' filesep Name];
%%
if exist(Result_Folder,'dir') ~= 7
    mkdir (Result_Folder);
end
% Set Actuator 
% Instantiate a String Array
as = ArrayStr();
% Set the first value of the array to the actuators file
as.set(0,Actuator_directory);
% Set the force set file to use the new array
analyzeTool.setForceSetFiles(as);


analyzeTool.setReplaceForceSet(false);
analyzeTool.setResultsDir(Result_Folder);
analyzeTool.setOutputPrecision(8)


% Get mot data to determine time range
motData = Storage(SOForce_directory);

% Get initial and intial time
initial_time = motData.getFirstTime();
final_time = motData.getLastTime();

analyzeTool.setInitialTime(initial_time);
analyzeTool.setFinalTime(final_time);

% Other set up

analyzeTool.setSolveForEquilibrium(false);
analyzeTool.setMaximumNumberOfSteps(20000);
%analyzeTool.setMaxDT(1e-005)
analyzeTool.setMaxDT(1);
analyzeTool.setMinDT(1e-008);
analyzeTool.setErrorTolerance(1e-005);



%% Joint reaction Analysis

%ma = createMuscleAnalysisObj(initial_time, final_time);

%Append to analyzeTool
%analyzeTool.getAnalysisSet().adoptAndAppend(ma);

%since setComputeMoments(true) from API does not work, it is necessary to 
%load the XMLTemplate, and set just initial and final time
% 
% analyzeTool.getAnalysisSet().get(0).setStartTime(initial_time);
% analyzeTool.getAnalysisSet().get(0).setEndTime(final_time);


% Create a JR Object and load in Analysis
% import org.opensim.modeling.*

analysis=analyzeTool.getAnalysisSet.get(0);
analysis.getConcreteClassName
NewJRF =JointReaction.safeDownCast(analysis );


NewJRF.setName('JointReaction');
NewJRF.setOn(true);
NewJRF.setStartTime(initial_time);
NewJRF.setEndTime(final_time);
NewJRF.setStepInterval(1);
NewJRF.setInDegrees(true);
NewJRF.setForcesFileName(SOForce_directory);

%% Save the settings in the Setup folder
setupFileDir=[Result_Folder  '\Setup'];

if exist(setupFileDir,'dir') ~= 7
    mkdir (setupFileDir);
end


setupFile=[C{end-1},'_setup_JRF.xml'];
setupFile= setupFile(find(~isspace(setupFile)));



%%
analyzeTool.setExternalLoadsFileName(ELoad_directory);
analyzeTool.setCoordinatesFileName(Mot_directory);

analyzeTool.setLowpassCutoffFrequency(-1);
if selections.JRALowPass >=1
     analyzeTool.setLowpassCutoffFrequency(selections.JRALowPass);
else
     analyzeTool.setLowpassCutoffFrequency(-1); %the default value is -1.0, so no filtering
end

%% Save set up in XML file
%Append to analyzeTool
% analyzeTool.getAnalysisSet.get(0).delete
% analyzeTool.print([setupFileDir '\' setupFilepre ]);
% analyzeTool.getAnalysisSet().adoptAndAppend(NewJRF);
% analyzeTool.print([setupFileDir '\' setupFilepost ]);

analyzeTool.print([setupFileDir '\' setupFile ]);

%% Run
runAnalyzeTool(setupFileDir, setupFile);
% RUNTOOL=analyzeTool.run
%Save the log file in a Log folder for each trial
logFolder=[Result_Folder '\Log'];
if exist(logFolder,'dir') ~= 7
    mkdir (logFolder);
end
% movefile([setupFileDir '\out.log'],[logFolder '\out.log'])
% movefile([setupFileDir '\err.log'],[logFolder '\err.log'])
cd(originalPath)
end