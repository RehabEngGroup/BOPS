function [resultsToPlot, xlabel, varargout]=plotResults(tag, outputDir, trialsOutputDir, model_file, processedTrials, filename, coordinates, xlabel)
% coordinates: optional

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
% Author(s): Alice Mantoan, <ali.mantoan@gmail.com>
%            Monica Reggiani, <monica.reggiani@gmail.com>


%% Settings
    
switch tag
    
    case 'IK'
        
        switch nargin
            case {1,2,3,4,5,6}
                [resultsToPlot,xlabel]=settingIKplot(model_file);
            case 7
                error('WARNING: wrong number of input calling plotResults.m')
            case 8
                resultsToPlot=coordinates;
        end
        
    case 'ID'
        
        %         if nargin > 6
        %             [resultsToPlot,xlabel]=settingIDplot(model_file,coordinates);
        %         else
        %             [resultsToPlot,xlabel]=settingIDplot(model_file);
        %         end
        
        switch nargin
            case {1,2,3,4,5,6}
                [resultsToPlot,xlabel]=settingIDplot(model_file);
            case 7
                [resultsToPlot,xlabel]=settingIDplot(model_file,coordinates);
            case 8
                [resultsToPlot]=settingIDplot(model_file,coordinates);
        end
end

%% Plotting        

%Plot results for each trial
plotProcessingResults(trialsOutputDir,filename,xlabel, resultsToPlot)

%Plot results of all input trials together
plotResultsMultipleTrials(outputDir, processedTrials, filename,xlabel, resultsToPlot)