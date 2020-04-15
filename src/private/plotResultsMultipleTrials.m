function []=plotResultsMultipleTrials(resultsPath, trialsList, filename,x, Yquantities, varargin)
% Function to plot results from multiple trials

% This file is part of Batch OpenSim Processing Scripts (BOPS).
%
% Copyright (C) 2020 Bruno Bedo, Danilo Catelli, William Cruaud, Mario Lamontagne
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
% Author(s): Alice Mantoan, <ali.mantoan@gmail.com>
%            Monica Reggiani, <monica.reggiani@gmail.com>


%%

close all
%Load data
for k=1:length(trialsList)
       
    file=importdata([resultsPath filesep trialsList{k} filesep filename]);
    
    if nargin>4
        
        coord_idx=findIndexes(file.colheaders,Yquantities);
    else
        Yquantities=file.colheaders(2:end); %take all columns except time
        coord_idx=[2:size(file.colheaders,2)];
    end
     
    
    results=file.data;
        
    for j =1: length(coord_idx)
        
        coordCol=coord_idx(j);
        
        y{k,j} = results(:,coordCol);
        
    end
        
    timeVector{k}=getXaxis(x, results);
    
end

if strcmp(filename,'Torques.sto')
    figurePath=[resultsPath filesep 'Figures' filesep 'Torques' filesep];
else
    figurePath=[resultsPath filesep 'Figures' filesep];
end

if exist(figurePath,'dir') ~= 7
    mkdir(figurePath);
end

%Save data in mat format
save([figurePath, 'plottedData'], 'y')

plotLabels=regexprep(Yquantities, '_', ' ');
legendLabels=regexprep(trialsList, '_', ' ');
cmap = colormap(hsv(128));
%plotTitle = filename;

for k=1:size(y,1)
    
    plotColor = cmap(round(1+5.5*(k-1)),:);
    
    for j=1:size(y,2)
        
        h(j)=figure(j);
        
        plot(timeVector{k}, y{k,j},'Color',plotColor)
        hold on
        
        xlabel(x)
        ylabel([plotLabels(j)])
        warning off
        legend(legendLabels)
        %title(filename)
        
        saveas(h(j),[figurePath  Yquantities{j} '.fig'])
    end
end
