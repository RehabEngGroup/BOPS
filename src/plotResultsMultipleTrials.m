function []=plotResultsMultipleTrials(resultsPath, trialsList, filename,x, Yquantities, varargin)
% Function to plot results from multiple trials
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

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
