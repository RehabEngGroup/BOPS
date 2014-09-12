function [dofsToPlot,xlabel]=settingIKplot(model_file, varargin)
% Function to set plot of results from IK
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

import org.opensim.modeling.*

%Definition of Dof for plotting
if nargin==1
    
    dofs=getDofsFromModel(model_file);
    
    [selectedDofsIndex,v] = listdlg('PromptString','Select x-axis for plots:',...
        'SelectionMode','multiple',...
        'ListString',dofs);
    
    dofsToPlot=dofs(selectedDofsIndex)';
    
else
    %WARNING: BE SURE to change this HARD-CODED values
    
    %remember to change the side
    side='r';
    
    dofsToPlot={
        strcat('hip_flexion_',side);
        strcat('hip_adduction_',side);
        strcat('hip_rotation_',side);
        strcat('knee_angle_',side);
        strcat('ankle_angle_',side);
        strcat('subtalar_angle_',side);
        };
end


%Set x-axis

%default value
xlabel='% Analysis Window';


%Possible choices
%Uncomment this part if you want to ask to the user 
% x_labels={
%     'time [s]';
%     '% stance';
%     '% gait cycle';
%     '% time';
%     '% Analysis Window';
%     };
% 
% [xlabelIndex,v] = listdlg('PromptString','Select x-axis for plots:',...
%     'SelectionMode','single',...
%     'ListString',x_labels);
% 
% xlabel=x_labels{xlabelIndex};
