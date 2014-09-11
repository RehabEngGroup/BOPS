function []=plotResultsTogheter(resultsPath, trialsList, filename, Yquantities,x)
% Function to plot results from all trials
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

%Load data
for k=1:length(trialsList)
       
    file=importdata([resultsPath trialsList{k} filesep filename]);
    coord_idx=findIndexes(file.colheaders,Yquantities);    
    
    results=file.data;
        
    for j =1: length(coord_idx)
        
        coordCol=coord_idx(j);
        
        y{k,j} = results(:,coordCol);
        
    end
        
    
    switch x
        case 'time'
            
            timeVector{k} = results(:,1);
            
        case {'% stance','% gait cycle', '% time', '% Analysis Window'}
            
            timeVector{k}=[1:size(results(:,1),1)]/size(results(:,1),1)*100;
            
        otherwise
            error(['Case for the x_axis: ' x ' not defined!Add it in plotIKresult.m']);
            
    end
    
end


figurePath=[resultsPath 'Figures\'];

if exist(figurePath,'dir') ~= 7
    mkdir(figurePath);
end

%Save data in mat format
save([figurePath, 'plottedData'], 'y')

plotLabels=regexprep(Yquantities, '_', ' ');
cmap = colormap(hsv);
%plotTitle = filename;

for k=1:size(y,1)
    
    plotColor = cmap(round(1+6.5*(k-1)),:);
    
    for j=1:size(y,2)
        
        h(j)=figure(j);
        
        plot(timeVector{k}, y{k,j},'Color',plotColor)
        hold on
        
        xlabel(x)
        ylabel([plotLabels(j)])
        warning off
        legend(trialsList)
        %title(filename)
        
        saveas(h(j),[figurePath  Yquantities{j} '.fig'])
    end
end
