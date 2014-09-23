function soObj = createStaticOptimizationObj (initial_time, final_time)
% Function to initialize a Static Optimization object for the Analyze Tool
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
import org.opensim.modeling.*

soObj= StaticOptimization();

soObj.setOn(true);
soObj.setStartTime(initial_time);
soObj.setEndTime(final_time);

soObj.setStepInterval(1)
soObj.setInDegrees(true)
soObj.setUseModelForceSet(true)
soObj.setActivationExponent(2)
soObj.setUseMusclePhysiology(true)
soObj.setConvergenceCriterion(0.0001)
soObj.setMaxIterations(100)
