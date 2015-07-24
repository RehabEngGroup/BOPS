function MusclesList = getMTActuatorsFromModel(osim_file)
% Function to get muscles from the osim model with OpenSim API
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*;

model=Model(osim_file);

nMTActuators = model.getMuscles().getSize();


MusclesList=[];

for i = 0:nMTActuators-1
    
    %Get muscle name
    muscle  = model.getMuscles().get(i);
    
    %concatenate dofs for all joints
    MusclesList{i+1}=char(muscle);
       
end

