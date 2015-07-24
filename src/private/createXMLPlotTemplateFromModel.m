function []=createXMLPlotTemplateFromModel(osim_file, path)

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