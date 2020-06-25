%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 BOPS                                    %
%                    BATCH OPENSIM PROCESSING SCRIPTS                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BOPS GUI main file.

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
% Author(s): Alice Mantoan,     <ali.mantoan@gmail.com>
%            Monica Reggiani,   <monica.reggiani@gmail.com>
%            Bruno Bedo,        <bruno.bedo@usp.rb>
%            Danilo S. Catelli, <danilo.catelli@uottawa.ca>
%            William Cruaud,    <w.cruaud@hotmail.fr>
%            Mario Lamontagne,  <mlamon@uottawa.ca>

function varargout = BOPSgui(varargin)
% BOPSgui MATLAB code for BOPSgui.fig
%      BOPSgui, by itself, creates a new BOPSgui or raises the existing
%      singleton*.
%
%      H = BOPSgui returns the handle to a new BOPSgui or the handle to
%      the existing singleton*.
%
%      BOPSgui('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOPSgui.M with the given input arguments.
%
%      BOPSgui('Property','Value',...) creates a new BOPSgui or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BOPSgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BOPSgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BOPSgui

% Last Modified by GUIDE v2.5 23-Jun-2020 14:26:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BOPSgui_OpeningFcn, ...
                   'gui_OutputFcn',  @BOPSgui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before BOPSgui is made visible.
function BOPSgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BOPSgui (see VARARGIN)

% Choose setDefault command line output for BOPSgui
handles.output = hObject;

%% Get value from GUI (Improvement 09/01/18 by William CRUAUD)
clearvars -global

global selections inputDir model_file

set(handles.runIK,'Value',1);
set(handles.plotResultsIK, 'Enable', 'on')
set(handles.plotResultsIK,'Value',0);
set(handles.plotALLIKResults, 'Enable', 'on')
set(handles.plotALLIKResults,'Value',1);
set(handles.LoadTemplateIK,'Enable','on');
set(handles.TamplateListIK,'Value',5);
set(handles.XAxis,'Value',4);

set(handles.runID,'Value',1);
set(handles.plotResultsID, 'Enable', 'on')
set(handles.IDLowPass,'Value',1);
set(handles.TamplateListID,'Value',1);
set(handles.LoadTemplateSO,'Enable','on');
set(handles.plotALLIDResults, 'Enable', 'on')
set(handles.plotALLIDResults,'Value',1);

set(handles.runSO,'Value',1);
set(handles.plotStorageSO, 'Enable', 'on')
set(handles.SOLowPass,'Value',1);
set(handles.TamplateListSO,'Value',1);
set(handles.LoadTemplateSO,'Enable','on');
set(handles.plotALLSOResults, 'Enable', 'on')
set(handles.plotALLSOResults,'Value',0);
set(handles.SOPlotSetupList,'Value',3);
set(handles.SOPlotSetupList,'Enable','off')

set(handles.ActuatorsList,'Value',1);
set(handles.SOselectplot,'Value',1);
set(handles.SOselectplot,'Enable','off');
set(handles.LoadSOplotsetup,'Enable','off')

set(handles.runJRA,'Value',1);
set(handles.plotStorageJRA,'Enable','on');
set(handles.plotALLJRAResults,'Enable','on');
set(handles.plotALLJRAResults,'Value',0);
set(handles.JRALowPass,'Value',1);

selections.runIK=get(handles.runIK,'Value');
selections.plotIK=get(handles.plotResultsIK,'Value');
selections.plotALLIK=get(handles.plotALLIKResults,'Value');
selections.LoadTemplateIK = get(handles.LoadTemplateIK,'Value');
selections.TamplateListIK = handles.TamplateListIK.String(handles.TamplateListIK.Value);
selections.XAxis = handles.XAxis.String(handles.XAxis.Value);

selections.runMA=get(handles.runMA,'Value');
selections.plotMA=get(handles.plotStorageMA,'Value');
selections.selectTrialsMA=get(handles.selectTrialsMA,'Value');
selections.selectXaxisMA=get(handles.selectXaxisMA,'Value');

selections.runID=get(handles.runID,'Value');
selections.plotID=get(handles.plotResultsID,'Value');
selections.plotALLID=get(handles.plotALLIDResults,'Value');
selections.selectTrialsID=get(handles.selectTrialsID,'Value');
selections.selectCoordinatesToPlotID=get(handles.selectCoordinatesToPlotID,'Value');
selections.IDLowPass= str2double(handles.IDLowPass.String);
selections.LoadTemplateID = get(handles.LoadTemplateID,'Value');
selections.TamplateListID = handles.TamplateListID.String(handles.TamplateListID.Value);

selections.runSO=get(handles.runSO,'Value');
selections.plotSO=get(handles.plotStorageSO,'Value');
selections.plotALLSO=get(handles.plotALLSOResults,'Value');
selections.SOLowPass=str2double(handles.SOLowPass.String);
selections.TamplateListSO=handles.TamplateListSO.String(handles.TamplateListSO.Value);
selections.LoadTemplateSO = get(handles.LoadTemplateSO,'Value');
selections.ActuatorsList=handles.ActuatorsList.String(handles.ActuatorsList.Value);
selections.LoadActuadors = get(handles.LoadActuadors,'Value');
selections.SOPlotSetupList=handles.SOPlotSetupList.String(handles.SOPlotSetupList.Value);
selections.selectTrialsSO=get(handles.selectTrialsSO,'Value');
selections.selectXaxisSO=get(handles.selectXaxisSO,'Value');
selections.SOselectplot=handles.SOselectplot.String(handles.SOselectplot.Value);

selections.runJRA = get(handles.runJRA,'Value');
selections.plotJRA=get(handles.plotStorageJRA,'Value');
selections.plotALLJRA=get(handles.plotALLJRAResults,'Value');
selections.LoadTemplateJRA = get(handles.LoadTemplateJRA,'Value');
selections.TamplateListJRF = handles.TamplateListJRF.String(handles.TamplateListJRF.Value);
selections.JRALowPass = str2double(handles.JRALowPass.String);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BOPSgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = BOPSgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get setDefault command line output from handles structure
varargout{1} = handles.output;



function loadedInputFolder_Callback(hObject, eventdata, handles)
% hObject    handle to loadedInputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loadedInputFolder as text
%        str2double(get(hObject,'String')) returns contents of loadedInputFolder as a double


% --- Executes during object creation, after setting all properties.
function loadedInputFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadedInputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lodedModel_Callback(hObject, eventdata, handles)
% hObject    handle to lodedModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lodedModel as text
%        str2double(get(hObject,'String')) returns contents of lodedModel as a double


% --- Executes during object creation, after setting all properties.
function lodedModel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lodedModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectProcessingConfiguration.
function selectProcessingConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to selectProcessingConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global inputDir model_file

[inputDir, model_file]=processingConfiguration();
%handles.inputDir=inputDir;
%handles.model_file=model_file;
set(handles.loadedInputFolder, 'String', inputDir);
set(handles.lodedModel, 'String', model_file);

tna = strfind(inputDir,'\');
set(handles.TaskPathName, 'String', inputDir((tna(end)+1):end));
mna = strfind(model_file,'\');
set(handles.ModelPathName, 'String', model_file((mna(end)+1):end));

trialsList = trialsListGeneration(inputDir)';

set(handles.ListTrials,'String',trialsList)
global selections
originalPath=pwd;
cd(inputDir)
cd('..')
selections.SOpathRes = [pwd filesep 'staticOptimization\'];
selections.JRApathRes = [pwd filesep 'Joint_Reaction\'];
selections.trials = trialsList;
cd(originalPath)

% --- Executes on button press in CloseButton.
function CloseButton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(BOPSgui)
clc


% --- Executes on button press in RunButton.
function RunButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global selections inputDir model_file

%% Get value from GUI (Improvement 09/01/18 by William CRUAUD)


selections.runIK=get(handles.runIK,'Value');
selections.plotIK=get(handles.plotResultsIK,'Value');
selections.ListTrials=get(handles.ListTrials,'Value');

selections.runMA=get(handles.runMA,'Value');
selections.plotMA=get(handles.plotStorageMA,'Value');
selections.selectTrialsMA=get(handles.selectTrialsMA,'Value');
selections.selectXaxisMA=get(handles.selectXaxisMA,'Value');

selections.runID=get(handles.runID,'Value');
selections.plotID=get(handles.plotResultsID,'Value');
selections.selectTrialsID=get(handles.selectTrialsID,'Value');
selections.selectCoordinatesToPlotID=get(handles.selectCoordinatesToPlotID,'Value');

selections.runSO=get(handles.runSO,'Value');
selections.plotSO=get(handles.plotStorageSO,'Value');

selections.selectTrialsSO=get(handles.selectTrialsSO,'Value');
selections.selectXaxisSO=get(handles.selectXaxisSO,'Value');

%%
disp(' ')
disp('Running BOPS 2.0')
if selections.runIK == 1
        disp('Running IK ')
elseif selections.runMA == 1
        disp('Running MA ')
elseif selections.runID == 1
        disp('Running ID ')
elseif selections.runSO == 1
        disp('Running SO ')
elseif selections.runJRA == 1
        disp('Running JRA ')
end
disp(' ')


%% IK
if selections.runIK == 1
disp(' ')
disp('Start processing IK:')
disp(' ')
    [IKoutputDir, IKtrialsOutputDir, IKprocessedTrials]=InverseKinematics(inputDir, model_file); 
end

% Plotting IK Results
if selections.plotIK == 1 || selections.plotALLIK == 1
disp(' ')
disp('Plotting IK results')
disp(' ')
    IKmotFilename='ik.mot'; %our default name
    set(handles.figure1, 'HandleVisibility', 'off');
    [coordinates,Xaxislabel]=plotResults('IK', IKoutputDir, IKtrialsOutputDir, model_file, IKprocessedTrials, IKmotFilename);
    set(handles.figure1, 'HandleVisibility', 'on');
end


%% MA

if selections.runMA==1
disp(' ')
disp('Start processing MA:')
disp(' ')
    %when run IK before & want to process the same trials
    if selections.runIK==1 && selections.selectTrialsMA==0
        [MAoutputDir,MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file, IKoutputDir, IKprocessedTrials);
    end
    
    %when run IK before, but MA on different trials
    if  selections.runIK==1 && selections.selectTrialsMA==1
        [MAoutputDir, MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file, IKoutputDir);
    end
    
    %if no IK before:
    if  selections.runIK==0
        [MAoutputDir, MAtrialsOutputDir, MAprocessedTrials]=MuscleAnalysis(inputDir, model_file);
    end
end

% Plot Storage (MA)
if selections.plotMA==1
disp(' ')
disp('Plotting MA results ')
disp(' ')
    set(handles.figure1, 'HandleVisibility', 'off');
    if exist('Xaxislabel','var') && selections.selectXaxisMA==0
        plotStorage(Xaxislabel)
    else
        plotStorage()
        
    end
    set(handles.figure1, 'HandleVisibility', 'on');
end



%% ID

if selections.runID==1
disp(' ')
disp('Start processing ID:')
disp(' ')
    %when run IK before & want to process the same trials
    if selections.runIK==1 && selections.selectTrialsID==0
        [IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir, IKprocessedTrials);
    end
    
    %when run IK before, but ID on different trials
    if selections.runIK==1 && selections.selectTrialsID==1
        [IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file, IKoutputDir);
    end
    
    %if no IK before:
    if  selections.runIK==0
        [IDoutputDir, IDtrialsOutputDir, IDprocessedTrials]=InverseDynamics(inputDir, model_file);
    end
end

% Plotting ID Results
if selections.plotID==1 || selections.plotALLID == 1
disp(' ')
disp('Plotting ID results ')
disp(' ')
    IDfilename='inverse_dynamics.sto';
    set(handles.figure1, 'HandleVisibility', 'off');
    
    if selections.runIK==1
        if exist('coordinates','var') && selections.selectCoordinatesToPlotID==0 && exist('Xaxislabel','var') %same X-axis label
            plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates, Xaxislabel);
        else if exist('coordinates','var') && selections.selectCoordinatesToPlotID==0       %same coordinates, different X axis
                plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename, coordinates); %add "_moment" to coordinates
            else if selections.selectCoordinatesToPlotID==1
                    plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename);
                end
            end
        end
    else  %if no IK before
        plotResults('ID', IDoutputDir, IDtrialsOutputDir, model_file, IDprocessedTrials, IDfilename);
    end
    set(handles.figure1, 'HandleVisibility', 'on');
end

%% SO

if selections.runSO==1
disp(' ')
disp('Start processing SO:')
disp(' ')    
    %when run IK and ID before & want to process the same trials (of ID)
    if selections.runIK==1 && selections.runID==1 && selections.selectTrialsSO==0  
        [SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir, IDprocessedTrials);
    end
    
    %when run IK and ID before, but SO on different trials
    if selections.runIK==1 && selections.runID==1 && selections.selectTrialsSO==1        
        [SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file, IKoutputDir, IDoutputDir);
    end
       
    %if no IK and ID before:
    if  selections.runIK==0 && selections.runID==0 
        [SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file);
    end

    %if just ID before
    if selections.runIK==0 && selections.runID==1
        [SOoutputDir,SOtrialsOutputDir, SOprocessedTrials]=StaticOptimization(inputDir, model_file,IDoutputDir);
    end
end

% Plot Storage (SO)
if selections.plotSO==1 || selections.plotALLSO==1
disp(' ')
disp('Plotting SO results ')
disp(' ')
    set(handles.figure1, 'HandleVisibility', 'off');
    
    if exist('Xaxislabel','var') && selections.selectXaxisSO==0
        plotStorage()
    else
        plotStorage()
    end
    set(handles.figure1, 'HandleVisibility', 'on');
end

%%  JRA
if selections.runJRA ==1
disp(' ')
disp('Start processing JRA:')
disp(' ')
   run JointReactionForce.m
end

% Plot Storage (JRA)
if selections.plotJRA==1 || selections.plotALLJRA==1
disp(' ')
disp('Plotting JRA results ')
disp(' ')
    set(handles.figure1, 'HandleVisibility', 'off');
    
    plotResultsJRA();
    
    set(handles.figure1, 'HandleVisibility', 'on');
end

%% Done
disp(' ')
disp('Done.')
disp(' ')
save_to_base(1)

% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.ModelPathName,'String','')
set(handles.TaskPathName,'String','')
set(handles.runIK,'Value',0);
set(handles.plotResultsIK,'Value',0);
set(handles.plotResultsIK, 'Enable', 'off')
set(handles.LoadTemplateIK,'Enable', 'off')
set(handles.ListTrials,'String','')
set(handles.LoadTemplateIK,'Value',0)
set(handles.plotALLIKResults, 'Enable', 'off')
set(handles.plotALLIKResults,'Value',0)
set(handles.TamplateListIK,'Enable', 'off')


set(handles.runMA,'Value',0);
set(handles.plotStorageMA,'Value',0);
set(handles.plotStorageMA, 'Enable', 'off')
set(handles.selectTrialsMA,'Value',0);
set(handles.selectXaxisMA,'Value',0);

set(handles.runID,'Value',0);
set(handles.plotResultsID,'Value',0);
set(handles.plotResultsID, 'Enable', 'off')
set(handles.selectTrialsID,'Value',0);
set(handles.selectCoordinatesToPlotID,'Value',0);
set(handles.LoadTemplateID,'Value',0)
set(handles.LoadTemplateID,'Enable','off');
set(handles.TamplateListID,'Enable','off');
set(handles.IDLowPass,'String','');
set(handles.IDLowPass,'Enable','off');
set(handles.plotALLIDResults, 'Enable', 'off')
set(handles.plotALLIDResults,'Value',0)


set(handles.runSO,'Value',0);
set(handles.plotStorageSO,'Value',0);
set(handles.plotStorageSO, 'Enable', 'off')
set(handles.selectTrialsSO,'Value',0);
set(handles.selectXaxisSO,'Value',0);
set(handles.SOLowPass,'Value',0);
set(handles.SOLowPass,'String','')
set(handles.TamplateListSO,'Enable','off')
set(handles.LoadTemplateSO,'Value',0)
set(handles.LoadTemplateSO,'Enable','off')
set(handles.plotALLSOResults,'Enable','off')
set(handles.plotALLSOResults,'Value',0)
set(handles.SOLowPass,'Enable','off')
set(handles.SOLowPass,'String',' ')
set(handles.ActuatorsList,'Enable','off')
set(handles.LoadActuadors,'Value',0)
set(handles.LoadActuadors,'Enable','off')
set(handles.SOPlotSetupList,'Enable','off')
set(handles.LoadSOplotsetup,'Enable','off')
set(handles.LoadSOplotsetup,'Value',0)
set(handles.SOselectplot,'Enable','off')

set(handles.runJRA,'Value',0)
set(handles.TamplateListJRF,'Enable','off')
set(handles.LoadTemplateJRA,'Enable','off')
set(handles.LoadTemplateJRA,'Value',0)
set(handles.plotStorageJRA,'Enable','off')
set(handles.plotStorageJRA,'Value',0)
set(handles.plotALLJRAResults,'Enable','off')
set(handles.plotALLJRAResults,'Value',0)
set(handles.JRALowPass,'Enable','off')
set(handles.JRALowPass,'String','')

global selections

selections.runIK=0;
selections.plotIK=0;
selections.plotALLIK=0;
selections.LoadTemplateIK=0;

selections.runMA=0;
selections.plotMA=0;
selections.selectTrialsMA=0;
selections.selectXaxisMA=0;

selections.runID=0;
selections.plotALLID=0;
selections.selectTrialsID=0;
selections.selectCoordinatesToPlotID=0;
selections.IDLowPass=0;
selections.LoadTemplateID=0;
selections.plotALLID=0;

selections.runSO=0;
selections.plotSO=0;
selections.plotALLSO=0;
selections.selectTrialsSO=0;
selections.selectXaxisSO=0;
selections.SOLowPass=0;
selections.SOPlotSetupList=0;

selections.runJRA=0;
selections.plotJRA=0;
selections.plotALLJRA=0;
selections.JRALowPass=0;



% --- Executes on button press in setDefault.
function setDefault_Callback(hObject, eventdata, handles)
% hObject    handle to setDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.ModelPathName,'String','')
set(handles.TaskPathName,'String','')
set(handles.ListTrials,'String', '')
set(handles.runIK,'Value',1);
set(handles.plotResultsIK, 'Enable', 'on')
set(handles.plotResultsIK,'Value',0);
set(handles.LoadTemplateIK, 'Enable', 'on')
set(handles.LoadTemplateIK,'Value',0);
set(handles.plotALLIKResults, 'Enable', 'on')
set(handles.plotALLIKResults,'Value',1);
set(handles.TamplateListIK,'Enable','on');

set(handles.runMA,'Value',0);
set(handles.plotStorageMA, 'Enable', 'off')
set(handles.plotStorageMA,'Value',0);
set(handles.selectTrialsMA,'Value',0);
set(handles.selectXaxisMA,'Value',0);

set(handles.runID,'Value',1);
set(handles.plotResultsID, 'Enable', 'on')
set(handles.plotResultsID,'Value',0);
set(handles.selectTrialsID,'Value',0);
set(handles.selectCoordinatesToPlotID,'Value',0);
set(handles.IDLowPass,'Value',1);
set(handles.IDLowPass,'String','6');
set(handles.IDLowPass,'Enable', 'on')
set(handles.plotALLIDResults, 'Enable', 'on')
set(handles.plotALLIDResults,'Value',1);
set(handles.TamplateListID,'Enable','on'); 
set(handles.LoadTemplateID,'Enable','on');

set(handles.runSO,'Value',1);
set(handles.plotStorageSO,'Enable', 'on')
set(handles.plotStorageSO,'Value',0);
set(handles.selectTrialsSO,'Value',0);
set(handles.selectXaxisSO,'Value',0);
set(handles.SOLowPass,'Value',1);
set(handles.SOLowPass,'String','6');
set(handles.SOLowPass,'Enable', 'on')
set(handles.TamplateListSO,'Enable','on')
set(handles.LoadTemplateSO,'Enable','on')
set(handles.LoadTemplateSO,'Value',0)
set(handles.ActuatorsList,'Enable','on')
set(handles.LoadActuadors,'Enable','on')
set(handles.LoadActuadors,'Enable','on')
set(handles.plotALLSOResults,'Enable','on')
set(handles.plotALLSOResults,'Value',0)
set(handles.SOPlotSetupList,'Enable','off')
set(handles.LoadSOplotsetup,'Enable','off')
set(handles.LoadSOplotsetup,'Value',0)
set(handles.SOselectplot,'Enable','off');


set(handles.runJRA,'Enable','on')
set(handles.runJRA,'Value',1)
set(handles.TamplateListJRF,'Enable','on')
set(handles.LoadTemplateJRA,'Enable','on')
set(handles.LoadTemplateJRA,'Value',0)
set(handles.plotStorageJRA,'Enable','on')
set(handles.plotStorageJRA,'Value',0)
set(handles.plotALLJRAResults,'Enable','on')
set(handles.plotALLJRAResults,'Value',0)
set(handles.JRALowPass,'Enable','on')
set(handles.JRALowPass,'String','-1');

global selections

selections.runIK=get(handles.runIK,'Value');
selections.TamplateListIK = handles.TamplateListIK.String(handles.TamplateListIK.Value);
selections.plotIK=get(handles.plotResultsIK,'Value');
selections.plotALLIK=get(handles.plotALLIKResults,'Value');

selections.runMA=get(handles.runMA,'Value');
selections.plotMA=get(handles.plotStorageMA,'Value');
selections.selectTrialsMA=get(handles.selectTrialsMA,'Value');
selections.selectXaxisMA=get(handles.selectXaxisMA,'Value');

selections.runID=get(handles.runMA,'Value');
selections.TamplateListID = handles.TamplateListID.String(handles.TamplateListID.Value);
selections.plotID=get(handles.plotResultsID,'Value');
selections.selectTrialsID=get(handles.selectTrialsID,'Value');
selections.selectCoordinatesToPlotID=get(handles.selectCoordinatesToPlotID,'Value');
selections.IDLowPass=str2double(get(handles.IDLowPass,'String'));
selections.plotALLID=get(handles.plotALLIDResults,'Value');

selections.runSO=get(handles.runSO,'Value');
selections.plotSO=get(handles.plotStorageSO,'Value');
selections.plotALLSO=get(handles.plotALLSOResults,'Value');
selections.selectTrialsSO=get(handles.selectTrialsSO,'Value');
selections.selectXaxisSO=get(handles.selectXaxisSO,'Value');
selections.SOLowPass=str2double(get(handles.SOLowPass,'String'));
selections.SOPlotSetupList=handles.SOPlotSetupList.String(handles.SOPlotSetupList.Value);
selections.LoadSOplotsetup=get(handles.LoadSOplotsetup,'Value');
selections.SOselectplot=handles.SOselectplot.String(handles.SOselectplot.Value);

selections.runJRA=get(handles.runJRA,'Value');
selections.plotJRA=get(handles.plotStorageJRA,'Value');
selections.plotALLJRA=get(handles.plotALLJRAResults,'Value');
selections.TamplateListJRF=handles.TamplateListJRF.String(handles.TamplateListJRF.Value);
selections.LoadTemplateJRA=get(handles.LoadTemplateJRA,'Value');
selections.JRALowPass  = str2double(handles.JRALowPass.String);


% --- Executes on button press in runIK.
function runIK_Callback(hObject, eventdata, handles)
% hObject    handle to runIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runIK

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.runIK = 1;
    set(handles.plotResultsIK, 'Enable', 'on')
    set(handles.LoadTemplateIK, 'Enable', 'on')
    set(handles.TamplateListIK, 'Enable', 'on')
    set(handles.plotALLIKResults, 'Enable', 'on')
%     set(handles.XAxis, 'Enable', 'on')   
else
	selections.runIK =0;
    set(handles.plotResultsIK, 'Value', 0)
    set(handles.plotResultsIK, 'Enable', 'off')
    set(handles.LoadTemplateIK, 'Enable', 'off')
    set(handles.TamplateListIK, 'Enable', 'off')
    set(handles.plotALLIKResults, 'Enable', 'off')
    set(handles.plotALLIKResults, 'Value',0)
%     set(handles.XAxis, 'Enable', 'off')
    selections.plotIK=0;
    selections.plotALLIK=0;
end


% --- Executes on button press in plotResultsIK.
function plotResultsIK_Callback(hObject, eventdata, handles)
% hObject    handle to plotResultsIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotResultsIK

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.plotIK = 1;
    selections.plotALLIK = 0;
    set(handles.plotALLIKResults,'Value',0);
else
	selections.plotIK =0;
end


% --- Executes on button press in runMA.
function runMA_Callback(hObject, eventdata, handles)
% hObject    handle to runMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runMA
global selections
    
if (get(hObject,'Value') == get(hObject,'Max'))
	selections.runMA = 1;
    set(handles.plotStorageMA, 'Enable', 'on')
else
	selections.runMA =0;
    set(handles.plotStorageMA, 'Value', 0)
    set(handles.plotStorageMA, 'Enable', 'off')
    selections.plotMA=0;
end


% --- Executes on button press in plotStorageMA.
function plotStorageMA_Callback(hObject, eventdata, handles)
% hObject    handle to plotStorageMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotStorageMA
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.plotMA = 1;
else
	selections.plotMA =0;
end



% --- Executes on button press in runID.
function runID_Callback(hObject, eventdata, handles)
% hObject    handle to runID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runID

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.plotResultsID, 'Enable', 'on')
    set(handles.IDLowPass, 'Enable', 'on')
    set(handles.TamplateListID, 'Enable', 'on')
    set(handles.LoadTemplateID, 'Enable', 'on')
    set(handles.plotALLIDResults, 'Enable', 'on')
	selections.runID = 1;
    selections.TamplateListID = handles.TamplateListID.String(handles.TamplateListID.Value);
else
    set(handles.plotResultsID, 'Value', 0)
    set(handles.plotResultsID, 'Enable', 'off')
    set(handles.IDLowPass, 'Value', 0)
    set(handles.IDLowPass, 'Enable', 'off')
    set(handles.TamplateListID, 'Enable', 'off')
    set(handles.LoadTemplateID, 'Enable', 'off')
    set(handles.LoadTemplateID, 'Value', 0)
    set(handles.plotALLIDResults, 'Value', 0)
    set(handles.plotALLIDResults, 'Enable', 'off')
    selections.runID =0;
    selections.plotID=0;
    selections.plotALLID=0;
    selections.TamplateListID = 0;

end


% --- Executes on button press in plotResultsID.
function plotResultsID_Callback(hObject, eventdata, handles)
% hObject    handle to plotResultsID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotResultsID
global selections
if (get(hObject,'Value') == get(hObject,'Max'))
	selections.plotID = 1;
    selections.plotALLID = 0;
    set(handles.plotALLIDResults,'Value',0);
else
	selections.plotID =0;
end



% --- Executes on button press in runSO.
function runSO_Callback(hObject, eventdata, handles)
% hObject    handle to runSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runSO

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.plotStorageSO, 'Enable', 'on')
    set(handles.SOLowPass,'Enable', 'on')
    set(handles.TamplateListSO,'Enable', 'on')
    set(handles.LoadTemplateSO,'Enable', 'on')
    set(handles.LoadTemplateSO,'Value',0)
    set(handles.plotStorageSO,'Value',0)
    set(handles.plotALLSOResults,'Enable', 'on')
    set(handles.ActuatorsList,'Enable', 'on')
    set(handles.LoadActuadors,'Enable', 'on')
    set(handles.LoadActuadors,'Value',0)
    set(handles.SOPlotSetupList,'Enable','off')
    set(handles.LoadSOplotsetup,'Enable','off')
    set(handles.LoadSOplotsetup,'Value',0)
	selections.runSO = 1;
    selections.TamplateListSO = handles.TamplateListSO.String(handles.TamplateListSO.Value);
    selections.ActuatorsList = handles.ActuatorsList.String(handles.ActuatorsList.Value);
    selections.LoadActuadors = 0;
    selections.plotALLSO = 0;
    selections.plotSO=0;
    selections.SOPlotSetupList=0;
    selections.LoadSOplotsetup=0;
else
    set(handles.plotStorageSO, 'Value', 0)
    set(handles.plotStorageSO, 'Enable', 'off')
    set(handles.SOLowPass, 'Value', 0)
    set(handles.SOLowPass, 'Enable', 'off')
    set(handles.TamplateListSO,'Enable', 'off')
    set(handles.LoadTemplateSO,'Value',0)
    set(handles.LoadTemplateSO,'Enable', 'off')
    set(handles.plotStorageSO,'Enable', 'off')
    set(handles.plotALLSOResults,'Enable', 'off')
    set(handles.plotALLSOResults,'Value',0)
    set(handles.ActuatorsList,'Enable', 'off')
    set(handles.LoadActuadors,'Enable', 'off')
    set(handles.LoadActuadors,'Value',0)
    set(handles.SOPlotSetupList,'Enable','off')
    set(handles.LoadSOplotsetup,'Enable','off')
    set(handles.LoadSOplotsetup,'Value',0)
    set(handles.SOselectplot,'Enable','off')
    selections.runSO =0;
    selections.LoadTemplateSO =0;
    selections.TamplateListSO = 0;
    selections.LoadActuadors = 0;
    selections.plotSO=0;
    selections.plotALLSO=0;
    selections.SOPlotSetupList=0;
    selections.LoadSOplotsetup=0;
    selections.SOPlotSetupList=0;
end


% --- Executes on button press in plotStorageSO.
function plotStorageSO_Callback(hObject, eventdata, handles)
% hObject    handle to plotStorageSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotStorageSO

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.plotSO = 1;
    selections.plotALLSO = 0;
    set(handles.plotALLSOResults,'Value',0)
else
	selections.plotSO =0;
end
if (get(hObject,'Value') == get(hObject,'Max')) || selections.plotSO == 1
   set(handles.SOPlotSetupList,'Enable','on')
   set(handles.LoadSOplotsetup,'Enable','on')
   set(handles.SOselectplot,'Enable','on')
   selections.SOPlotSetupList=handles.SOPlotSetupList.String(handles.SOPlotSetupList.Value);
   selections.SOselectplot = handles.SOselectplot.String(handles.SOselectplot.Value);
   selections.LoadSOplotsetup=0;
else
   set(handles.SOPlotSetupList,'Enable','off')
   set(handles.LoadSOplotsetup,'Enable','off')
   set(handles.SOselectplot,'Enable','off')
   selections.SOPlotSetupList=0;
   selections.LoadSOplotsetup=0; 
   selections.SOselectplot=0;
end




% --- Executes on button press in selectTrialsMA.
function selectTrialsMA_Callback(hObject, eventdata, handles)
% hObject    handle to selectTrialsMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectTrialsMA

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.selectTrialsMA = 1;
else
	selections.selectTrialsMA =0;
end


% --- Executes on button press in selectXaxisMA.
function selectXaxisMA_Callback(hObject, eventdata, handles)
% hObject    handle to selectXaxisMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectXaxisMA

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.selectXaxisMA = 1; 
else
	selections.selectXaxisMA =0;
end



% --- Executes on button press in selectTrialsID.
function selectTrialsID_Callback(hObject, eventdata, handles)
% hObject    handle to selectTrialsID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectTrialsID

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.selectTrialsID = 1;
else
	selections.selectTrialsID =0;
end



% --- Executes on button press in selectCoordinatesToPlotID.
function selectCoordinatesToPlotID_Callback(hObject, eventdata, handles)
% hObject    handle to selectCoordinatesToPlotID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectCoordinatesToPlotID

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.selectCoordinatesToPlotID = 1;
else
	selections.selectCoordinatesToPlotID =0;
end



% --- Executes on button press in selectTrialsSO.
function selectTrialsSO_Callback(hObject, eventdata, handles)
% hObject    handle to selectTrialsSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectTrialsSO

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.selectTrialsSO = 1;
else
	selections.selectTrialsSO =0;
end


% --- Executes on button press in selectXaxisSO.
function selectXaxisSO_Callback(hObject, eventdata, handles)
% hObject    handle to selectXaxisSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectXaxisSO

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.selectXaxisSO = 1;
else
	selections.selectXaxisSO =0;
end



% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




function IDLowPass_Callback(hObject, eventdata, handles)
% hObject    handle to IDLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IDLowPass as text
%        str2double(get(hObject,'String')) returns contents of IDLowPass as a double

global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.IDLowPass = str2double(hObject.String);
else
	selections.IDLowPass =0;
end
if  (get(hObject,'String') == '0')
    selections.IDLowPass =0;
end



% --- Executes during object creation, after setting all properties.
function IDLowPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IDLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function SOLowPass_Callback(hObject, eventdata, handles)
% hObject    handle to SOLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SOLowPass as text
%        str2double(get(hObject,'String')) returns contents of SOLowPass as a double
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.SOLowPass = str2double(hObject.String);
else
	selections.SOLowPass =0;
end
if  (get(hObject,'String') == '0')
    selections.SOLowPass =0;
end

% --- Executes during object creation, after setting all properties.
function SOLowPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SOLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.SOLowPass = hObject;



% --- Executes on button press in LoadTemplateIK.
function LoadTemplateIK_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTemplateIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadTemplateIK
global selections
if (get(hObject,'Value') == get(hObject,'Max'))
	selections.LoadTemplateIK = 1;
    selections.TamplateListIK = 0;
    set(handles.TamplateListIK, 'Enable', 'off')
else
	selections.LoadTemplateIK = 0;
    selections.TamplateListIK = 1;
    set(handles.TamplateListIK, 'Enable', 'on')
end



% --- Executes on selection change in TamplateListIK.
function TamplateListIK_Callback(hObject, eventdata, handles)
% hObject    handle to TamplateListIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TamplateListIK contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TamplateListIK
global selections 
selections.TamplateListIK = hObject.String(hObject.Value);


% --- Executes during object creation, after setting all properties.
function TamplateListIK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TamplateListIK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','IKProcessing') filesep];   
listingIK = dir([TemplatePath,'*.xml']);
cd(originalPath)


% --- Executes on selection change in ListTrials.
function ListTrials_Callback(hObject, eventdata, handles)
% hObject    handle to ListTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListTrials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListTrials
clear trialsList
for w = 1:size(handles.ListTrials.Value')
    if isempty(hObject.String)
       disp(' ')
       disp('Please select the task and model')
       disp(' ')
       return
    end
    trialsList{w,1} = handles.ListTrials.String{handles.ListTrials.Value(w)};
end
% save([pwd,'\Private\trialsList'],'trialsList')


% --- Executes during object creation, after setting all properties.
function ListTrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Max',inf,'Min',0);


% --- Executes on button press in plotALLIKResults.
function plotALLIKResults_Callback(hObject, eventdata, handles)
% hObject    handle to plotALLIKResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotALLIKResults
global selections
if  (get(hObject,'Value') == get(hObject,'Max'))
    selections.plotALLIK = 1;
    selections.plotIK = 0;
    set(handles.plotResultsIK,'Value',0);
else
    selections.plotALLIK = 0;
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over plotALLIKResults.
function plotALLIKResults_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to plotALLIKResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in XAxis.
function XAxis_Callback(hObject, eventdata, handles)
% hObject    handle to XAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns XAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from XAxis
XAxis = hObject.String(hObject.Value);
global selections 
selections.XAxis = XAxis; 


% --- Executes during object creation, after setting all properties.
function XAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.XAxis = hObject;
x_labels={'% Analysis Window';'% Stance';'% Gait Cycle';'% time'; 'time [s]'};
set(handles.XAxis,'String',x_labels);


% --- Executes on selection change in TamplateListID.
function TamplateListID_Callback(hObject, eventdata, handles)
% hObject    handle to TamplateListID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TamplateListID contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TamplateListID
global selections 
selections.TamplateListID = hObject.String(hObject.Value);


% --- Executes during object creation, after setting all properties.
function TamplateListID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TamplateListID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','IDProcessing') filesep];   
listingID = dir([TemplatePath,'*.xml']);
listingID = {listingID.name}'; 
cd(originalPath)

handles.TamplateListID = hObject;
set(handles.TamplateListID,'String',listingID);



% --- Executes on button press in LoadTemplateSO.
function LoadTemplateID_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTemplateSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadTemplateSO
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.LoadTemplateID = 1;
    selections.TamplateListID = 0;
    set(handles.TamplateListID, 'Enable', 'off')
else
	selections.LoadTemplateID = 0;
    selections.TamplateListID = handles.TamplateListID.String(handles.TamplateListID.Value);
    set(handles.TamplateListID, 'Enable', 'on')
end


% --- Executes on button press in plotALLIDResults.
function plotALLIDResults_Callback(hObject, eventdata, handles)
% hObject    handle to plotALLIDResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotALLIDResults
% Hint: get(hObject,'Value') returns toggle state of plotALLIDResults
global selections
if  (get(hObject,'Value') == get(hObject,'Max'))
    selections.plotALLID = 1;
    selections.plotID = 0;
    set(handles.plotResultsID,'Value',0);
else
    selections.plotALLID = 0;
end


% --- Executes on selection change in TamplateListSO.
function TamplateListSO_Callback(hObject, eventdata, handles)
% hObject    handle to TamplateListSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TamplateListSO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TamplateListSO
global selections 
selections.TamplateListSO = hObject.String(hObject.Value);


% --- Executes during object creation, after setting all properties.
function TamplateListSO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TamplateListSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','StaticOptimization') filesep];   
listingSO = dir([TemplatePath,'*.xml']);
listingSO = {listingSO.name}'; 
cd(originalPath)

set(hObject,'String',listingSO)
handles.TamplateListSO = listingSO;

% --- Executes on button press in LoadTemplateSO.
function LoadTemplateSO_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTemplateSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadTemplateSO
global selections
if (get(hObject,'Value') == get(hObject,'Max'))
	selections.LoadTemplateSO = 1;
    selections.TamplateListSO = 0;
    set(handles.TamplateListSO, 'Enable', 'off')
else
	selections.LoadTemplateSO = 0;
    selections.TamplateListSO = handles.TamplateListSO.String(handles.TamplateListSO.Value);
    set(handles.TamplateListSO, 'Enable', 'on')
end


% --- Executes on button press in plotALLSOResults.
function plotALLSOResults_Callback(hObject, eventdata, handles)
% hObject    handle to plotALLSOResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotALLSOResults
global selections
if  (get(hObject,'Value') == get(hObject,'Max'))
    selections.plotALLSO = 1;
    selections.plotSO = 0;
    set(handles.plotStorageSO,'Value',0);
else
    selections.plotALLSO = 0;
end
if (get(hObject,'Value') == get(hObject,'Max')) || selections.plotSO == 1
   set(handles.SOPlotSetupList,'Enable','on')
   set(handles.LoadSOplotsetup,'Enable','on')
   set(handles.SOselectplot,'Enable','on')
   selections.SOPlotSetupList=handles.SOPlotSetupList.String(handles.SOPlotSetupList.Value);
   selections.SOselectplot = handles.SOselectplot.String(handles.SOselectplot.Value);
   selections.LoadSOplotsetup=0;
else
   set(handles.SOPlotSetupList,'Enable','off')
   set(handles.LoadSOplotsetup,'Enable','off')
   set(handles.SOselectplot,'Enable','off')
   selections.SOPlotSetupList=0;
   selections.LoadSOplotsetup=0; 
   selections.SOselectplot=0;
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over plotALLSOResults.
function plotALLSOResults_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to plotALLSOResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in ActuatorsList.
function ActuatorsList_Callback(hObject, eventdata, handles)
% hObject    handle to ActuatorsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ActuatorsList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ActuatorsList
global selections 
selections.ActuatorsList = hObject.String(hObject.Value);


% --- Executes during object creation, after setting all properties.
function ActuatorsList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ActuatorsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','StaticOptimization') filesep];   
listingActuators = dir([TemplatePath,'*.xml']);
listingActuators = {listingActuators.name}'; 
cd(originalPath)

handles.ActuatorsList = hObject;
set(handles.ActuatorsList,'String',listingActuators);



% --- Executes on button press in LoadActuadors.
function LoadActuadors_Callback(hObject, eventdata, handles)
% hObject    handle to LoadActuadors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadActuadors
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.LoadActuadors = 1;
    selections.ActuatorsList = 0;
    set(handles.ActuatorsList, 'Enable', 'off')
else
	selections.LoadActuadors = 0;
    selections.ActuatorsList = handles.ActuatorsList.String(handles.ActuatorsList.Value);
    set(handles.ActuatorsList, 'Enable', 'on')
end


% --- Executes on selection change in SOPlotSetupList.
function SOPlotSetupList_Callback(hObject, eventdata, handles)
% hObject    handle to SOPlotSetupList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SOPlotSetupList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SOPlotSetupList
global selections 
selections.SOPlotSetupList = hObject.String(hObject.Value);


% --- Executes during object creation, after setting all properties.
function SOPlotSetupList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SOPlotSetupList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','PlotStorage') filesep];   
listingSOPlotSetup = dir([TemplatePath,'*.xml']);
listingSOPlotSetup = {listingSOPlotSetup.name}'; 
cd(originalPath)

handles.SOPlotSetupList = hObject;
set(handles.SOPlotSetupList,'String',listingSOPlotSetup)


% --- Executes on button press in LoadSOplotsetup.
function LoadSOplotsetup_Callback(hObject, eventdata, handles)
% hObject    handle to LoadSOplotsetup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadSOplotsetup
global selections
if (get(hObject,'Value') == get(hObject,'Max'))
	selections.LoadTemplateSO = 1;
    selections.SOPlotSetupList = 0;
    set(handles.SOPlotSetupList, 'Enable', 'off')
else
	selections.LoadTemplateSO = 0;
    selections.SOPlotSetupList = handles.SOPlotSetupList.String(handles.SOPlotSetupList.Value);
    set(handles.SOPlotSetupList, 'Enable', 'on')
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over LoadSOplotsetup.
function LoadSOplotsetup_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to LoadSOplotsetup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in SOselectplot.
function SOselectplot_Callback(hObject, eventdata, handles)
% hObject    handle to SOselectplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SOselectplot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SOselectplot
global selections 
selections.SOselectplot = hObject.String(hObject.Value);


% --- Executes during object creation, after setting all properties.
function SOselectplot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SOselectplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

listingSOPlotSetup = {'Force','Activation'}';
handles.SOPlotSetupList = hObject;
set(handles.SOPlotSetupList,'String',listingSOPlotSetup)


% --- Executes on selection change in TamplateListJRF.
function TamplateListJRF_Callback(hObject, eventdata, handles)
% hObject    handle to TamplateListJRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TamplateListJRF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TamplateListJRF
global selections 
selections.TamplateListJRF = hObject.String(hObject.Value);


% --- Executes during object creation, after setting all properties.
function TamplateListJRF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TamplateListJRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','\JointReaction') filesep];   
listingJRFTample = dir([TemplatePath,'*.xml']);
listingJRFTample = {listingJRFTample.name}'; 
cd(originalPath)

handles.TamplateListJRF = hObject;
set(handles.TamplateListJRF,'String',listingJRFTample);

% --- Executes on button press in LoadTemplateJRA.
function LoadTemplateJRA_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTemplateJRA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadTemplateJRA
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.LoadTemplateJRA = 1;
    selections.TamplateListJRF = 0;
    set(handles.TamplateListJRF, 'Enable', 'off')
else
	selections.LoadTemplateJRA = 0;
    selections.TamplateListJRF = handles.TamplateListJRF.String(handles.TamplateListJRF.Value);
    set(handles.TamplateListJRF, 'Enable', 'on')
end


% --- Executes on button press in runJRA.
function runJRA_Callback(hObject, eventdata, handles)
% hObject    handle to runJRA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runJRA
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.TamplateListJRF, 'Enable', 'on')
    set(handles.LoadTemplateJRA, 'Enable', 'on')
    set(handles.plotStorageJRA, 'Enable', 'on')
    set(handles.plotALLJRAResults, 'Enable', 'on')
    set(handles.plotALLJRAResults,'Value',0)
    set(handles.JRALowPass,'Enable','on')
    selections.runJRA = 1;
    selections.LoadTemplateJRA = 0;
    selections.plotALLJRA=0;
    selections.plotJRA = 0; 
else
    set(handles.TamplateListJRF, 'Enable','off')
    set(handles.LoadTemplateJRA, 'Enable','off')
    set(handles.plotStorageJRA, 'Enable','off')
    set(handles.plotALLJRAResults, 'Enable','off')
    set(handles.plotStorageJRA, 'Value',0)
    set(handles.plotALLJRAResults, 'Value',0)
    set(handles.JRALowPass,'Enable','off')
	selections.runJRA = 0;
    selections.LoadTemplateJRA = 0;
    selections.plotALLJRA = 0;
    selections.plotJRA = 0; 
end


% --- Executes on button press in plotALLJRAResults.
function plotALLJRAResults_Callback(hObject, eventdata, handles)
% hObject    handle to plotALLJRAResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotALLJRAResults
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.plotJRA = 0;
    selections.plotALLJRA = 1;
    set(handles.plotStorageJRA,'Value',0)
else
	selections.plotALLJRA =0;
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over plotALLJRAResults.
function plotALLJRAResults_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to plotALLJRAResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in plotStorageJRA.
function plotStorageJRA_Callback(hObject, eventdata, handles)
% hObject    handle to plotStorageJRA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotStorageJRA
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.plotJRA = 1;
    selections.plotALLJRA = 0;
    set(handles.plotALLJRAResults,'Value',0)
else
	selections.plotJRA =0;
end



function JRALowPass_Callback(hObject, eventdata, handles)
% hObject    handle to JRALowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of JRALowPass as text
%        str2double(get(hObject,'String')) returns contents of JRALowPass as a double
global selections

if (get(hObject,'Value') == get(hObject,'Max'))
	selections.JRALowPass = str2double(hObject.String);
else
	selections.JRALowPass =-1;
end
if  (get(hObject,'String') == '-1')
    selections.JRALowPass =-1;
end



% --- Executes during object creation, after setting all properties.
function JRALowPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to JRALowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.JRALowPass = hObject;


% --- Executes on button press in BOPSInf.
function BOPSInf_Callback(hObject, eventdata, handles)
% hObject    handle to BOPSInf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run([pwd filesep 'private' filesep 'BOPSInf.m'])
