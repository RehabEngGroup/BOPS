function []=createXMLPlotTemplateFromModel(osim_file, path)
%Function to create the XML Template required by the PlotStorage.m function
%(which plots results stored in .sto files). 
%This template allows to define groups for the muscles in the .osim model:
%results from muscles belonging to the same group will be plotted in the
%same figure.
%
%Inputs
%osim_file: full path + name of the .osim model
%path: where to store the output XML template file
%
%Output
%a XML template with a single group including all muscles of the
%input model. Starting from this file, users can define their own muscle
%groups to plot the results with the PlotStorage.m function.

% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*;

osimModel=Model(osim_file);

musclesList = getMTActuatorsFromModel(osim_file);

for m=1:size(musclesList,2)
   
    MuscleList.Muscle{m}=musclesList{m};
end


plotSetting.ID='Template';

plotSetting.osimModelName=osimModel.getName();

plotSetting.MuscleGroups.Group.Name='all';

plotSetting.MuscleGroups.Group.MuscleList=MuscleList;

Pref.CellItem=false;
Pref.StructItem=false;  %to not have arrays of structs with 'item' notation
Pref.ItemName='Muscle';
xml_write([path filesep 'plotSetup_Template_' char(plotSetting.osimModelName) '.xml'],plotSetting,'plotSetting',Pref);