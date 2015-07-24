function []=plotProcessingResults(filesPath,filename,xaxislabel, Yquantities, varargin)
% Function to plot IK results
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

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
        title(filename)
        hold off
        
        xlabel(xaxislabel)
        ylabel(plotLabels(j))
        
        saveas(h,[figurePath file.colheaders{coordCol} '.fig'])
        close(h)
        
    end
    
    fprintf(['Plotting results: ' filename '\n']);
end