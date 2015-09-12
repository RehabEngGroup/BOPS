%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to create the XML Template required by PlotStorage.m function  %
%                (which plots results stored in .sto files).              %
% It allows to define groups for the muscles in the .osim model: results  %
% from muscles belonging to the same group will be plotted in the same    %
%                                 figure.                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

function []=createXMLPlotTemplateFromModel(osim_file, path)
% Inputs:
%   osim_file: full path + name of the .osim model
%   path: where to store the output XML template file
% Output:
%   a XML template with a single group including all muscles of the
%   input model. Starting from this file, users can define their own muscle
%   groups to plot the results with the PlotStorage.m function.


%%

import org.opensim.modeling.*;

osimModel=Model(osim_file);

musclesList = getMTActuatorsFromModel(osim_file);

for m=1:size(musclesList,2)
   
    MuscleList.Muscle{m}=musclesList{m};
end


plotSetting.ID='Template';

plotSetting.osimModelName=osimModel.getName();

plotSetting.MuscleGroups.Group.Name='all';

plotSetting.MuscleGroups.Group.MuscleList=MuscleList;

Pref.CellItem=false;
Pref.StructItem=false;  %to not have arrays of structs with 'item' notation
Pref.ItemName='Muscle';
xml_write([path filesep 'plotSetup_Template_' char(plotSetting.osimModelName) '.xml'],plotSetting,'plotSetting',Pref);