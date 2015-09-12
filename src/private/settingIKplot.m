function [dofsToPlot,xaxislabel]=settingIKplot(model_file, varargin)
% Function to set plot of results from IK
%
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


%%

import org.opensim.modeling.*

%1- Definition of Dof for plotting
if nargin==1
    
    dofs=getDofsFromModel(model_file);
    
    [selectedDofsIndex,v] = listdlg('PromptString','Select dofs for plots:',...
        'SelectionMode','multiple',...
        'ListString',dofs);
    
    dofsToPlot=dofs(selectedDofsIndex)';
    
%remove hard coded settings
% else  
%     %WARNING: BE SURE to change this HARD-CODED values
%     
%     %remember to change the side
%     side='l';
%     
%     dofsToPlot={
%         strcat('hip_flexion_',side);
%         strcat('hip_adduction_',side);
%         strcat('hip_rotation_',side);
%         strcat('knee_angle_',side);
%         strcat('ankle_angle_',side);
%         strcat('subtalar_angle_',side);
%         };
end


%2- Set x-axis

%default value
%xaxislabel='% Analysis Window';

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

xaxislabel=x_labels{xlabelIndex};
