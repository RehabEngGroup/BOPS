function [data, dataLabels] = loadDataFromSto(stoFilePaths, stoFileName)

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
