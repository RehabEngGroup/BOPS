% This file is part of Batch OpenSim Processing Scripts (BOPS).
%
% Copyright (C) 2020 Bruno Bedo, Danilo Catelli, William Cruaud, Mario Lamontagne
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
% Author(s): Bruno Bedo,        <bruno.bedo@usp.rb>
%            Danilo S. Catelli, <danilo.catelli@uottawa.ca>
%            William Cruaud,    <w.cruaud@hotmail.fr>

global selections
%% input dir
if  isempty(selections.SOpathRes)
resultsDir = uigetdir(' ', 'Select your results folder');
else
   resultsDir = selections.SOpathRes;
   resultsDir = strrep(resultsDir,'staticOptimization','Joint_Reaction');   
end

%Get trials in the input folder
if isempty(selections.ListTrials)
trialsList = trialsListGeneration(resultsDir);
inputTrials=trialsList;
else
    trialsList = selections.trials(selections.ListTrials);
    inputTrials = selections.trials(selections.ListTrials);
end

%definition of the output folder for each trial
for k=1:length(trialsList)  
    trialsResultsDir{k}=[resultsDir inputTrials{k}];
end

for i = 1:size(trialsResultsDir,2) 
    mfold = char(trialsResultsDir{i}); 
    tr = char(inputTrials{i});
    
    fulltrl = [mfold filesep tr, '_JointReaction_ReactionLoads.sto'];
    
    hedrs = ImportJRAHeader(fulltrl);
    hedrs = hedrs(1,:)';
    fdata = ImportJRAData(fulltrl);
    
    if i == 1
    if selections.plotJRA == 1
        nplots = find(~cellfun(@isempty,hedrs)); 
        lititle = hedrs(nplots);
        [namehedrs,v] = listdlg('PromptString','Select the variables:',...
        'ListString',lititle); 
    elseif selections.plotALLJRA == 1
        nplots = find(~cellfun(@isempty,hedrs)); 
        namehedrs = [1:size(nplots,1)]; 
    end
    end
    
%Creating figures
    for w = 1:size(namehedrs,2)
        fr = [0:100]';
        datplt = fdata(:,namehedrs(w));
        titplt = char(hedrs(namehedrs(w)));
        titplt = strrep(titplt,'_',' ');
        xlb = char(selections.XAxis);
        f{w} = figure(w);
        plot(fr,timenormalize(datplt,1,size(datplt,1),101),'k')
        xlabel(xlb)
        title(titplt)
        legend(inputTrials{i})
        
%Saving
        figurePath=[mfold filesep 'Figures' filesep];
        
        if exist(figurePath,'dir') ~= 7
            mkdir(figurePath);
        end
        saveas(f{w},[figurePath char(hedrs(namehedrs(w))) '.fig'])
    end
close all
end


