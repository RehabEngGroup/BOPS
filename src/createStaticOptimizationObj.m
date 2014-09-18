function soObj = createStaticOptimizationObj (initial_time, final_time)

%soObj= StaticOptimization(osimModel);
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
