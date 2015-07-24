function [stoFiles, stoFilesID, musclesGroups,xlabel, Yaxislabel, varargout]=settingSTOplot(trialsResultsDir)
% Function to set plot of results from .sto files
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
%
%stoFilesName = uigetfile([trialsResultsDir{1} '\*.sto'], 'Select file');

stoFilesName = dir([trialsResultsDir{1} '\*.sto']);

for k=1:length(stoFilesName)
        stoFilesList{k}=stoFilesName(k).name;
end


[stoFilesIndex,v] = listdlg('PromptString','Select .sto files to plot:',...
    'SelectionMode','multiple',...
    'ListString',stoFilesList);

stoFiles=stoFilesList(stoFilesIndex);

stoFilesID=extractSTOfileContents(stoFiles);

%Get template for the XML setup file
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','PlotStorage') filesep];   
cd(originalPath)

[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select setup file for plotting .sto file');

plotSetupFile = [pathname filename]; 

[musclesGroups]=muscleGroupsFromXMLSetup(plotSetupFile);


%Set x-axis

%default value
xlabel='% Analysis Window';

%Possible choices
%Uncomment this part if you want to ask to the user 
x_labels={
    '% Analysis Window';
    '% Stance';
    '% Gait Cycle';
    '% time';
    'time [s]';
    };

[xlabelIndex,v] = listdlg('PromptString','Select x-axis for plots:',...
    'SelectionMode','single',...
    'ListString',x_labels);

xlabel=x_labels{xlabelIndex};


%Set Y-axis unit
% 
% switch stoFilesID
%     
%     case {'activation', 'Activations'}
%         
%         %Yaxislabel=
%         
%     case {'force', 'MuscleForces'}
%         
%         Yaxislabel='Forces (N)';
%         
%     case {'Lenght', 'FiberLengths'}
%         
%         %Yaxislabel
%         
%     case {'MomentArm'}
%         
%     case {'FiberVelocities'}
%         
%     case {'MeasuredExcitations'}  
%         
%     otherwise
%         
% end

