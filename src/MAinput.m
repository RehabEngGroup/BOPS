function [MAid, XMLsetupTemplate, IKresultsDir, inputTrials, fcut_coordinates, varargout] = MAinput()
% Function asking input for MA 
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
%Get processing identifier 
dialogText = 'Select a processing identifier for the Muscle Analysis';
MAid = char(inputdlg(sprintf(dialogText)));


%Get template for the XML setup file
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','MuscleAnalysis') filesep];
cd(originalPath)

[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select XML Template for the setup file');

XMLsetupTemplate = [pathname filename];

%OPTIONAL:

if nargout>2
    
    %Get folder with Inverse Kinematics results
    IKresultsDir = uigetdir(' ', 'Select folder with INVERSE KINEMATICS results to use');
    
    %2-selection of trials to be processed
    [dirList] = trialsListGeneration(IKresultsDir);
    
    %Removing folder called 'Figures' from the list
    findInd= strfind(dirList, 'Figures');
    j=1;
    for k=1:length(dirList)
        
        if  isempty(findInd{k})
            IKmotList{j}=dirList{k};
            j=j+1;
        end
    end
    
    if nargout>3
        
        %%Selection of trials to elaborate from the list
        
        [trialsIndex,v] = listdlg('PromptString','Select trials to elaborate:',...
            'SelectionMode','multiple',...
            'ListString',IKmotList);
        
        inputTrials=IKmotList(trialsIndex);
    else
        inputTrials=dirList;
    end
    
    if nargout == 5   %vary rare: it can be found in the XML Template or usually already filtered in IK and ID
        
        %1-definition of lowpass frequency cut off for filtering coordinates
        num_lines = 1;
        options.Resize='on';
        options.WindowStyle='modal';
        defValue{1}='6';
        
        dlg_title='Choose the low-pass cut-off frequency for filtering the coordinates_file data ';
        prompt ='lowpass_cutoff_frequency_for_coordinates (-1 disable filtering)';
        
        
        answer = inputdlg(prompt,dlg_title,num_lines,defValue,options);
        
        fcut_coordinates=str2num(answer{1});
        
    end
end
