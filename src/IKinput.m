function [ikID, IKTemplateXml] = IKinput()
% Function asking input for IK 
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
%Get processing identifier 
dialogText = 'Select a processing identifier for the IK';
ikID = char(inputdlg(sprintf(dialogText)));

%Get template for the XML setup file
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','IKProcessing') filesep];   
cd(originalPath)

[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select IK template');

IKTemplateXml = [pathname filename]; 
