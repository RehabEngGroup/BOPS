function [ singleJointDofs ] = getJointDofs(osimJoint)
% Function to get all dofs of a single joint
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*;

coordinateSet = osimJoint.getCoordinateSet();
nCoordinates = coordinateSet.getSize();

for i = 0:nCoordinates-1
    singleJointDofs(i+1) = coordinateSet.get(i).getName();

end


