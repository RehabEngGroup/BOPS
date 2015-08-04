% Main script for Processing Data: IK, ID, SO, MA
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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
%[IDoutputDir, IDtrialsOutputDir, processedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir, IKprocessedTrials); 

%when run IK before, but ID on different trials
[IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir); 

%if no IK before:
%[IDoutputDir, IDtrialsOutputDir, processedTrials]=InverseDynamics(inputDir, model_file);



%% Plotting ID results

IDfilename='inverse_dynamics.sto';

if exist('coordinates','var') && exist('Xaxislabel','var')  %same X-axis label
    plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates, Xaxislabel)
else if exist('coordinates','var')       %same coordinates, different X axis
        plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates) %add "_moment" to coordinates
    else %if no IK before
        plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename)
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



