function DofsList = getDofsFromModel(osim_file)
% Function to get dofs from the osim model with OpenSim API

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

import org.opensim.modeling.*;

model=Model(osim_file);

jointSet = model.getJointSet();
nJoints = jointSet.getSize();

modelDofs=[];

for i = 0:nJoints-1
    
    joint = jointSet.get(i);
    
    %Get dofs for the current joint
    jointDofs  = getJointDofs(joint);
    
    %concatenate dofs for all joints
    modelDofs=[modelDofs jointDofs];
    
    
end

%create a list of string
nDofs=size(modelDofs,1);

for k=1:nDofs
    
    DofsList{k}=char(modelDofs(k));
end



