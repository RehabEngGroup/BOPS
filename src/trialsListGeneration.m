function [trialsList] = trialsListGeneration(inputDir)
% Function to get the trials list from the input folder 
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

trials=dir(inputDir);
j=1;

for k=3:length(trials)

    if trials(k).isdir==1
        trialsList{j}=trials(k).name;
        j=j+1;
    end
end
