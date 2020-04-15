function []=plotProcessingResults(filesPath,filename,xaxislabel, Yquantities, varargin)
% Function to plot IK results

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

for k=1:length(filesPath)
    
    if strcmp(filename,'Torques.sto')
        figurePath=[filesPath{k} filesep 'Figures' filesep 'Torques' filesep];
    else        
        figurePath=[filesPath{k} filesep 'Figures' filesep];
    end
    
    if exist(figurePath,'dir') ~= 7
        mkdir(figurePath);
    end
    
    
    file=importdata([filesPath{k} filesep filename]);
    filenameTitle=regexprep(filename, '_', ' ');
    
    if nargin>3
        
        coord_idx=findIndexes(file.colheaders,Yquantities);
    else
        Yquantities=file.colheaders(2:end); %take all columns except time
        coord_idx=[2:size(file.colheaders,2)];
    end
        
     plotLabels=regexprep(Yquantities, '_', ' ');
    
    results=file.data;
    
    timeVector=getXaxis(xaxislabel, results);
    
    
    for j =1: length(coord_idx)
        
        coordCol=coord_idx(j);
        
        y = results(:,coordCol);
              
        h=figure(j);
        hold on
        
        plot(timeVector, y);
        title(filenameTitle)
        hold off
        
        xlabel(xaxislabel)
        ylabel(plotLabels(j))
        
        saveas(h,[figurePath file.colheaders{coordCol} '.fig'])
        close(h)
        
    end
    
    fprintf(['Plotting results: ' filename '\n']);
end