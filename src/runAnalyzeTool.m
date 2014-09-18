function []= runAnalyzeTool(setupFiledir, setupFile)
% Function to run the analyze tool
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

%Run Analyze Tool
matlabdir=pwd;
cd(setupFiledir)
dos(['analyze -S ',setupFile]);
cd(matlabdir);