function [resultsToPlot, xlabel, varargout]=plotResults(tag, outputDir, trialsOutputDir, model_file, processedTrials, filename, coordinates, xlabel)
%coordinates optional

% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>


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