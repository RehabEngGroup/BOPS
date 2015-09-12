function [momentsToPlot,xlabel]=settingIDplot(model_file,anglesToPlot, varargin)
% Function to set plot of results from ID
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

%Definition of Dof for plotting
switch nargin
              
%    case 0  %HARD CODED SETTINGS
        
        %WARNING: BE SURE to change this HARD-CODED values
        
        %REMEMBER to change the side
%         side='r';
%         
%         momentsToPlot={
%             strcat('hip_flexion_',side, '_moment');
%             strcat('hip_adduction_',side, '_moment');
%             strcat('hip_rotation_',side, '_moment');
%             strcat('knee_angle_',side, '_moment');
%             strcat('ankle_angle_',side, '_moment');
%             strcat('subtalar_angle_',side, '_moment');
%             };
     
    case 1
        
        %ask dofs from model 
        dofs=getDofsFromModel(model_file);
        
        [selectedDofsIndex,v] = listdlg('PromptString','Select x-axis for plots:',...
            'SelectionMode','multiple',...
            'ListString',dofs);
        
        dofsToPlot=dofs(selectedDofsIndex)';
        
        nDofs=length(dofsToPlot);
        
        %add 'moment' to dofs
        for i=1: nDofs
            momentsToPlot{i}=strcat(dofsToPlot{i}, '_moment');
        end
        
             
    case 2
        
        %add 'moment' to already selected dofs
        nAnglesToPlot=length(anglesToPlot);
        
        for i=1: nAnglesToPlot
            momentsToPlot{i}=strcat(anglesToPlot{i}, '_moment');
        end

end

%Set x-axis

%default value
%xlabel='% Analysis Window';

%Possible choices
%Uncomment this part if you want to ask to the user 
if nargout > 1
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
end