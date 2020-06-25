function [stoFiles, stoFilesID, musclesGroups,xlabel, Yaxislabel, varargout]=settingSTOplot(trialsResultsDir)
% Function to set plot of results from .sto files
%
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
% Author(s): Alice Mantoan,     <ali.mantoan@gmail.com>
%            Monica Reggiani,   <monica.reggiani@gmail.com>
%            Bruno Bedo,        <bruno.bedo@usp.rb>
%            Danilo S. Catelli, <danilo.catelli@uottawa.ca>
%            William Cruaud,    <w.cruaud@hotmail.fr>
%            Mario Lamontagne,  <mlamon@uottawa.ca>

%%

%stoFilesName = uigetfile([trialsResultsDir{1} '\*.sto'], 'Select file');
%Get template for the XML setup file
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','PlotStorage') filesep];   
cd(originalPath)

stoFilesName = dir([trialsResultsDir{1} '\*.sto']);

for k=1:length(stoFilesName)
        stoFilesList{k}=stoFilesName(k).name;
end

global selections
if selections.LoadTemplateSO ==1
[stoFilesIndex,v] = listdlg('PromptString','Select .sto files to plot:',...
    'SelectionMode','multiple',...
    'ListString',stoFilesList);

stoFiles=stoFilesList(stoFilesIndex);

stoFilesID=extractSTOfileContents(stoFiles);


[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select setup file for plotting .sto file');

plotSetupFile = [pathname filename]; 
elseif selections.LoadTemplateSO==0
      plotSetupFile = [TemplatePath char(selections.SOPlotSetupList)];
        if strcmp('Force',char(selections.SOselectplot))
           stoFiles = {'_StaticOptimization_force.sto'};
           stoFilesID = {'force'};
        elseif strcmp('Activation',char(selections.SOselectplot))
               stoFiles = {'_StaticOptimization_activation.sto'};
               stoFilesID = {'activation'};
        else
            disp(' ')
            error('The SO files are empty')
        end
end

[musclesGroups]=muscleGroupsFromXMLSetup(plotSetupFile);

if nargout >3
    
    if isempty(selections.XAxis)
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
    else
    xlabel = char(selections.XAxis);
    end
    
end
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

