%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 BOPS                                    %
%                    BATCH OPENSIM PROCESSING SCRIPTS                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BOPS main script. It allows to process data without using the GUI.

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


%% Processing Configuration

[inputDir, model_file]=processingConfiguration();


%% INVERSE KINEMATICS

[IKoutputDir, IKtrialsOutputDir, IKprocessedTrials]=InverseKinematics(inputDir, model_file); 


%% Plotting IK results

IKmotFilename='ik.mot'; %our default name
[coordinates,Xaxislabel]=plotResults('IK', IKoutputDir, IKtrialsOutputDir, model_file, IKprocessedTrials, IKmotFilename);


%% INVERSE DYNAMICS

%when run IK before & want to process the same trials
%[IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir, IKprocessedTrials); 

%when run IK before, but ID on different trials
[IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir); 

%if no IK before:
%[IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file);



%% Plotting ID results

IDfilename='inverse_dynamics.sto';

if exist('coordinates','var') && exist('Xaxislabel','var')  %same X-axis label
    plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates, Xaxislabel);
else if exist('coordinates','var')       %same coordinates, different X axis
        plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates); %add "_moment" to coordinates
    else %if no IK before
        plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename);
    end
end


%% Muscle Analysis

%when run IK before & want to process the same trials
[MAoutputDir,MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file, IKoutputDir, IKprocessedTrials); 

%when run IK before, but MA on different trials
%[MAoutputDir, MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file, IKoutputDir); 

%if no IK before:
%[MAoutputDir, MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file);


%% Plot Storage (MA)
if exist('Xaxislabel','var')
    plotStorage(Xaxislabel)
else
    plotStorage()
end


%% STATIC OPTIMIZATION

%when run IK and ID before & want to process the same trials (of ID)
[SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir, IDprocessedTrials); 

%when run IK and ID before, but SO on different trials
%[SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir); 

%if no IK and ID before:
%[SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file); 


%% Plot Storage (SO)

if exist('Xaxislabel','var')
    plotStorage(Xaxislabel)
else
    plotStorage()
end



