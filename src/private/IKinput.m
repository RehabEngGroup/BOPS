function [IKid, IKTemplateXml, inputTrials, varargout] = IKinput(trialsList, varargin)
% Function asking input for IK 

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
%Get template for the XML setup file
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','IKProcessing') filesep];
cd(originalPath)

global selections

if selections.LoadTemplateIK == 1

originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','IKProcessing') filesep];   
cd(originalPath)
dialogText = 'Select a processing identifier for the IK';
IKid = char(inputdlg(sprintf(dialogText)));

[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select IK template');

IKTemplateXml = [pathname filename]; 
else
   IKTemplateXml = [TemplatePath char(selections.TamplateListIK)];
   IKid = '';
end
   

%%Selection of trials to elaborate from the list
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

