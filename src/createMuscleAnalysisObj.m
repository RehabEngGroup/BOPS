function maObj = createMuscleAnalysisObj (initial_time, final_time)
% Function to initialize a Muscle Analysis object for the Analyze Tool
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*

ma= MuscleAnalysis();

ma.setOn(true);
ma.setStepInterval(1)
ma.setInDegrees(true)

ma.setStartTime(initial_time);
ma.setEndTime(final_time);

%IMPORTANT NOTE:
%setComputeMoments does not work!!!necessary to load a XML template with 
%this value set to true
ma.setComputeMoments(true); 

