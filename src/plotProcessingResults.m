function []=plotProcessingResults(filesPath,filename,Yquantities,Xlabel)
% Function to plot IK results
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

for k=1:length(filesPath)
    
    
    figurePath=[filesPath{k} filesep 'Figures' filesep];
    
    if exist(figurePath,'dir') ~= 7
        mkdir(figurePath);
    end
    
    plotLabels=regexprep(Yquantities, '_', ' ');
    
    file=importdata([filesPath{k} filesep filename]);
    
    coord_idx=findIndexes(file.colheaders,Yquantities);
    
    results=file.data;
    
    switch Xlabel
        case 'time'
            
            timeVector = results(:,1);
            
        case {'% stance','% gait cycle', '% time', '% Analysis Window'}
            
            timeVector=[1:size(results(:,1),1)]/size(results(:,1),1)*100;
            
        otherwise
            error(['Case for the x_axis: ' Xlabel ' not defined!Add it in plotIKresult.m']);
            
    end
    
    for j =1: length(coord_idx)
        
        coordCol=coord_idx(j);
        
        y = results(:,coordCol);
              
        h=figure(j);
        hold on
        
        plot(timeVector, y);
        title(filename)
        hold off
        
        xlabel(Xlabel)
        ylabel(plotLabels(j))
        
        saveas(h,[figurePath file.colheaders{coordCol} '.fig'])
        close(h)
        
    end
    
    fprintf(['Plotting results: ' filename '\n']);
end