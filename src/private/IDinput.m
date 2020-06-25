function [IDid, IDTemplateXml, fcut_coordinates, inputTrials, IKresultsDir, varargout] = IDinput(trialsList, varargin)
% Function asking input for ID 

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
% Author(s): Alice Mantoan,     <ali.mantoan@gmail.com>
%            Monica Reggiani,   <monica.reggiani@gmail.com>
%            Bruno Bedo,        <bruno.bedo@usp.rb>
%            Danilo S. Catelli, <danilo.catelli@uottawa.ca>
%            William Cruaud,    <w.cruaud@hotmail.fr>
%            Mario Lamontagne,  <mlamon@uottawa.ca>



%%

%Get processing identifier
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','IDProcessing') filesep];   
cd(originalPath)

global selections
if selections.LoadTemplateID ==1
dialogText = 'Select a processing identifier for the ID';
IDid = char(inputdlg(sprintf(dialogText)));

%Get template for the XML setup file
[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select ID template');

IDTemplateXml = [pathname filename]; 
else
   IDTemplateXml = [TemplatePath char(selections.TamplateListID)];
   IDid = '';
end

% %Definition of lowpass frequency cut off for filtering coordinates
if  selections.IDLowPass == 0
    num_lines = 1;
    options.Resize='on';
    options.WindowStyle='modal';
    defValue{1}='6';

    dlg_title='Choose the low-pass cut-off frequency for filtering the coordinates_file data ';
    prompt ='lowpass_cutoff_frequency_for_coordinates (-1 disable filtering)';

    answer = inputdlg(prompt,dlg_title,num_lines,defValue,options);

    fcut_coordinates=str2num(answer{1});
else
    fcut_coordinates = selections.IDLowPass;
end

%OPTIONAL:

if nargout>3
        if isempty(selections.ListTrials)
        [IKid, IKTemplateXml,inputTrials] = IKinput(trialsList);
        if nargin ==1
            [trialsIndex,v] = listdlg('PromptString','Select trials to elaborate:',...
                'SelectionMode','multiple',...
                'ListString',trialsList);

            inputTrials=trialsList(trialsIndex);
        end
        else
        inputTrials = trialsList(selections.ListTrials);
        end    
%     if nargin
%         [trialsIndex,v] = listdlg('PromptString','Select trials to elaborate:',...
%             'SelectionMode','multiple',...
%             'ListString',trialsList);
%         
%         inputTrials=trialsList(trialsIndex);
%     else
%         error('ErrorTests:convertTest', ...
%             ['----------------------------------------------------------------\nWARNING: Wrong call of IDinput(): list of trials required as input. \nOtherwise, please limit the output to three \n----------------------------------------------------------------'])
%     end
    
     if nargout == 5   %Get folder with Inverse Kinematics results to use for ID
         
         IKresultsDir = uigetdir(' ', 'Select folder with INVERSE KINEMATICS results to use');
     end
end

