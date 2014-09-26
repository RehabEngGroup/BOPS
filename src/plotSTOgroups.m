function []=plotSTOgroups(filesPath,filesname,stoFilesType, musclesGroups,xaxislabel)

nTrials=size(filesPath,2);
nSTOfiles=size(filesname,2);
stoFilesTypeTitle=regexprep(stoFilesType, '_', ' ');

lineStyle={'-', '--', ':', '-.', '+', 'o', '*', '.', 'x', 's', 'd', 'v', '^', '>','<','p','h'};
color={'b', 'r','g', 'c', 'm','y','k'};


for k=1:nTrials
    
    
    for i=1:nSTOfiles
        
        figurePath=[filesPath{k} filesep 'Figures' filesep stoFilesType{i} filesep];
        
        if exist(figurePath,'dir') ~= 7
            mkdir(figurePath);
        end
        
        file=importdata([filesPath{k} filesep filesname{i}]);
        
        results=file.data;
        
        switch xaxislabel
            case 'time'
                
                timeVector = results(:,1);
                
            case {'% Stance','% Gait Cycle', '% time', '% Analysis Window'}
                
                timeVector=[1:size(results(:,1),1)]/size(results(:,1),1)*100;
                
            otherwise
                error(['Case for the x_axis: ' xaxislabel ' not defined!Add it in plotIKresult.m']);
                
        end
        
        nMuscleGroups=size(musclesGroups,2);
        
        for m=1:nMuscleGroups
            
            Yquantities=musclesGroups{m}.muscle;
            YquantitiesLabel=regexprep(Yquantities, '_', ' ');
            
            nMuscles=size(Yquantities,2);
            
            if isfield(file,'colheaders')
                coord_idx=findIndexes(file.colheaders,Yquantities);
            else
                strheaders=file.textdata{end};
                colheaders=str_sep(strheaders);
                coord_idx=findIndexes(colheaders,Yquantities);
            end
            
            h=figure(m);
            hold on
            icolor=1;
            iline=1;
            save_to_base(1)
            for j =1: nMuscles
                
                coordCol=coord_idx(j);
                
                y = results(:,coordCol);
                
                plot(timeVector, y, strcat(lineStyle{iline},color{icolor}));
                title(stoFilesTypeTitle{i})
   
                if icolor==size(color,2)
                    icolor=1;
                    iline=iline+1;
                else
                    icolor=icolor+1;
                end
                
                xlabel(xaxislabel)
                %ylabel(plotLabels(j))
                warning off
                legend(YquantitiesLabel)
                
                
            end
            
            saveas(h,[figurePath musclesGroups{m}.name '.fig'])    
            close(h)
        end
    end
end