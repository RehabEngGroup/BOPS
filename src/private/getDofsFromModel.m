function DofsList = getDofsFromModel(osim_file)
% Function to get dofs from the osim model with OpenSim API
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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



