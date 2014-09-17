function [FullFileName, RelativeFilePath] = inputFilesListGeneration(inputDir, trialsList, tag)
% Function to generate the list of .trc files
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

nTrials=length(trialsList);

for k=1:nTrials
    
    inputTrialsFullFilePaths{k}=[inputDir '\' trialsList{k}];
    
    switch tag
        case '.trc'
                      
            FileName{k}=dir([inputTrialsFullFilePaths{k} '\*.trc']);
            nFile=1;
            
        case '.mot' %include results from IK (ik.mot) and .mot storing GRF
            
            FileName{k}=dir([inputTrialsFullFilePaths{k} '\*.mot']);
            
            %MOtoNMS store also emg.mot in the same folder of GRFmot
            nmotFiles=length(FileName{k});
            
            if nmotFiles>1
                
                for i=1:nmotFiles
                    
                    if strcmp(FileName{k}(i).name,'emg.mot')==0
                        nFile=i;
                    end
                end
            else
                nFile=1;
            end  
            
        case '.xml'
            
            nFile=1;
            %FileName{k}=dir([inputTrialsFullFilePaths{k} '\Setup\external_loads.xml']);
            FileName{k}(nFile).name=[ 'Setup\external_loads.xml'];
          
            
        otherwise
            error ([tag ' case missing. Check function inputFilesListGeneration.m'])
            
    end
    
    FullFileName{k}=[inputTrialsFullFilePaths{k} '\' FileName{k}(nFile).name];
    
    RelativeFilePath{k}=['.\' trialsList{k} '\'  FileName{k}(nFile).name];
      
end
