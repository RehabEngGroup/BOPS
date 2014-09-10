% Main script for IK
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

[inputDir, model_file]=processingInput();

[ikID, IKTemplateXml] = IKinput();

runInverseKinematics(inputDir,model_file, ikID, IKTemplateXml)
