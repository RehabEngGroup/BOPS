function xVector=getXaxis(xaxislabel, Yvector)

% This file is part of Batch OpenSim Processing Scripts (BOPS).
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
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>


%%
    
switch xaxislabel
    
    case {'time'}
        
        xVector = Yvector(:,1);
        
    case {'% Stance','% Gait Cycle', '% time', '% Analysis Window'}
        
        xVector=[0:size(Yvector(:,1),1)-1]/(size(Yvector(:,1),1)-1)*100;
        
    otherwise
        error(['Case for the x_axis: ' xaxislabel ' not defined!Add it in plotIKresult.m']);
        
end