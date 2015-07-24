function xVector=getXaxis(xaxislabel, Yvector)

    
switch xaxislabel
    
    case {'time'}
        
        xVector = Yvector(:,1);
        
    case {'% Stance','% Gait Cycle', '% time', '% Analysis Window'}
        
        xVector=[0:size(Yvector(:,1),1)-1]/(size(Yvector(:,1),1)-1)*100;
        
    otherwise
        error(['Case for the x_axis: ' xaxislabel ' not defined!Add it in plotIKresult.m']);
        
end