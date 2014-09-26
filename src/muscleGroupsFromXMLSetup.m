function [musclesGroups]=muscleGroupsFromXMLSetup(plotSetupFile)

plotsetting=xml_read(plotSetupFile);

nGroups=size(plotsetting.MuscleGroups.Group,2);

for k=1:nGroups
    
    musclesGroups{k}.name=plotsetting.MuscleGroups.Group(k).Name;
    
    nGroupMuscle=size(plotsetting.MuscleGroups.Group(k).MuscleList.Muscle,2);
    
    if iscell(plotsetting.MuscleGroups.Group(k).MuscleList.Muscle)==1
        for i=1:nGroupMuscle          
            musclesGroups{k}.muscle{i}=plotsetting.MuscleGroups.Group(k).MuscleList.Muscle{i};
        end
    else
        musclesGroups{k}.muscle={plotsetting.MuscleGroups.Group(k).MuscleList.Muscle};
    end
end
