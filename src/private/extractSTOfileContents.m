function stoFilesID=extractSTOfileContents(stoFiles)


stoFilesContents={ %SO
                  'activation' 
                  'force'       
                  %MA
                  'ActiveFiberForce'
                  'ActiveFiberForceAlongTendon'
                  'FiberActivePower'
                  'FiberForce'
                  'FiberLength'
                  'FiberPassivePower'
                  'FiberVelocity'
                  'Length'  
                  'Moment'
                  'MomentArm'
                  'MuscleActuatorPower'
                  'NormalizedFiberLength'
                  'NormFiberVelocity'
                  'PassiveFiberForce'
                  'PassiveFiberForceAlongTendon'
                  'PennationAngle'
                  'PennationAngularVelocity'
                  'TendonForce'
                  'TendonLength'
                  'TendonPower'
                  %CEINMS
                  'Activations'
                  'FiberLenghts' 
                  'FiberVelocities'
                  'MuscleForces'
                  'NormFiberLengths'
                  'NormFiberVelocities'
                  'PennationAngles'
                  'MeasuredExcitations'
                  };

nSTOfileContents=size(stoFilesContents,1);
nSTOfiles=size(stoFiles,2);

for k=1:nSTOfiles
    
    file=stoFiles{k};
    
    for i=1:nSTOfileContents
    
        index=strfind(file,stoFilesContents{i});
        
        if isempty(index)==0
            
            %stoFilesID{k}=stoFilesContents{i};
            stoFilesID{k}=file(index:end);
            stoFilesID{k}=regexprep(stoFilesID{k},'.sto','');
            
        end
    end
end

        