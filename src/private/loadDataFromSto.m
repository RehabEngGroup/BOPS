function [data, dataLabels] = loadDataFromSto(stoFilePaths, stoFileName)

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

nTrials=size(stoFilePaths,2);

for k=1:nTrials
    
    file=importdata([stoFilePaths{k} filesep stoFileName]);
    data{k}=file.data(:,2:end);
    

    if isfield(file,'colheaders')
        labels{k}=file.colheaders(2:end);
    else
        strheaders=file.textdata{end};
        colheaders=str_sep(strheaders);
        labels{k}=colheaders(2:end);
    end
            
  %save_to_base(1)              
    clear file colheaders strheaders
end

%shuold be the same for all trials
dataLabels=labels{1};
