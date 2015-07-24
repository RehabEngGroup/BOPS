%function [IDid, IDTemplateXml, inputTrials, varargout] = IDinput(trialsList, varargin)
function [IDid, IDTemplateXml, IKresultsDir, fcut_coordinates, inputTrials, varargout] = IDinput()
% Function asking input for IK 
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
%Get processing identifier 
dialogText = 'Select a processing identifier for the ID';
IDid = char(inputdlg(sprintf(dialogText)));

%Get template for the XML setup file
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','IDProcessing') filesep];   
cd(originalPath)

[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select ID template');

IDTemplateXml = [pathname filename]; 

%Get folder with Inverse Kinematics results to use for ID
IKresultsDir = uigetdir(' ', 'Select folder with INVERSE KINEMATICS results to use');

%OPTIONAL:

if nargout>3
    
    %1-definition of lowpass frequency cut off for filtering coordinates
    num_lines = 1;
    options.Resize='on';
    options.WindowStyle='modal';
    defValue{1}='6';
    
    dlg_title='Choose the low-pass cut-off frequency for filtering the coordinates_file data ';
    prompt ='lowpass_cutoff_frequency_for_coordinates (-1 disable filtering)';
    
    
    answer = inputdlg(prompt,dlg_title,num_lines,defValue,options);
    
    fcut_coordinates=str2num(answer{1});
    
    
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
    
    if nargout == 5
        
        %%Selection of trials to elaborate from the list
        
        [trialsIndex,v] = listdlg('PromptString','Select trials to elaborate:',...
            'SelectionMode','multiple',...
            'ListString',IKmotList);
        
        inputTrials=IKmotList(trialsIndex);
    else
        inputTrials=dirList;
    end
end
