function [musclesGroups]=muscleGroupsFromXMLSetup(plotSetupFile)

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

plotsetting=xml_read(plotSetupFile);

nGroups=size(plotsetting.MuscleGroups.Group,2);

for k=1:nGroups
    
    musclesGroups{k}.name=plotsetting.MuscleGroups.Group(k).Name;
    
    nGroupMuscle=size(plotsetting.MuscleGroups.Group(k).MuscleList.Muscle,2);
    
    if iscell(plotsetting.MuscleGroups.Group(k).MuscleList.Muscle)==1
        for i=1:nGroupMuscle          
            musclesGroups{k}.muscle{i}=plotsetting.MuscleGroups.Group(k).MuscleList.Muscle{i};
        end
    else
        musclesGroups{k}.muscle={plotsetting.MuscleGroups.Group(k).MuscleList.Muscle};
    end
end
